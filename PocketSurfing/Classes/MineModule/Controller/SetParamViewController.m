
#import "SetParamViewController.h"
#import "Header.h"
#import "SetParamCell.h"
#import "StatementViewController.h"
#import "BDKNotifyHUD.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface SetParamViewController ()

@end

@implementation SetParamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //高度
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.view.backgroundColor = [UIColor grayColor];
    
}

#pragma mark - Table view data source
//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//返回小组内对象数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArray = @[@[ @"   意见反馈", @"   声明"],@[ @"   升级最新版本", @"   清除缓存"]];
    NSArray * imageArray = @[@[ @"opinion.png", @"statement.png"], @[@"versions.png", @"Cleancache.png"]];
    static NSString * cellIndentifier = @"cell";
    SetParamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[SetParamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = COLOR(255, 255, 255);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLable.text = titleArray[indexPath.section] [indexPath.row];
    cell.aImageView.image = [UIImage imageNamed:imageArray[indexPath.section] [indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    



    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"意见反馈" message:@"请联系官方QQ：771012516" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        StatementViewController * statementVC = [[StatementViewController alloc] init];
        [self.navigationController pushViewController:statementVC animated:YES];
        [statementVC release];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        BDKNotifyHUD *hud = [BDKNotifyHUD notifyHUDWithView:nil
                                                       text:@"\n\n已经是最新版本！\n\n"];
        hud.center = CGPointMake(self.tableView.center.x, SCREEN_AUTO_SIZE 150);
        [self.tableView addSubview:hud];
        [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
            [hud removeFromSuperview];
        }];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        BDKNotifyHUD *hud = [BDKNotifyHUD notifyHUDWithView:nil
                                                       text:[NSString stringWithFormat:@"\n\n为你清理%.1fM缓存！\n\n", [[SDImageCache sharedImageCache] getSize]/1024/1024.0]];
        hud.center = CGPointMake(self.tableView.center.x, SCREEN_AUTO_SIZE 150);
        [self.view addSubview:hud];
        [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
            [hud removeFromSuperview];
        }];
        [[SDImageCache sharedImageCache] clearDisk];
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




@end
