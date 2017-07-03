

#import "UserGuideViewController.h"
#import "Header.h"
#import "DDMenuController.h"
#import "MainViewController.h"
#import "HomePageLeftTableVC.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initGuide];   //加载新用户指导页面
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
- (void)initGuide{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
    [scrollView setContentSize:CGSizeMake(SCREEN_AUTO_SIZE 1600, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来

     UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
     [imageview setImage:[UIImage imageNamed:@"0@2x.png"]];
     [scrollView addSubview:imageview];
     [imageview release];

    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 320, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
     [imageview1 setImage:[UIImage imageNamed:@"1@2x.png"]];
     [scrollView addSubview:imageview1];
     [imageview1 release];

     UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 640, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
     [imageview2 setImage:[UIImage imageNamed:@"2@2x.png"]];
     [scrollView addSubview:imageview2];
     [imageview2 release];

     UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 960, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
     [imageview3 setImage:[UIImage imageNamed:@"3@2x.png"]];
     [scrollView addSubview:imageview3];
     [imageview3 release];
    
    UIImageView *imageview4 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 1280, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 568)];
    [imageview4 setImage:[UIImage imageNamed:@"4@2x.png"]];
    imageview4.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    [scrollView addSubview:imageview4];
    [imageview4 release];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:@"进入应用" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    button.alpha = 0.5;
    //button.titleLabel.textColor = [UIColor redColor];
    //[button setBackgroundColor:[UIColor grayColor]];
    button.layer.cornerRadius = 2;
    
    [button setFrame:CGRectMake(SCREEN_AUTO_SIZE 46, SCREEN_AUTO_SIZE 371, SCREEN_AUTO_SIZE 230, SCREEN_AUTO_SIZE 37)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview4 addSubview:button];
   
   [self.view addSubview:scrollView];
   [scrollView release];
}

//进入主页面
- (void)firstpressed {
    
    MainViewController * mainVC = [[MainViewController alloc] init];
    DDMenuController * sddmenu = [[DDMenuController alloc]initWithRootViewController:mainVC];
    HomePageLeftTableVC * leftVC = [[HomePageLeftTableVC alloc]initWithStyle:UITableViewStyleGrouped];
    leftVC.tableView.showsVerticalScrollIndicator = NO;
    
    sddmenu.leftViewController = [leftVC autorelease];
    [[[UIApplication sharedApplication]delegate]window].rootViewController = sddmenu;

    [self presentViewController:sddmenu animated:YES completion:^{
    }];//点击button跳转到根视图
    [sddmenu release];
    [mainVC release];
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
