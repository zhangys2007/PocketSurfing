

#import "TomorrowCollectionViewController.h"
#import "TomorrowCell.h"
#import "TomorrowCellData.h"
#import "TomorrowModalController.h"
#import "NetWorkInterfaceBlock.h"
#import "NSString+filePath.h"
#import "Header.h"
@interface TomorrowCollectionViewController ()
@property(nonatomic, retain)NSMutableArray * dataArray;
@property(nonatomic, retain)NSMutableArray * remindArray;
@end

@implementation TomorrowCollectionViewController
- (void)dealloc
{
    self.remindArray = nil;
    self.dataArray = nil;
    [super dealloc];
}
static NSString * const reuseIdentifier = @"TomorrowCollectionCell";
-(void)viewWillAppear:(BOOL)animated
{
    //解档
    [self unarchiverMethod];
    //刷新UI
    [self.collectionView reloadData];
    self.tabBarController.tabBar.hidden = YES;
}
//视图消失时候的方法
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[TomorrowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self loadNewData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TomorrowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.dataModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark- 加载数据
//载入新数据
-(void)loadNewData
{
    [self loadDataWithPage:0];
}

-(void)loadDataWithPage:(NSInteger)pageNumber
{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc]initWithSuccessful:^(NSDictionary *dic) {
        //        NSLog(@"%@",dic);
        
        NSArray * resultArr = [dic objectForKey:@"list"];
        for (NSDictionary * dataDic  in resultArr) {
            TomorrowCellData * dataModel = [[TomorrowCellData alloc]initWithDic:dataDic];
            [self.dataArray addObject:dataModel];
            [dataModel release];
        }
        [self.collectionView reloadData];
    } fail:^BOOL(NSError *error) {
        return YES;
    }]autorelease];
    [netWork get:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tomorrow_api.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore"]];
}


//懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
-(NSMutableArray *)remindArray
{
    if (_remindArray ==nil) {
        self.remindArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _remindArray;
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //加载详情视图
    TomorrowModalController * modal = [[TomorrowModalController alloc]initWIthDataModel:self.dataArray[indexPath.row]];
    modal.view.frame = CGRectMake(0, -1* SCREEN_SIZE_HEIGHT, SCREEN_AUTO_SIZE 320, SCREEN_SIZE_HEIGHT);
    modal.controller = self;
    [self.navigationController.view addSubview:modal.view];
    [UIView animateWithDuration:0.5 animations:^{
        modal.view.frame = CGRectMake(0, 0, SCREEN_SIZE_WIDTH,SCREEN_SIZE_HEIGHT);
    }];
}
#pragma mark 提醒btn按下的方法
-(void)remindBtnClick:(TomorrowCellData *)remindData
{
    //把对象放入收藏数组，先判断是否存在
    BOOL isExist = NO;
    for (TomorrowCellData * oldData in self.remindArray) {
        if ([oldData.num_iid isEqualToString:remindData.num_iid]) {
            isExist = YES;
        }
    }
    if (!isExist) {
        //把从cell传过来的数据对象放入数组
        [self.remindArray addObject:remindData];
    }
    //重新刷新当前 dataArray数据（修改是否提醒）
    for (TomorrowCellData *netData in self.dataArray) {
        netData.isRemind = NO;
        for (TomorrowCellData * oldData in self.remindArray) {
            if ([oldData.num_iid isEqualToString:netData.num_iid]) {
                netData.isRemind = YES;
                continue;
            }
        }
    }
    //刷新collectionView的数据
    [self.collectionView reloadData];
    [self archiveMethod];
    
}
#pragma mark 归档解档
//归档
-(void)archiveMethod
{
    //创建一个data容器
    NSMutableData * data = [NSMutableData dataWithCapacity:1];
    //创建一个归档器
    NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //归档
    [keyedArchiver encodeObject:_remindArray forKey:@"Array"];
    [keyedArchiver finishEncoding];
    [data writeToFile:[@"remindGoodsHistory" documentsFilePath] atomically:YES];
}
//解档
-(void)unarchiverMethod
{
    //文件路径
    NSString * filePath = [@"remindGoodsHistory" documentsFilePath];
    //    NSLog(@"%@",filePath);
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    _remindArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
//    NSLog(@"%@",_remindArray);

    //重新刷新当前 dataArray数据（修改是否提醒）
    for (TomorrowCellData *netData in self.dataArray) {
        netData.isRemind = NO;
        for (TomorrowCellData * oldData in self.remindArray) {
            if ([oldData.num_iid isEqualToString:netData.num_iid]) {
                netData.isRemind = YES;
                continue;
            }
        }
    }
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
