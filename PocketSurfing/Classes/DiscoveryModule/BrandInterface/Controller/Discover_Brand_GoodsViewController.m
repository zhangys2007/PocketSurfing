

#import "Discover_Brand_GoodsViewController.h"
#import "Header.h"
#import "NetWorkInterfaceBlock.h"
#import "Discover_Brand_Goods.h"
#import "Discover_Brand_GoodsCell.h"
#import "Public_WebView_ViewController.h"
#import "UIImageView+WebCache.h"
#import "RefreshBaseTableVC.h"

@interface Discover_Brand_GoodsViewController ()
@property (nonatomic, retain)UIImageView * ImageView;
@end

@implementation Discover_Brand_GoodsViewController

-(void)dealloc{
    self.ImageView = nil;
    self.discover_brand_goods = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _brand_titString;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 100;

    
    [self loadNewData];
    //加载下拉刷新
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        self.ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 135, SCREEN_AUTO_SIZE 100, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 50)];
        _ImageView.layer.masksToBounds = YES;
        _ImageView.image = [UIImage imageNamed:@"newLoading.png"];
        [self.view addSubview:_ImageView];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(rotateImage) userInfo:nil repeats:YES];
        //下拉刷新的调用
        [self loadNewData];
    }];
}
//下拉刷新
- (void)loadNewData{
    [super loadNewData];
    self.pageNum = 1;
    self.isRefresh = YES;
    [self loadDataWithPage:self.pageNum];
}

//加载更多数据
- (void)loadMoreData
{
//    self.isRefresh = YES;
//    [self loadDataWithPage:++self.pageNum];
}

- (void)loadDataWithPage:(NSInteger)pageNumber{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSDictionary *dic) {
        NSArray * array = [dic objectForKey:@"cont"];
        for (NSDictionary * discover_brand_Goodsdic in array) {
            Discover_Brand_Goods * discover_brand_Goods = [[Discover_Brand_Goods alloc] initWithDictionary:discover_brand_Goodsdic];
            [self.dataArray addObject:discover_brand_Goods];
            [discover_brand_Goods release];
        }
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        self.ImageView.image = nil;
        [self.tableView.footer endRefreshing];
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    
    NSString * urlString  = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/view/zhe_800brand/brand_cont.php?brand=%@", _brandString];
    [netWork get:urlString];
    self.tableView.footer.hidden = YES;
}
//下拉刷新出现图片旋转
- (void)rotateImage{
    self.ImageView.transform = CGAffineTransformRotate(self.ImageView.transform, M_PI_4);
}
#pragma mark  headerView.
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SCREEN_AUTO_SIZE 190;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * myHeader = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 190)] autorelease];
    myHeader.backgroundColor = [UIColor whiteColor];
    
    UIImageView * max_imgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 130)];
    [max_imgIV sd_setImageWithURL:[NSURL URLWithString:_max_imgUrlString]];
    [myHeader addSubview:max_imgIV];
    [max_imgIV release];
    
    UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 159, SCREEN_AUTO_SIZE 300, SCREEN_AUTO_SIZE 2)];
    lineIV.image = [UIImage imageNamed:@"line.png"];
    [myHeader addSubview:lineIV];
    [lineIV release];
    
    UILabel * titlelable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 90, SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 140, SCREEN_AUTO_SIZE 60)];
    titlelable.backgroundColor = [UIColor whiteColor];
    titlelable.text = _brand_titString;
    [myHeader addSubview:titlelable];
    [titlelable release];
    
    return myHeader;
}
#pragma TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifer = @"cell";
    Discover_Brand_GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[Discover_Brand_GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer] autorelease];
        cell.backgroundColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray.count >0) {
        Discover_Brand_Goods * discover_brand_Goods = [self.dataArray objectAtIndex:indexPath.row];
        cell.discover_brand_goods = discover_brand_Goods;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArray.count>0) {
        Public_WebView_ViewController * publicWebViewVC = [[Public_WebView_ViewController alloc] init];
        publicWebViewVC.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=b7546dbfd0cc03c8b63330a64bb59f0e29e9c944&app_version=2.5.3&app_channel=appstore&id=&sche=fenjiujiu&nine=1&pxj_price=%@",((Discover_Brand_Goods *)[self.dataArray objectAtIndex:indexPath.row]).now_price];
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
