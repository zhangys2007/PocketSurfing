
#import "EveryoneBuyCollectionVC.h"
#import "Header.h"
#import "HomepageReuseCollectionCell.h"
#import "NetWorkInterfaceBlock.h"
#import "Public_WebView_ViewController.h"
@interface EveryoneBuyCollectionVC ()
@property (nonatomic, retain)NSMutableArray * dataArray;
@property(nonatomic, retain)NSMutableArray * likeDataArray;
@end

@implementation EveryoneBuyCollectionVC
- (void)dealloc
{
    self.dataArray = nil;
    self.likeDataArray = nil;
    [super dealloc];
}
static NSString * const reuseIdentifier = @"EveryoneBuyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[HomepageReuseCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    HomepageReuseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.dataModel = [self.dataArray objectAtIndex:indexPath.row];
    // Configure the cell
    cell.delegate = self;
    return cell;
}

#pragma mark- 加载数据
//载入新数据
-(void)loadNewData
{
    [self loadDataWithPage:0];
}
////载入更多数据,子类重写方法
//-(void)loadMoreData
//{
//    self.isRefresh = NO;
//    [self loadDataWithPage:++self.pageNum];
//}
-(void)loadDataWithPage:(NSInteger)pageNumber
{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc]initWithSuccessful:^(NSDictionary *dic) {
        //        NSLog(@"%@",dic);
        
        NSArray * resultArr = [dic objectForKey:@"list"];
        for (NSDictionary * dataDic  in resultArr) {
            HomePageReuseCellData * dataModel = [[HomePageReuseCellData alloc]initWithDic:dataDic];
            [self.dataArray addObject:dataModel];
            [dataModel release];
        }
        [self.collectionView reloadData];
    } fail:^BOOL(NSError *error) {
        return YES;
    }]autorelease];
    [netWork get:[NSString stringWithFormat:@"http://zhekou.repai.com/lws/model/paiming.php?lei=jkj"]];
}


//懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
-(NSMutableArray *)likeDataArray
{
    if (_likeDataArray ==nil) {
        self.likeDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _likeDataArray;
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
    [keyedArchiver encodeObject:_likeDataArray forKey:@"Array"];
    [keyedArchiver finishEncoding];
    [data writeToFile:[@"likeGoodsHistory" documentsFilePath] atomically:YES];

    for (HomePageReuseCellData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.num_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
}
//解档
-(void)unarchiverMethod
{
    //文件路径
    NSString * filePath = [@"likeGoodsHistory" documentsFilePath];
    //    NSLog(@"%@",filePath);
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    _likeDataArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
//    NSLog(@"%@",_likeDataArray);

    
}
#pragma mark 点击"like" 和"相似"

-(void)likeBtnClick:(HomePageReuseCellData *)data cell:(id)cell
{
    //把对象放入收藏数组，先判断是否存在
    BOOL isExist = NO;
    for (HomePageReuseCellData * likeData in self.likeDataArray) {
        if ([likeData.num_iid isEqualToString:data.num_iid]) {
            isExist = YES;
        }
    }
    if (!isExist) {
        //把从cell传过来的数据对象放入数组
        [self.likeDataArray addObject:data];
    }
    //把收藏数加1
    for (HomePageReuseCellData * thisData in _dataArray) {
        if ([thisData.num_iid isEqualToString:data.num_iid]) {
            thisData.total_love_number = [NSString stringWithFormat:@"%d",[thisData.total_love_number integerValue]+1];
            thisData.isLike = YES;
        }
    }
    //归档
    [self archiveMethod];
    //重新刷新当前 dataArray数据（修改是否被收藏）
    for (HomePageReuseCellData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.num_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
    [self.collectionView reloadData];
}
-(void)similarBtnClick:(UIButton *)btn
{
//    NSLog(@"similarBtnClick");
}
#pragma mark- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    HomePageReuseCellData * model = self.dataArray[indexPath.row];
    webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",model.num_iid];
    [self.navigationController pushViewController:webView animated:YES];

    
}
#pragma mark- 视图将要出现
-(void)viewWillAppear:(BOOL)animated
{
    
    [self unarchiverMethod];
    for (HomePageReuseCellData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.num_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
    [self.collectionView reloadData];
    self.tabBarController.tabBar.hidden = YES;
}
//视图消失时候的方法
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
