
#import "Public_WebView_ViewController.h"
#import "MJRefresh.h"
#import "Header.h"
#import "BottomView.h"
#import "UMSocial.h"

@interface Public_WebView_ViewController ()

@property (retain, nonatomic)UIWebView * webView;
- (void)loadWebString;
@end

@implementation Public_WebView_ViewController
- (void)dealloc
{
    self.bottomView = nil;
    self.webView = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView = nil;
    
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_SIZE_HEIGHT - SCREEN_AUTO_SIZE 60) style:UITableViewStylePlain] autorelease];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _webView  =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_SIZE_HEIGHT - SCREEN_AUTO_SIZE 60)];
    [self.tableView addSubview: _webView];
    [self loadWebString];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadWebString)];
    
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE_HEIGHT - SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 50)];
    //self.bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView.goBackButton addTarget:self action:@selector(goBackButtonDoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.leftButton addTarget:self action:@selector(leftButtonDoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.rightButton addTarget:self action:@selector(rightButtonDoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.shareButton addTarget:self action:@selector(shareButtonDoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView release];
}
- (void)shareButtonDoClick
{
    [self ShareMessage];
//    NSLog(@"sharemessage");
}

-(void)ShareMessage{
    
[UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:@"口袋逛，逛口袋。我就是你的贴身小口袋" shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina, UMShareToQQ, UMShareToSms, UMShareToWechatFavorite] delegate:self];
    
    
}
- (void)leftButtonDoClick
{
    [self.webView goBack];
}
- (void)rightButtonDoClick
{
    [self.webView goForward];
}
- (void)goBackButtonDoClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadWebString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:_urlString];
        NSURLRequest * requset = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requset];
        //处理完回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
    });
}
//视图将要出现时候的方法
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
//视图消失时候的方法
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
