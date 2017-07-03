

#import "AddChannelViewController.h"
#import "NetWorkInterfaceBlock.h"
#import "UIScrollView+MJRefresh.h"
#import "Channel_CustomCell.h"
#import "Channel_Content.h"
#import "ChannelVC.h"
#import "NSString+filePath.h"
#import "Header.h"
#define CELL_INDENTIFIER @"cellIdentifier"


@interface AddChannelViewController ()

@end

@implementation AddChannelViewController
- (void)dealloc
{
    self.collectionView = nil;
    self.dataArray = nil;
    self.indexArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订阅主题";

    
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 100;
    // Register cell classes
    [self.navigationController reloadInputViews];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"exit_btn_HD.png"] style:UIBarButtonItemStyleDone target:self action:@selector(exitData)] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ok.png"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData)] autorelease];
    
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];

    //滚动的方向,横向和纵向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //滚动方向的间隔
    flowLayout.minimumInteritemSpacing = SCREEN_AUTO_SIZE 5;
    //另一方向的间隔
    flowLayout.minimumLineSpacing = SCREEN_AUTO_SIZE 10;
    //section之间的间隔

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [flowLayout release];
    [self.view addSubview:_collectionView];
    
    //给集合视图注册一个类型的cell
    [_collectionView registerClass:[Channel_CustomCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [_collectionView release];
    
    //解档
    [self unarchiverMethod];
    
    [self loadNewData];
}

- (void)exitData{
   [self dismissViewControllerAnimated:YES completion:^{

   }];
}

- (void)saveData{
    [self dismissViewControllerAnimated:YES completion:^{
        //归档
        [self archiveMethod];

        //刷新
        [_channleVC viewDidLoad];

    }];

}
//归档
-(void)archiveMethod
{

    //创建一个data容器
    NSMutableData * data = [NSMutableData dataWithCapacity:1];
    //创建一个归档器
    NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //归档
    [keyedArchiver encodeObject:_indexArray forKey:@"Array"];
    [keyedArchiver finishEncoding];
    [data writeToFile:[@"ChannelHistory" documentsFilePath] atomically:YES];
    NSLog(@"%@",_indexArray);
}

-(void)unarchiverMethod
{
    self.indexArray = nil;
    //文件路径
    NSString * filePath = [@"ChannelHistory" documentsFilePath];
    //NSLog(@"%@",filePath);
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    _indexArray = [keyedUnarchiver decodeObjectForKey:@"Array"];

}

//下拉刷新
- (void)loadNewData{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSDictionary *dic) {
        NSArray * array = [dic objectForKey:@"add_list"];
        for (NSDictionary * addChanneldic in array) {
            Channel_Content * channel_Content = [[Channel_Content alloc] initWithDictionary:addChanneldic];
            [self.dataArray addObject:channel_Content];
            [channel_Content release];
        }
            [_collectionView reloadData];
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    
    NSString * urlString  = @"http://app.api.yijia.com/tb99/iphone/apphome.php?appid=80cb7b1a68a5c350a419fb5e0c310cccd9d0c0e8";
    [netWork get:urlString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    BOOL isExist = NO;
    for (Channel_Content * channelContent in _indexArray) {
        if ([channelContent.idString isEqualToString:cell.channel_Content.idString]) {
            isExist = YES;
        }
    }
    if (isExist) {
        cell.logoIV.layer.borderWidth = SCREEN_AUTO_SIZE 2.0;
        cell.logoIV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }else{
        cell.logoIV.layer.borderWidth = 0;
    }


        
        
        
    
//    if ([_indexArray containsObject:cell.channel_Content.idString]) {
//        cell.logoIV.layer.borderWidth = SCREEN_AUTO_SIZE 2.0;
//        cell.logoIV.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    }else{
//        cell.logoIV.layer.borderWidth = 0;
//    }


    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelagate>
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Channel_Content * addchan = self.dataArray[indexPath.row];
    BOOL isExist = NO;
    for (int i = 0; i<_indexArray.count; i++) {
        Channel_Content * channelContent = _indexArray[i];
        if ([channelContent.idString isEqualToString:addchan.idString]) {
            isExist = YES;
            [self.indexArray removeObject:channelContent];
        }
    }

    if (!isExist) {
        [self.indexArray addObject:addchan];
    }
    [self archiveMethod];
    [self unarchiverMethod];
  [self.collectionView reloadData];

}




//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
