

#import "HomePageLeftTableVC.h"
#import "LeftDrawTableViewCell.h"
#import "HpLeftDetailCollectionVC.h"
#import "MyFlowLayout.h"
#import "Header.h"
@interface HomePageLeftTableVC ()
@property (nonatomic, retain)NSArray * nameArray;
@end

@implementation HomePageLeftTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 160, SCREEN_AUTO_SIZE 65)];
    headerLabel.text = @"\n商品类目";
    headerLabel.font = FONT(SCREEN_AUTO_SIZE 18);
    headerLabel.numberOfLines = 0;
    headerLabel.textAlignment = NSTextAlignmentCenter;

    self.tableView.tableHeaderView = headerLabel;

    self.tableView.tableHeaderView.height = SCREEN_AUTO_SIZE 65;
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = SCREEN_AUTO_SIZE 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
//配置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"homeLeftTableCell";
    self.nameArray = @[@"新品",@"数码",@"女装",@"男装",@"家居",@"辣妈",@"鞋包",@"配饰",@"美妆",@"美食",@"其他"];
    NSArray * picArray = @[@"newGoods.png",@"Digital1.png",@"Women3.png",@"Men9.png",@"HomeUse9.png",@"hotMother.png",@"Men14.png",@"Men17.png",@"MakeUp2.png",@"Snack3.png",@"Creative5.png"];
    LeftDrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (!cell) {
        cell = [[LeftDrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.title = _nameArray[indexPath.row];
    cell.roundImageView.image = [UIImage imageNamed:picArray[indexPath.row]];
    return cell;
}
#pragma mark - Table view delegate
//选中某个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //得到我们已经创建的这个抽屉对象
        DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
        [myDrawer showRootController:YES];
    }else{
        MyFlowLayout * flowLayout = [[MyFlowLayout alloc]init];
        HpLeftDetailCollectionVC * detailVC = [[HpLeftDetailCollectionVC alloc]initWithCollectionViewLayout:flowLayout];
        [flowLayout release];
        detailVC.title = _nameArray[indexPath.row];
        detailVC.pageNumber = indexPath.row;
        
        //得到我们已经创建的这个抽屉对象
        DDMenuController *myDrawer = (DDMenuController *)self.view.window.rootViewController;
        UITabBarController * tabbar  = (UITabBarController *)myDrawer.rootViewController;
        UINavigationController * nav = tabbar.viewControllers.firstObject;
        
        [myDrawer showRootController:YES];
        [nav pushViewController:detailVC animated:YES];
        [detailVC release];
    }
    
    
    
    

    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
