

#import "WorthToBuyController.h"
#import "Header.h"
#import "Public_WebView_ViewController.h"
#import "MyFlowLayout.h"
#import "WorthToBuyCollectionVC.h"
#define K_FONT_SIZE 13.0
@interface WorthToBuyController ()
@property (nonatomic,retain)NSArray * moduleName;
@end

@implementation WorthToBuyController
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
- (void)viewDidLoad {
    self.dataSource = self;
    self.delegate = self;
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - NKJPagerViewDataSource

- (NSUInteger)numberOfTabView
{
    return 10;
}

- (UIView *)viewPager:(NKJPagerViewController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    self.moduleName = @[@"新品",@"数码",@"女装",@"男装",@"家居",@"辣妈",@"鞋包",@"配饰",@"美妆",@"美食",@"其他"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 50, 35)];
    label.backgroundColor = COLOR(240, 240, 240);
    label.font = [UIFont systemFontOfSize:K_FONT_SIZE];
    label.text = [NSString stringWithFormat:@"%@", self.moduleName[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR(186, 186, 186);

    return label;
}
//配置下面的collection视图
- (UIViewController *)viewPager:(NKJPagerViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    MyFlowLayout * flowLayout = [[[MyFlowLayout alloc]init] autorelease];
    WorthToBuyCollectionVC * worthCollectionVC = [[WorthToBuyCollectionVC alloc]initWithCollectionViewLayout:flowLayout];
    worthCollectionVC.pageCount = index;
    return worthCollectionVC;
}

- (NSInteger)widthOfTabView
{
    return 50;
}

#pragma mark - NKJPagerViewDelegate
//配置选中时候的tab
- (void)viewPager:(NKJPagerViewController *)viewPager didSwitchAtIndex:(NSInteger)index withTabs:(NSArray *)tabs
{
    [UIView animateWithDuration:0.1
                     animations:^{
                         for (UIView *view in self.tabs) {
                             if (index == view.tag) {
                                 UILabel * label = (UILabel *)view;
                                 label.font = [UIFont boldSystemFontOfSize:K_FONT_SIZE];
                                 label.textColor = COLOR(255, 88, 165);
                             } else {
                                 UILabel * label = (UILabel *)view;
                                 label.font = FONT(K_FONT_SIZE);
                                 label.textColor = COLOR(186, 186, 186);
                             }
                         }
                     }
                     completion:^(BOOL finished){}];
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
