

#import "DiscoveryVC.h"
#import "Header.h"
#import "ContactCell.h"
#import "Discover-header.h"

@interface DiscoveryVC ()

@end

@implementation DiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //高度
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 55;
    self.tableView.backgroundColor = COLOR(235, 235, 235);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

#pragma mark - Table view data source
//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//返回小组内对象数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArray = @[@[@"   主题街", @"   生活街", @"   超值买手"],@[ @"   今天很划算", @"   品牌团"],@[ @"   好店", @"   瞄一眼"]];
    NSArray * imageArray = @[@[@"zt.png", @"txp.png", @"ms.png"], @[@"zhe.png", @"tuan.png"], @[@"zk.png", @"tm.png"]];
    static NSString * cellIndentifier = @"cell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[ContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = COLOR(255, 255, 255);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLable.text = titleArray[indexPath.section] [indexPath.row];
    cell.aImageView.image = [UIImage imageNamed:imageArray[indexPath.section] [indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Public_WebView_ViewController * publicWebViewVC = [[[Public_WebView_ViewController alloc] init] autorelease];
    publicWebViewVC.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)] autorelease];
    publicWebViewVC.hidesBottomBarWhenPushed = YES;
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeStreetViewController * themeStreetVC = [[ThemeStreetViewController alloc] init];
        themeStreetVC.title = @"专题";
        themeStreetVC.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)] autorelease];
        themeStreetVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:themeStreetVC animated:YES];
        [themeStreetVC release];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        publicWebViewVC.title = @"生活街";
        publicWebViewVC.urlString = @"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=1066136336&sche=fenjiujiu";
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        publicWebViewVC.title = @"超级买手";
        publicWebViewVC.urlString = @"http://app.api.yijia.com/tb99/iphone/API/app_qipa.php";
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        publicWebViewVC.title = @"今天很划算";
        publicWebViewVC.urlString = @"http://jkjby.yijia.com/jkjby/view/nine_web/index.php?app_id=1066136336&sche=fenjiujiu";
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        BrandViewController * brandVC = [[BrandViewController alloc] init];
        brandVC.title = @"品牌团";
        brandVC.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)] autorelease];
        brandVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brandVC animated:YES];
        [brandVC release];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        GoodShopViewController * goodShopVC = [[GoodShopViewController alloc] init];
        goodShopVC.title = @"好店";
        goodShopVC.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnPage)] autorelease];
        goodShopVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodShopVC animated:YES];
        [goodShopVC release];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        publicWebViewVC.title = @"瞄一眼";
        publicWebViewVC.urlString = @"http://zhekou.repai.com/lws/view/zhe_miaoyiyan.php";
        [self.navigationController pushViewController:publicWebViewVC animated:YES];
    }
}
//返回上一页面
- (void)returnPage{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark  footerView
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section != 2) {
        return @" ";
    }
    return nil;
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
