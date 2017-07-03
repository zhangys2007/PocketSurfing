

#import "ModalVCTableVC.h"
#import "MySearchBar.h"
#import "SecondViewController.h"
#import "SearchBarHotWordDataHandle.h"
#import "SearchBarHotWordData.h"
#import "SearchBarHotWordCell.h"
#import "ResentSearchCell.h"
#import "NSString+filePath.h"
#import "SurfStoreMarcos.h"
#import "Header.h"

@interface ModalVCTableVC ()

@end

@implementation ModalVCTableVC

- (void)dealloc
{
    self.segmentControl = nil;
    self.clearButton = nil;
    self.tableView = nil;
    self.searchBar = nil;
    self.oneDayDataArray = nil;
    self.oneWeekDataArray = nil;
    self.historyArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self unarchiverMethod];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 88, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE (568 - 108)) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SearchBarHotWordCell class] forCellReuseIdentifier:HOT_WORD_IDENTIFIER];
    [self.tableView registerClass:[ResentSearchCell class] forCellReuseIdentifier:RESENT_IDENGIFIER];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView release];
    
    self.searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 280, SCREEN_AUTO_SIZE 30)];
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate = self;
    [self.searchBar release];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.showsScopeBar = YES;
    NSArray * scopeArray = @[@"最近搜索", @"热门推荐"];
    self.searchBar.scopeButtonTitles = scopeArray;
    self.searchBar.tintColor = RED_COLOR;
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.selectedScopeButtonIndex = 0;
    [self.searchBar showsScopeBar];
    


    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.clearButton.frame = CGRectMake(0, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 100, SCREEN_AUTO_SIZE 35);
    self.clearButton.backgroundColor = [UIColor lightGrayColor];
    [self.clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.clearButton;
    self.tableView.tableFooterView.frame = CGRectMake(0, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 300, SCREEN_AUTO_SIZE 44);
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    SearchBarHotWordDataHandle * handle = [[SearchBarHotWordDataHandle alloc] init];
    [handle synchronousGetRequest:@"http://zhekou.repai.com/lws/view/zhou_paixu.php"];
    handle.delegate = self;

}
- (void)getData:(id)netData
{
    NSArray * totalDataArray = netData;
//    NSLog(@"%@", netData);
    NSDictionary * oneDayDic = [totalDataArray objectAtIndex:0];
    NSArray * oneDayArray = [oneDayDic objectForKey:@"list"];
    for (NSArray * array in oneDayArray) {
        SearchBarHotWordData * data = [[SearchBarHotWordData alloc] init];
        data.name = [array firstObject];
        data.rate = [array lastObject];
        [self.oneDayDataArray addObject:data];
        [data release];
    }
    NSDictionary * oneWeekDic = [totalDataArray objectAtIndex:1];
    NSArray * oneWeekArray = [oneWeekDic objectForKey:@"list"];
    for (NSArray * array in oneWeekArray) {
        SearchBarHotWordData * data = [[SearchBarHotWordData alloc] init];
        data.name = [array firstObject];
        data.rate = [array lastObject];
        [self.oneWeekDataArray addObject:data];
        [data release];
    }
    self.tempArray = self.oneDayDataArray;
    [self.tableView reloadData];
}

- (NSMutableArray *)oneDayDataArray
{
    if (_oneDayDataArray == nil) {
        self.oneDayDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _oneDayDataArray;
}
- (NSMutableArray *)oneWeekDataArray
{
    if (_oneWeekDataArray == nil) {
        self.oneWeekDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _oneWeekDataArray;
}
- (NSMutableArray *)historyArray
{
    if (_historyArray == nil) {
        self.historyArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _historyArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)doClick:(UIButton *)button
{
    if (self.searchBar.selectedScopeButtonIndex == 0) {
        [self doClear];
    }
    [self checkAnotherGroupWords];
}
- (void)doClear
{
    [self.historyArray removeAllObjects];
    [self archiveMethod];
    [self.tableView reloadData];
}
- (void)checkAnotherGroupWords
{
    if ([self.tempArray isEqual:self.oneDayDataArray]) {
        self.tempArray = self.oneWeekDataArray;
        [self.tableView reloadData];
    }else{
        self.tempArray = self.oneDayDataArray;
        [self.tableView reloadData];
    }
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    for (id button in searchBar.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            UIButton * btn = button;
            [btn setTitle:@"取消"forState:UIControlStateNormal];
        }
    }
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers firstObject] animated:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * tempString = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlString = [NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=s&price=0,999999", tempString];
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    secondVC.url = urlString;
    secondVC.title = [NSString stringWithFormat:@"搜索-%@", searchBar.text];
    [self.navigationController pushViewController:secondVC animated:YES];
    [secondVC release];
    
    SearchBarHotWordData * data = [[SearchBarHotWordData alloc] init];
    data.name = searchBar.text;
    if (self.historyArray.count == 0) {
        [self.historyArray addObject:data];
        [self archiveMethod];
    }else{
        BOOL isExist = NO;
        for (int i = 0; i < self.historyArray.count; i++) {
            BOOL result = [[[self.historyArray objectAtIndex:i] name] isEqualToString:data.name];
            if (result) {
                isExist = YES;
            }
        }
        if (!isExist) {
            [self.historyArray addObject:data];
            [self archiveMethod];
        }
    }
    [data release];
}
#pragma mark - guidangjiedang
//归档
-(void)archiveMethod
{
    //创建一个data容器
    NSMutableData * data = [NSMutableData dataWithCapacity:1];
    //创建一个归档器
    NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //归档
    [keyedArchiver encodeObject:self.historyArray forKey:@"Array"];
    [keyedArchiver finishEncoding];
    [data writeToFile:[@"searchHistoryData" documentsFilePath] atomically:YES];
    [keyedArchiver release];
}
//解档
-(void)unarchiverMethod
{
    //文件路径
    NSString * filePath = [@"searchHistoryData" documentsFilePath];
    //NSLog(@"%@",filePath);
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    NSArray * array = [keyedUnarchiver decodeObjectForKey:@"Array"];
    self.historyArray = [NSMutableArray arrayWithArray:array];
    [keyedUnarchiver release];
    //self.historyArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
    //NSLog(@"%@",_indexArray);
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    if (selectedScope == 1) {
        [self.clearButton setTitle:@"换一批热词" forState:UIControlStateNormal];
//        NSLog(@" selectedScope = 1 %@", self.clearButton.currentTitle);
        [self.tableView reloadData];
    }else{
        [self.clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
//        NSLog(@" selectedScope = 0 %@", self.clearButton.currentTitle);
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    SearchBarHotWordData * data = [[SearchBarHotWordData alloc] init];
    if (self.searchBar.selectedScopeButtonIndex == 1) {
        data = [self.tempArray objectAtIndex:indexPath.row];
    }else{
        data = [self.historyArray objectAtIndex:indexPath.row];
    }
    [self.historyArray addObject:data];
    [self archiveMethod];
    NSString * str = [data.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlString = [NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=s&price=0,999999", str];
    if (self.searchBar.selectedScopeButtonIndex == 1) {
        NSString * urlString = [NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=s&price=0,999999", str];
        secondVC.url = urlString;
    }else{
        NSString * urlString = [NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=s&price=0,999999", str];
        secondVC.url = urlString;
    }
    secondVC.url = urlString;
    secondVC.keyWord = data.name;
    secondVC.title = [NSString stringWithFormat:@"搜索-%@", data.name];
    [self.navigationController pushViewController:secondVC animated:YES];
    [data release];
    [secondVC release];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchBar.selectedScopeButtonIndex == 1) {
        return self.oneDayDataArray.count;
    }
    return self.historyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchBar.selectedScopeButtonIndex == 1) {
        SearchBarHotWordCell * cell = [tableView dequeueReusableCellWithIdentifier:HOT_WORD_IDENTIFIER forIndexPath:indexPath];
        SearchBarHotWordData * data = [self.tempArray objectAtIndex:indexPath.row];
        cell.data = data;
        switch (indexPath.row) {
            case 0:
                cell.aView.backgroundColor = RED_COLOR;
                break;
            case 1:
                cell.aView.backgroundColor = [UIColor cyanColor];
                break;
            case 2:
                cell.aView.backgroundColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        return cell;
    }else{
        
        ResentSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:RESENT_IDENGIFIER];
        cell.data = [self.historyArray objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
/*
 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 {
 UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
 clearButton.frame = CGRectMake(20, 5, 280, 35);
 clearButton.backgroundColor = [UIColor grayColor];
 [clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
 
 return clearButton;
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
