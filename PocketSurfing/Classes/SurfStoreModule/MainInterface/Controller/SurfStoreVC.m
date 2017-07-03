

#import "SurfStoreVC.h"
#import "SMVerticalSegmentedControl.h"
#import "MySearchBar.h"
#import "ModalVCTableVC.h"
#import "SecondViewController.h"
#import "CollectionView.h"
#import "MainPageCollectionViewCell.h"
#import "SurfStoreMainInterfaceDataHandle.h"
#import "UIImageView+WebCache.h"
#import "SurfStoreMainInterfaceData.h"
#import "MainInterfaceHeader.h"
#import "Public_WebView_ViewController.h"
#import "Header.h"

#define SEARCHBAR_FRAME CGRectMake(SCREEN_AUTO_SIZE 0, SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 30)
#define CELL_IDENTIFIER @"cellIdentifier"
#define HEADER_IDENTIFIER @"headerIdentifier"
/**/
#define TOP_HEIGHT SCREEN_AUTO_SIZE  64
#define TABBAR_HEIGHT  SCREEN_AUTO_SIZE 49
/**/
#define SEGMENT_WIDTH SCREEN_AUTO_SIZE 65
#define SEGMENT_HEIGHT SCREEN_AUTO_SIZE  568 - TOP_HEIGHT - TABBAR_HEIGHT
/**/
#define COLLECTION_WIDTH SCREEN_AUTO_SIZE 320 - SEGMENT_WIDTH
#define COLLECTION_HEIGHT SEGMENT_HEIGHT

@interface SurfStoreVC ()
@property(nonatomic, retain)SurfStoreMainInterfaceDataHandle * handle;
@end

@implementation SurfStoreVC
- (void)dealloc
{
    self.helpButton = nil;
    self.collectionView = nil;
    self.searchBar = nil;
    self.segmentControl = nil;
    self.dataArray = nil;
    self.dataDic = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[MySearchBar alloc] initWithFrame:SEARCHBAR_FRAME];
    [self.view addSubview:self.searchBar];
    for (UIView *subview in self.searchBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;
        }
    }
    [self.searchBar release];
    
    self.helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.helpButton.frame = self.searchBar.frame;
    [self.helpButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.helpButton];
    
    self.collectionView = [[CollectionView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 65, SCREEN_AUTO_SIZE 64, SCREEN_AUTO_SIZE 255, SCREEN_AUTO_SIZE 568 - TOP_HEIGHT - TABBAR_HEIGHT)];
    self.collectionView.delegate = self;
    [self.collectionView.collectionView registerClass:[MainPageCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [self.collectionView.collectionView registerClass:[MainInterfaceHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIER];
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    NSArray * itemArray = @[@"推荐", @"女孩", @"美妆", @"数码", @"居家", @"零食", @"男孩", @"创意"];
    self.segmentControl = [[[SMVerticalSegmentedControl alloc] initWithSectionTitles:itemArray] autorelease];
    self.segmentControl.frame = CGRectMake(0, TOP_HEIGHT, SEGMENT_WIDTH, SEGMENT_HEIGHT);
    self.segmentControl.indexChangeBlock = ^(NSInteger index){
        NSArray * arrayTemp = @[@"推荐", @"女人", @"美妆", @"数码", @"居家", @"零食", @"男人", @"创意"];
        self.dataArray = [self.dataDic objectForKey:[arrayTemp objectAtIndex:index]];
        [self.collectionView.collectionView reloadData];
    };
    
    self.segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentControl];
    [self loadData];
}
//按空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //[self.view endEditing:YES];
    [self.searchBar endEditing:YES];
}
- (void)doClick
{
    ModalVCTableVC * modalVC = [[ModalVCTableVC alloc] init];
    [self.navigationController pushViewController:modalVC animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    [modalVC release];
}
- (NSMutableDictionary *)dataDic
{
    if (_dataDic == nil) {
        self.dataDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _dataDic;
}
- (void)loadData
{
    self.handle = [[SurfStoreMainInterfaceDataHandle alloc] init];
    [_handle asynchronousGetRequest:@"http://zhekou.repai.com/lws/view/zhou_if2.php"];
    _handle.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ImageButtonDelegate
- (void)pushNextPage
{
    NSString * urlString = [[self.dataArray firstObject] name];
    Public_WebView_ViewController * VC = [[Public_WebView_ViewController alloc] init];
    VC.urlString = urlString;
    [self.navigationController pushViewController:VC animated:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [VC release];
}
#pragma mark - GetDataDelegate
- (void)getData:(id)netData
{
    NSDictionary * dic = netData;
    for (NSString * key in dic) {
        NSArray * valueArray = [dic objectForKey:key];
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary * smallDic in valueArray) {
            SurfStoreMainInterfaceData * data = [[SurfStoreMainInterfaceData alloc] init];
            [data setValuesForKeysWithDictionary:smallDic];
            [array addObject:data];
            [data release];
        }
        [self.dataDic setObject:array forKey:key];
    }
    self.dataArray = [self.dataDic objectForKey:@"推荐"];
    [self.collectionView.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"dataArray = %ld", self.dataArray.count);
    return self.dataArray.count - 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"2");
    MainPageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSArray * itemArray = @[@"Recommend", @"Women", @"MakeUp", @"Digital", @"HomeUse", @"Snack", @"Men", @"Creative"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", [itemArray objectAtIndex:self.segmentControl.selectedSegmentIndex], (indexPath.row + 1)]];
    cell.data = [self.dataArray objectAtIndex:indexPath.row + 1];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果重用时需要展示的是区头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //从辅助视图的重用队列取出一个可重用的区头视图
        MainInterfaceHeader * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier" forIndexPath:indexPath];
        NSArray * itemArray = @[@"Recommend", @"Women", @"MakeUp", @"Digital", @"HomeUse", @"Snack", @"Men", @"Creative"];
        [headerView.imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@0.png", [itemArray objectAtIndex:self.segmentControl.selectedSegmentIndex]]]forState:UIControlStateNormal];
        headerView.delegate = self;
        headerView.data = [self.dataArray objectAtIndex:0];
        return headerView;
    }
    return nil;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SurfStoreMainInterfaceData * data = [self.dataArray objectAtIndex:indexPath.row + 1];
    NSString * cid = data.cid;
    NSString * keyName = data.name;
    NSString * url = [NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?cid=%@&start=0&sort=s&price=0,200", cid];
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    secondVC.url = url;
    secondVC.keyWord = keyName;
    secondVC.title = keyName;
    [self.navigationController pushViewController:secondVC animated:YES];
    [secondVC release];;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.handle stopConnection];
}

@end
