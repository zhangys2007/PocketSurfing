

#import "GoodsViewController.h"
#import "Header.h"
#import "Discover-NetWorkInterfaceBlock.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "Public_WebView_ViewController.h"

@interface GoodsViewController ()
@property (nonatomic, retain)UIImageView * ImageView;
@property (nonatomic, retain)NSString * urlString;
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)] autorelease];

    self.navigationItem.title = @"商品详情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 102;
    
    
    
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
    [self.tableView.header beginRefreshing];
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
    Discover_NetWorkInterfaceBlock * netWork = [[[Discover_NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSArray *array) {
        for (NSDictionary * dic in array) {
            Goods * goods = [[Goods alloc] initWithDictionary:dic];
            [self.dataArray addObject:goods];
            [goods release];
        }
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        self.ImageView.image = nil;
        [self.tableView.footer endRefreshing];
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    
    NSString * urlString  = [NSString stringWithFormat:@"http://app.api.yijia.com/newapps/gsc/api/mshop.php?model=data&id=%@&start=0", _aIdUrlString];

    [netWork get:urlString];
    self.tableView.footer.hidden = YES;
}

//下拉刷新出现图片旋转
- (void)rotateImage{
    self.ImageView.transform = CGAffineTransformRotate(self.ImageView.transform, M_PI_4);
}

#pragma TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifer = @"cell";
    GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Goods * goods = [self.dataArray objectAtIndex:indexPath.row];
    cell.goods = goods;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Public_WebView_ViewController * publicWebViewVC = [[Public_WebView_ViewController alloc] init];
    publicWebViewVC.title = @"详细列表";
    publicWebViewVC.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=3119872284&sche=fen_nine_anzhong&app_channel=Android&id=%@", ((Goods *)[self.dataArray objectAtIndex:indexPath.row]).num_iid];
    //NSLog(@"%@", ((Goods *)[self.dataArray objectAtIndex:indexPath.row]).num_iid);
    [self.navigationController pushViewController:publicWebViewVC animated:YES];
    
}

////返回上一页面
//- (void)returnPage{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    //[self.navigationController popToViewController: animated:YES];
//}
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

@end
