
/*
Tag值说明
 200       轮播图的PageControl
 500-503   首页轮播图下方的小button
 600-605   轮播图的button的tag
 650-653   ”我的“页面的四个button

*/
#import "AppDelegate.h"
#import "MainViewController.h"
#import "Header.h"
#import "HomePageLeftTableVC.h"
#import "oneleftViewController.h"
#import "UMAK.h"
#import "UMSocial.h"
#import "Reachability.h"
#import "UserGuideViewController.h"

@interface AppDelegate ()
@property (nonatomic, retain)Reachability * hostReach;
@end

@implementation AppDelegate

- (void)dealloc
{
    self.window = nil;
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
//    

    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"] ;
    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
    
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        UserGuideViewController *userGuideViewController = [[UserGuideViewController alloc] init];
        self.window.rootViewController = userGuideViewController;
        [userGuideViewController release];
    }
    else
    {
        NSLog(@"不是第一次启动");
        
    
        //如果不是第一次启动的话,使用LoginViewController作为根视图

        MainViewController * mainVC = [[MainViewController alloc] init];
        //Drawer View
        DDMenuController * sddmenu = [[DDMenuController alloc]initWithRootViewController:mainVC];
        HomePageLeftTableVC * leftVC = [[HomePageLeftTableVC alloc]initWithStyle:UITableViewStyleGrouped];
        //Hide the tableView's Vertical Indecator
        leftVC.tableView.showsVerticalScrollIndicator = NO;
        //    UINavigationController * leftNav = [[UINavigationController alloc]initWithRootViewController:leftVC];
        
        sddmenu.leftViewController = [leftVC autorelease];
        //    leftNav.navigationBar.translucent = NO;
        self.window.rootViewController = sddmenu;
        [sddmenu release];
        [mainVC release];
    
    }
    
    UMAK * umak = [[UMAK alloc]init];
    [umak UM];
    [umak release];
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //[self updateInterfaceWithReachability:currReach];
        //对连接改变做出响应处理动作
        NetworkStatus status = [currReach currentReachabilityStatus];
        //如果没有连接到网络就弹出提醒实况
        if(status == NotReachable)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"暂无法访问口袋逛,请连接网络后重新打开" delegate:self cancelButtonTitle:@"退出程序" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
    
    
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
        exit(0);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
@end
