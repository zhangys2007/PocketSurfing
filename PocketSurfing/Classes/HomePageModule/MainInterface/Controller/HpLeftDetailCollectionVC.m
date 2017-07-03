

#import "HpLeftDetailCollectionVC.h"
#import "HomepageReuseCollectionCell.h"
#import "Header.h"
#import "NetWorkInterfaceBlock.h"
#import "HomePageReuseCellData.h"
#import "Public_WebView_ViewController.h"

//左侧视图的Cell推出的详情页面VC
@interface HpLeftDetailCollectionVC ()
@property(nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray * likeDataArray;
@property (nonatomic, retain)UIImageView * refreshImageView;
@end

@implementation HpLeftDetailCollectionVC
- (void)dealloc
{
    self.dataArray = nil;
    self.likeDataArray = nil;
    self.refreshImageView = nil;
    [super dealloc];
}
static NSString * const reuseIdentifier = @"HpLeftDetailCell";

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[HomepageReuseCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //下拉刷新
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        
        self.collectionView.header.updatedTimeHidden = YES;
        // 隐藏状态
        self.collectionView.header.stateHidden = YES;
        self.refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_SIZE_WIDTH-SCREEN_AUTO_SIZE 50)/2, SCREEN_SIZE_HEIGHT*0.4, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 50)];
        _refreshImageView.layer.masksToBounds = YES;
        _refreshImageView.image = [UIImage imageNamed:@"newLoading.png"];
        [self.view addSubview:_refreshImageView];
        [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(rotateImage) userInfo:nil repeats:YES];
        //下拉刷新的调用
        [self loadNewData];
    }];
    //立即刷新数据
    [self.collectionView.header beginRefreshing];
    
    
}
#pragma mark- 下拉刷新时候的圆圈
- (void)rotateImage{
    self.refreshImageView.transform = CGAffineTransformRotate(self.refreshImageView.transform, M_PI_4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//载入新数据
-(void)loadNewData
{
    [self loadDataWithPage:self.pageNumber];
}

-(void)loadDataWithPage:(NSInteger)pageNumber
{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc]initWithSuccessful:^(NSDictionary *dic) {

        
        NSArray * resultArr = [dic objectForKey:@"list"];
        for (NSDictionary * dataDic  in resultArr) {
            HomePageReuseCellData * dataModel = [[HomePageReuseCellData alloc]initWithDic:dataDic];
            [self.dataArray addObject:dataModel];
            [dataModel release];
        }
        //结束下拉刷新
        [self.collectionView.header endRefreshing];
        [self.refreshImageView removeFromSuperview];
        [self.collectionView reloadData];
        //解档数据并判断是否被收藏
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
    } fail:^BOOL(NSError *error) {
        return YES;
    }]autorelease];
    [netWork get:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/list_api.php?app_id=1066136336&app_oid=b7546dbfd0cc03c8b63330a64bb59f0e29e9c944&app_version=2.5.3&app_channel=appstore&cid=%ld",(long)pageNumber]];
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
            thisData.total_love_number = [NSString stringWithFormat:@"%ld",[thisData.total_love_number integerValue]+1];
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
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        
//    });
}
-(void)similarBtnClick:(UIButton *)btn
{
//    NSLog(@"similarBtnClick");
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
    cell.delegate = self;
    
    return cell;
}


#pragma mark- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    HomePageReuseCellData * model = self.dataArray[indexPath.row];
    webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",model.num_iid];
    [self.navigationController pushViewController:webView animated:YES];


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
