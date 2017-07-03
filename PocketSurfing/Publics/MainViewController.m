

#import "MainViewController.h"
#import "DiscoveryVC.h"
#import "SurfStoreVC.h"
#import "ChannelVC.h"
#import "MineCollectionViewController.h"
#import "HomePageVC.h"
#import "Header.h"
#import "HomePageLeftTableVC.h"
#import "MineFlowLayout.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadViewControllers{
    
    DiscoveryVC * discoveryVC = [[DiscoveryVC alloc] init];
    discoveryVC.navigationItem.title = @"发现";
    UINavigationController * discoverNav = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
    discoverNav.navigationBar.translucent = NO;
    [discoveryVC release];
    
    SurfStoreVC * surfStoreVC = [[SurfStoreVC alloc] init];
    surfStoreVC.navigationItem.title = @"逛商品";
    UINavigationController * surfStoreNav = [[UINavigationController alloc] initWithRootViewController:surfStoreVC];
        surfStoreNav.navigationBar.translucent = NO;
    [surfStoreVC release];
    
    HomePageVC * homePageVC = [[HomePageVC alloc] init];
    UINavigationController * homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
        homePageNav.navigationBar.translucent = NO;
    homePageNav.navigationBarHidden = NO;
    homePageVC.navigationItem.title = @"口袋逛";
    [homePageVC release];
    
    ChannelVC * channelVC = [[ChannelVC alloc] init];
    UINavigationController * channelNav = [[UINavigationController alloc] initWithRootViewController:channelVC];
        channelNav.navigationBar.translucent = NO;
    channelVC.navigationItem.title = @"频道";
    [channelVC release];
    
    MineFlowLayout * flowLayout = [[MineFlowLayout alloc]init];
    MineCollectionViewController * mineVC = [[MineCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
        mineNav.navigationBar.translucent = NO;
    mineVC.navigationItem.title = @"我的";
    [mineVC release];
    [flowLayout release];
    
    self.viewControllers = @[homePageNav, surfStoreNav, discoverNav, channelNav, mineNav];
    
    
    NSArray * iconArray = @[@"glnine.png", @"glshopping.png", @"gldongtai.png", @"glzhuti.png", @"glmine.png"];
    NSArray * selectedIconArray = @[@"nine.png", @"shopping.png", @"dongtai.png", @"zhuti.png", @"mine.png"];
    for (int i = 0; i < self.viewControllers.count; i++) {
        UINavigationController * nav = [self.viewControllers objectAtIndex:i];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[iconArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.image = [[UIImage imageNamed:[selectedIconArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nav.tabBarItem setImageInsets:UIEdgeInsetsMake(SCREEN_AUTO_SIZE 5.0, 0.0, SCREEN_AUTO_SIZE -5.0, 0.0)];
    }
    
    [mineNav release];
    [channelNav release];
    [homePageNav release];
    [discoverNav release];
    [surfStoreNav release];

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
