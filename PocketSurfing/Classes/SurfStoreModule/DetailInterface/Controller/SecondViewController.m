

#import "SecondViewController.h"
#import "Header.h"
#import "DetailGoodDataCell.h"
#import "DetailGoodData.h"
#import "DetailGoodDataHandle.h"
#import "Public_WebView_ViewController.h"
#import "Functions.h"
#import "SurfStoreMarcos.h"

@interface SecondViewController ()
@property(nonatomic, retain)DetailGoodDataHandle *handle;
@end

@implementation SecondViewController
- (void)dealloc
{
    self.handle = nil;
    self.segmentControl = nil;
    self.collectionView = nil;
    self.title = nil;
    self.dataArray = nil;
    self.url =nil;
    self.keyWord = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.title;
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    
    NSArray * itemArray = @[@"人气", @"销量", @"价格"];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segmentControl.frame = CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 300, SCREEN_AUTO_SIZE 30);
    //self.segmentControl.backgroundColor = RED_COLOR;
    self.segmentControl.tintColor = RED_COLOR;
    //self.segmentControl.tintColor = RED_COLOR;
    [self.segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentControl];
    [self.segmentControl release];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_AUTO_SIZE 150, SCREEN_AUTO_SIZE 205);
    flowLayout.minimumInteritemSpacing = 0;
    //flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE (568 - 104))collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, SCREEN_AUTO_SIZE 5, 0, SCREEN_AUTO_SIZE 5);
    self.collectionView.backgroundColor = COLLECTION_BACKGROUND_COLOR;
    [self.collectionView registerClass:[DetailGoodDataCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.footer.hidden = YES;
    
    [self loadNewData];
    // Do any additional setup after loading the view.
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- 视图将要出现或者结束时候的方法
//视图将要出现时候的方法
-(void)viewWillAppear:(BOOL)animated
{

    self.tabBarController.tabBar.hidden = YES;
}
//视图消失时候的方法
-(void)viewWillDisappear:(BOOL)animated
{

    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    if ([self respondsToSelector:@selector(loadNewData)]) {
        [self.dataArray removeAllObjects];
        [self loadNewData];
    }
    [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
}
-(void)loadNewData
{
    NSString * str = [self.keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.handle = [[DetailGoodDataHandle alloc] init];
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [_handle synchronousGetRequest:self.url];
            break;
        case 1:
            [_handle synchronousGetRequest:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=d&price=0,999999", str]];
            break;
        case 2:
            [_handle synchronousGetRequest:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=pd&price=0,999999", str]];
            break;
        default:
            break;
    }
    _handle.delegate = self;
    [self.handle release];
}
- (void)getData:(id)netData
{
    NSDictionary * dic = netData;
    NSArray * array = [dic objectForKey:@"list"];
    for (NSDictionary * dictionary in array) {
        DetailGoodData * data = [[DetailGoodData alloc] init];
        [data setValuesForKeysWithDictionary:dictionary];
        [self.dataArray addObject:data];
        [data release];
    }
//    NSLog(@"%@", self.dataArray);
    [self.collectionView reloadData];
}
//懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray =[NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
#pragma mark - UISegementControl
- (void)segmentControlValueChanged:(UISegmentedControl *)segment
{
    [self.collectionView.header beginRefreshing];
}

#pragma mark - UICollectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailGoodDataCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.data = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Public_WebView_ViewController * VC = [[Public_WebView_ViewController alloc] init];
    VC.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",[[self.dataArray objectAtIndex:indexPath.row] item_id]];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
