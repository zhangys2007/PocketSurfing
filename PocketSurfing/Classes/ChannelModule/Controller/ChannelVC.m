

#import "ChannelVC.h"
#import "Channel_CustomCell.h"
#import "NetWorkInterfaceBlock.h"
#import "Channel_Content.h"
#import "Public_WebView_ViewController.h"
#import "AddChannelViewController.h"
#import "NSString+filePath.h"
#import "Header.h"
#define CELL_INDENTIFIER @"ChannlecellIdentifier"
@interface ChannelVC ()

@end

@implementation ChannelVC

- (void)dealloc
{
    self.collectionView = nil;
    self.dataArray = nil;
    self.indexArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"流行主题吧";
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 100;
    // Register cell classes
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //每个方块的大小
    //flowLayout.itemSize = CGSizeMake(70, 90);
    
    //滚动的方向,横向和纵向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //滚动方向的间隔
    flowLayout.minimumInteritemSpacing = SCREEN_AUTO_SIZE 5;
    //另一方向的间隔
    flowLayout.minimumLineSpacing = SCREEN_AUTO_SIZE 10;
    //section之间的间隔
    //    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [flowLayout release];
    [self.view addSubview:_collectionView];
    
    //给集合视图注册一个类型的cell
    [_collectionView registerClass:[Channel_CustomCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [_collectionView release];
    
    [self loadNewData];
    
}


//解档
-(void)unarchiverMethod
{
    self.indexArray = nil;
    //文件路径
    NSString * filePath = [@"ChannelHistory" documentsFilePath];
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    _indexArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
    //NSLog(@"%@",_indexArray);
}

- (void)loadNewData{
    self.dataArray = nil;
    [self unarchiverMethod];
    
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSDictionary *dic) {
        NSArray * array = [dic objectForKey:@"add_list"];
        for (NSDictionary * channel_Contentdic in array) {
            Channel_Content * channel_Content = [[Channel_Content alloc] initWithDictionary:channel_Contentdic];
            for (int i = 0; i < _indexArray.count; i++) {
                if ([channel_Content.idString isEqualToString:((Channel_Content *)_indexArray[i]).idString] ) {
                    [self.dataArray addObject:channel_Content];
                }
            }
            [channel_Content release];
        }
        
        Channel_Content * chan =[[Channel_Content alloc]init];
        chan.name = @"添加新主题";
        chan.logo_2x = @"http://app.api.yijia.com/tb99/iphone/images/add@2x.png";
        [self.dataArray addObject:chan];
        [self.collectionView reloadData];
        
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    
    NSString * urlString  = @"http://app.api.yijia.com/tb99/iphone/apphome.php?appid=80cb7b1a68a5c350a419fb5e0c310cccd9d0c0e8";
    [netWork get:urlString];
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 90);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 5);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Channel_CustomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    cell.channel_Content = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelagate>
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray.count-1) {
        [self goToAddPage];
    }else{
        Public_WebView_ViewController * publicWebViewVC = [[Public_WebView_ViewController alloc] init];
        publicWebViewVC.title = ((Channel_Content *)[self.dataArray objectAtIndex:indexPath.row]).name;
        publicWebViewVC.urlString = ((Channel_Content *)[self.dataArray objectAtIndex:indexPath.row]).url;
        publicWebViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
}

- (void)goToAddPage{
    AddChannelViewController * addChannelVC = [[AddChannelViewController alloc] init];
    UINavigationController * nva = [[UINavigationController alloc] initWithRootViewController:addChannelVC];
    addChannelVC.channleVC = self;
    nva.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nva animated:YES completion:^{//模态(从下往上)
        //NSLog(@"presentController");
        //addChannelVC.addChannelCell.delegate = self;//代理安全存放位置
    }];
    [addChannelVC release];
    [nva release];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray =[NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

//懒加载
-(NSMutableArray *)indexArray
{
    if (!_indexArray) {
        self.indexArray =[NSMutableArray arrayWithCapacity:1];
    }
    return _indexArray;
}


@end
