

#import "BrandViewController.h"
#import "Header.h"
#import "NetWorkInterfaceBlock.h"
#import "BrandShopCell.h"
#import "BrandShop.h"
#import "Discover_Brand_GoodsViewController.h"

@interface BrandViewController ()
@property (nonatomic, retain)UIImageView * ImageView;
@end

@implementation BrandViewController
-(void)dealloc{
    self.brandShop = nil;
    self.ImageView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.tableView = [[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 180;

    
    [self loadNewData];
    //加载下拉刷新
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        self.ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 135, SCREEN_AUTO_SIZE 100, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 50)];
        _ImageView.layer.masksToBounds = YES;
        _ImageView.image = [UIImage imageNamed:@"newLoading.png"];
        [self.view addSubview:_ImageView];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(rotateImage) userInfo:nil repeats:YES];
        [_ImageView release];
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
    self.isRefresh = YES;
    [self loadDataWithPage:++self.pageNum];
}

- (void)loadDataWithPage:(NSInteger)pageNumber{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSDictionary *dic) {
        NSArray * array = [dic objectForKey:@"data"];
        for (NSDictionary * brandShopdic in array) {
            BrandShop * brandShop = [[BrandShop alloc] initWithDictionary:brandShopdic];
            [self.dataArray addObject:brandShop];
            [brandShop release];
        }
    
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        self.ImageView.image = nil;
        [self.tableView.footer endRefreshing];
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    NSString * urlString  = @"http://zhekou.repai.com/lws/view/zhe_800brand/brandtitle.php";
    [netWork get:urlString];
    self.tableView.footer.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//下拉刷新出现图片旋转
- (void)rotateImage{
    self.ImageView.transform = CGAffineTransformRotate(self.ImageView.transform, M_PI_4);
}

#pragma mark  headerView.
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SCREEN_AUTO_SIZE 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * myHeader = [[[UIView alloc] init] autorelease];
    myHeader.backgroundColor = [UIColor whiteColor];
    
    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, 0, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 50)];
    myLabel.text = @"品牌团";
    myLabel.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 20.0];
    [myHeader addSubview:myLabel];
    
    UILabel * titlelable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 70, 0, SCREEN_AUTO_SIZE 140, SCREEN_AUTO_SIZE 50)];
    titlelable.text = @"(每天9点 品牌团)";
    titlelable.textColor = [UIColor grayColor];
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
    BrandShopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[BrandShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer] autorelease];
        cell.backgroundColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray.count >0) {
        BrandShop * brandShop = [self.dataArray objectAtIndex:indexPath.row];
        cell.brandShop = brandShop;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArray.count >0) {
        Discover_Brand_GoodsViewController * brandGoodsVC = [[Discover_Brand_GoodsViewController alloc] init];
        brandGoodsVC.max_imgUrlString = ((BrandShop *)[self.dataArray objectAtIndex:indexPath.row]).max_img;
        brandGoodsVC.brandString = ((BrandShop *)[self.dataArray objectAtIndex:indexPath.row]).brand;
        brandGoodsVC.brand_titString = ((BrandShop *)[self.dataArray objectAtIndex:indexPath.row]).brand_tit;
        brandGoodsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brandGoodsVC animated:YES];
    }
    

   
    
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
