

#import "ThemeStreetViewController.h"
#import "Discover-NetWorkInterfaceBlock.h"
#import "Subject.h"
#import "Header.h"
#import "SubjectCell.h"
#import "Public_WebView_ViewController.h"

@interface ThemeStreetViewController ()
@property (nonatomic, retain)UIImageView * ImageView;
@end

@implementation ThemeStreetViewController
-(void)dealloc{
    self.ImageView = nil;
    self.subject = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 197;
    
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
    self.isRefresh = YES;
    [self loadDataWithPage:++self.pageNum];
}
- (void)loadDataWithPage:(NSInteger)pageNumber{
    Discover_NetWorkInterfaceBlock * netWork = [[[Discover_NetWorkInterfaceBlock alloc] initWithSuccessful:^(NSArray *array) {
        for (NSDictionary * dic in array) {
            Subject * subject = [[Subject alloc] initWithDictionary:dic];
            [self.dataArray addObject:subject];
            [subject release];
        }
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        self.ImageView.image = nil;
        [self.tableView.footer endRefreshing];
    } fail:^BOOL(NSError *error) {
        return YES;
    }] autorelease];
    NSString * urlString  = @"http://app.api.yijia.com/tb99/iphone/zhuanti.php";
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
    SubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[SubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray.count >0) {
        Subject * subject = [self.dataArray objectAtIndex:indexPath.row];
        cell.subject = subject;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Public_WebView_ViewController * publicWebViewVC = [[Public_WebView_ViewController alloc] init];
    publicWebViewVC.urlString = ((Subject *)[self.dataArray objectAtIndex:indexPath.row]).detail_url;
    //NSLog(@"%@", ((Subject *)[self.dataArray objectAtIndex:indexPath.row]).detail_url);
    [self.navigationController pushViewController:publicWebViewVC animated:YES];
    
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

@end
