
#import "HomePageVC.h"
#import "Header.h"
#import "HpHeaderButtonView.h"
#import "Public_WebView_ViewController.h"
#import "HomeFocusScrollView.h"
#import "NetWorkInterfaceBlock.h"
#import "EveryoneBuyCollectionVC.h"
#import "WorthToBuyController.h"
#import "MyFlowLayout.h"
#import "HomepageReuseCollectionCell.h"
#import "RandomCollectionViewController.h"
#import "TomorrowCollectionViewController.h"
#import "MJRefresh.h"
#import "NSString+filePath.h"
#define CELL_INDENTIFIER @"homePageReuseCollectionCell"
#define SCROLLVIEW_IMG_URL @"iphonemimg"
#define SCROLLVIEW_LINK @"link"
@interface HomePageVC ()
@property (nonatomic, retain)NSMutableDictionary * scrollViewDataDic;
@property (nonatomic, retain)UICollectionView * collectionView;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)UIImageView * refreshImageView;
@property (nonatomic, retain)NSMutableArray * likeDataArray;
@property (nonatomic, retain)HomeFocusScrollView * homeFocusScrollView;
@property (nonatomic, retain)UIPageControl *pageControl;
@property (nonatomic, retain)UIButton * toTopButton;
@property (nonatomic, retain)UIButton * leftDrawerButton;
@end

@implementation HomePageVC
- (void)dealloc
{
    self.scrollViewDataDic = nil;
    self.collectionView = nil;
    self.dataArray = nil;
    self.refreshImageView = nil;
    self.likeDataArray = nil;
    self.homeFocusScrollView = nil;
    self.pageControl=  nil;
    [super dealloc];
}
-(void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"viewDidAppear");
    //得到我们已经创建的这个抽屉对象
    DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
    [myDrawer.pan setEnabled:YES];
    [self.collectionView reloadData];
}
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;

    //配置navigation的左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"category-button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(handleClickLeftViewController:)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"category-button.png"];
    
    
    //Configure CollectionView
    MyFlowLayout * flowLayout = [[MyFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //collectionView的背景色
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //给集合视图注册一个类型的cell
    [_collectionView registerClass:[HomepageReuseCollectionCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    //修改connectionView的显示位置 ()
    _collectionView.contentInset = UIEdgeInsetsMake(SCREEN_AUTO_SIZE 275, 0, 0, 0);
    [flowLayout release];
    [self.view addSubview:_collectionView];
    

    //加载轮播图
    [self loadScrollView];

    // 添加 header button view视图
    HpHeaderButtonView * headerView = [[HpHeaderButtonView alloc]initWithFrame:CGRectMake(0,SCREEN_AUTO_SIZE -170, SCREEN_SIZE_WIDTH, SCREEN_AUTO_SIZE 170)];
    // Appoint the delegate of header button view
    headerView.delegate = self;
    [_collectionView addSubview:headerView];
    [headerView release];

    //下拉刷新
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{


        self.refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_SIZE_WIDTH-SCREEN_AUTO_SIZE 50)/2, SCREEN_SIZE_HEIGHT*0.4 - SCREEN_AUTO_SIZE 275,SCREEN_AUTO_SIZE 50,SCREEN_AUTO_SIZE 50)];
        _refreshImageView.layer.masksToBounds = YES;
        _refreshImageView.image = [UIImage imageNamed:@"newLoading.png"];
        [self.collectionView addSubview:_refreshImageView];
        [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(rotateImage) userInfo:nil repeats:YES];
        //下拉刷新的调用
        [self loadNewData];
    }];
    //立即刷新数据
    [self.collectionView.header beginRefreshing];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nstimerChangPage) userInfo:nil repeats:YES];
    
    //回到顶部按钮
    self.toTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _toTopButton.frame = CGRectMake(SCREEN_AUTO_SIZE 270, SCREEN_SIZE_HEIGHT - SCREEN_AUTO_SIZE 160, 40, 40);
    [_toTopButton setBackgroundImage:[UIImage imageNamed:@"home_back_top_hover.png"] forState:UIControlStateNormal];
    [_toTopButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];

    //打开抽屉按钮
    self.leftDrawerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftDrawerButton.frame = CGRectMake(SCREEN_AUTO_SIZE 270, SCREEN_SIZE_HEIGHT - SCREEN_AUTO_SIZE 210, 40, 40);
    [_leftDrawerButton setBackgroundImage:[UIImage imageNamed:@"icon_float_category_search_hover.png"] forState:UIControlStateNormal];
    [_leftDrawerButton addTarget:self action:@selector(openLeftDrawer) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
#pragma mark- 下拉刷新时候的圆圈
- (void)rotateImage{
    self.refreshImageView.transform = CGAffineTransformRotate(self.refreshImageView.transform, M_PI_4);
}
#pragma mark- 加载轮播图
- (void)loadScrollView
{
    //初始化存放滚动视图的数据字典
    self.scrollViewDataDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [_scrollViewDataDic setObject:[NSMutableArray arrayWithCapacity:1] forKey:SCROLLVIEW_IMG_URL];
    [_scrollViewDataDic setObject:[NSMutableArray arrayWithCapacity:1] forKey:SCROLLVIEW_LINK];
    //网络请求数据
    NetWorkInterfaceBlock * scrollViewNetwork = [[NetWorkInterfaceBlock alloc]initWithSuccessful:^(NSDictionary *dic) {
        //请求成功
        NSArray * array = [dic objectForKey:@"data"];
        for (NSDictionary * dataDic in array) {
            [[self.scrollViewDataDic objectForKey:SCROLLVIEW_IMG_URL]addObject:[dataDic objectForKey:SCROLLVIEW_IMG_URL]];
            [[self.scrollViewDataDic objectForKey:SCROLLVIEW_LINK]addObject:[dataDic objectForKey:SCROLLVIEW_LINK]];
        }
        
        // 添加 scrollView
        self.homeFocusScrollView = [[HomeFocusScrollView alloc]initWithFrame:CGRectMake(0,-1 *(SCREEN_AUTO_SIZE 275),SCREEN_AUTO_SIZE 320,SCREEN_AUTO_SIZE 105)];
        _homeFocusScrollView.focusDelegate = self;
        _homeFocusScrollView.delegate = self;
        _homeFocusScrollView.backgroundColor = [UIColor whiteColor];
        //把数据存入homePageScrollView的对应数组
        _homeFocusScrollView.picURLArray = [self.scrollViewDataDic objectForKey:SCROLLVIEW_IMG_URL];
        [self.collectionView addSubview:_homeFocusScrollView];
        
        
         self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake( SCREEN_AUTO_SIZE 20, _homeFocusScrollView.bottom- SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 280, SCREEN_AUTO_SIZE 20)];
        //总页数
        _pageControl.numberOfPages = _homeFocusScrollView.picURLArray.count;
        //当前页颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        //关联方法
//        [_pageControl addTarget:self action:@selector(changePageValue:) forControlEvents:UIControlEventValueChanged];
        //当前页颜色
        //其他页颜色
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.tag = 200;
        [self.collectionView addSubview:_pageControl];
        [_pageControl release];
        
        
    } fail:^BOOL(NSError *error) {
//        NSLog(@"网络连接错误");
        return YES;
    }];
    [scrollViewNetwork get:@"http://cloud.repaiapp.com/yunying/spzt.php?id=9&app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.1&app_channel=appstore&sche=fenjiujiu"];
    
    
}
#pragma mark- 配置轮播图以及返回顶部按钮
//轮播图只要滚动就一直调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView == _homeFocusScrollView) {
        //如果是轮播图滚动
        int halfX = scrollView.width/2;
        int page = (scrollView.contentOffset.x - halfX)/320 + 1;
        UIPageControl * pageControl = (UIPageControl *)[self.view viewWithTag:200];
        pageControl.currentPage = page;
    }else if (scrollView == self.collectionView){
        //如果是collectionView
        [_toTopButton removeFromSuperview];
        [_leftDrawerButton removeFromSuperview];
        
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (![scrollView isEqual:_homeFocusScrollView]) {
        if (scrollView.contentOffset.y > 500) {
            [self.view addSubview:_toTopButton];
            [self.view addSubview:_leftDrawerButton];
        }
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:_homeFocusScrollView]) {
        if (scrollView.contentOffset.y > 500) {
        [self.view addSubview:_toTopButton];
        [self.view addSubview:_leftDrawerButton];
        }
    }
}
//回到顶部
-(void)toTop
{
    [self.collectionView setContentOffset:CGPointMake(0, -1 * SCREEN_AUTO_SIZE 275) animated:YES];
}
//打开左边抽屉
-(void)openLeftDrawer
{
    //得到我们已经创建的这个抽屉对象
    DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
    //弹出左边的抽屉
    [myDrawer showLeftController:YES];
}


//轮播图自动轮播
-(void)nstimerChangPage
{
    if (self.pageControl.currentPage == self.homeFocusScrollView.contentSize.width / SCREEN_SIZE_WIDTH - 1) {
        self.pageControl.currentPage = 0;
    }else {
        self.pageControl.currentPage++;
    }
    
    //self.pageControl.currentPage = _index;
    [self.homeFocusScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.homeFocusScrollView.bounds) * self.pageControl.currentPage, 0) animated:YES];
    //_index++;
}
#pragma mark- FocusView的点击方法
-(void)FocusButtonClick:(UIButton *)btn
{
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    webView.urlString = [(NSMutableArray *)[self.scrollViewDataDic objectForKey:SCROLLVIEW_LINK] objectAtIndex:(btn.tag -600)];
    [self.navigationController pushViewController:webView animated:YES];

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
    [netWork get:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/list_api.php?app_id=1066136336&app_oid=b7546dbfd0cc03c8b63330a64bb59f0e29e9c944&app_version=2.5.3&app_channel=appstore&cid=0"]];
}


#pragma mark 懒加载
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
//    NSLog(@"添加商品归档成功");
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


#pragma mark- 功能区按键
-(void)smallButtonClikc:(UIButton *)btn
{


    NSInteger whichButton = btn.tag-500;
    //上面4个图片
    if (whichButton<=3) {
        NSArray * urlArray = @[@"http://cloud.repaiapp.com/yunying/miao.php?app_id=1066136336&target=present&app_oid=&app_version=&app_channel=appstore&sche=fenjiujiu",@"http://h5.m.taobao.com/app/cz/cost.html",@"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=1066136336&sche=fenjiujiu",@"http://caipiao.m.taobao.com/lottery/h5/app.html?mode=hybrid"];
        Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
        webView.urlString = [urlArray objectAtIndex:whichButton];
        [self.navigationController pushViewController:webView animated:YES];

    }else{
     //下面4个图片
        if (whichButton==4) {
            //大家都在买
            MyFlowLayout *flowLayout = [[MyFlowLayout alloc]init];
            EveryoneBuyCollectionVC * everyoneVC = [[EveryoneBuyCollectionVC alloc]initWithCollectionViewLayout:flowLayout];
            [flowLayout release];
            
            everyoneVC.title = @"大家都在买";
            [self.navigationController pushViewController:everyoneVC animated:YES];
            [everyoneVC release];
        }else if (whichButton == 5){
            //值得买
            WorthToBuyController * worthToBuyVC = [[WorthToBuyController alloc]init];
            
            worthToBuyVC.title = @"值得买";
            [self.navigationController pushViewController:worthToBuyVC animated:YES];
            [worthToBuyVC release];
        }else if (whichButton == 6){
            //明日抢
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
            flowLayout.itemSize = CGSizeMake(SCREEN_AUTO_SIZE 145, SCREEN_AUTO_SIZE 180);
            //滚动方向上的间隔
            flowLayout.minimumLineSpacing = SCREEN_AUTO_SIZE 5;
            //另一方向上的间隔
            flowLayout.minimumInteritemSpacing = 0;
            //设置区头视图的大小
            flowLayout.headerReferenceSize = CGSizeMake(SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 10);
            //设置cell的margin
            flowLayout.sectionInset = UIEdgeInsetsMake(0, SCREEN_AUTO_SIZE 10, 0, SCREEN_AUTO_SIZE 10);
            TomorrowCollectionViewController * tomorrowVC = [[TomorrowCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
            [flowLayout release];
            tomorrowVC.title = @"明日预告";
            [self.navigationController pushViewController:tomorrowVC animated:YES];
            [tomorrowVC release];
            
        }else if (whichButton == 7){
            //试试手气
            MyFlowLayout *flowLayout = [[MyFlowLayout alloc]init];
            RandomCollectionViewController * randomVC = [[RandomCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
            [flowLayout release];
            [self.navigationController pushViewController:randomVC animated:YES];
            [randomVC release];
        }
    }
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



#pragma mark- UICollectionView Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomepageReuseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    HomePageReuseCellData * cellData =[self.dataArray objectAtIndex:indexPath.row];
    cell.dataModel = cellData;
    cell.delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    HomePageReuseCellData * model = self.dataArray[indexPath.row];
    webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",model.num_iid];
    [self.navigationController pushViewController:webView animated:YES];
    [webView release];

}
#pragma mark- DDMenuController
-(void)handleClickLeftViewController:(UIBarButtonItem *)sender{
    //得到我们已经创建的这个抽屉对象
    DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
    //弹出左边的抽屉
    [myDrawer showLeftController:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //得到我们已经创建的这个抽屉对象
    DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
    [myDrawer.pan setEnabled:NO];
    //把两个button消除
    [_toTopButton removeFromSuperview];
    [_leftDrawerButton removeFromSuperview];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
