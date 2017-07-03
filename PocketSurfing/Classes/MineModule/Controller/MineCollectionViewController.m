

#import "MineCollectionViewController.h"
#import "MineCollectionViewCell.h"
#import "MineFlowLayout.h"
#import "Header.h"
#import "NSString+filePath.h"
#import "MineReuseData.h"
#import "HomePageReuseCellData.h"
#import "TomorrowCellData.h"
#import "SetParamViewController.h"

@interface MineCollectionViewController ()
@property(nonatomic, retain)NSMutableArray * likeDataArray;
@property(nonatomic, retain)NSMutableArray * remindDataArray;
@property(nonatomic, assign)NSInteger currentButton;
@property(nonatomic, retain)UIImageView * likeGoodsPicView;
@property(nonatomic, retain)UIImageView * remindPicView;
@end

@implementation MineCollectionViewController
- (void)dealloc
{
    self.likeDataArray = nil;
    self.remindDataArray = nil;
    self.likeGoodsPicView = nil;
    self.remindPicView = nil;
    [super dealloc];
}
static NSString * const reuseIdentifier = @"MineCell";
-(void)viewWillAppear:(BOOL)animated
{
    //解档
    [self unarchiverMethod];
    //刷新UI
    [self.collectionView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _currentButton = 0;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //调整内部margin
    self.collectionView.contentInset = UIEdgeInsetsMake(SCREEN_AUTO_SIZE 155, 0, 0,0);
    
    //添加title背景视图
    UIImageView * mineTitleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1*SCREEN_AUTO_SIZE 155, SCREEN_SIZE_WIDTH, SCREEN_AUTO_SIZE 155)];
    mineTitleView.image = [UIImage imageNamed:@"mine_title.png"];
    [self.collectionView addSubview:mineTitleView];
    mineTitleView.userInteractionEnabled = YES;
    [mineTitleView release];
    
    
    
    //点此登录button
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake((SCREEN_SIZE_WIDTH - SCREEN_AUTO_SIZE 60)/2,  SCREEN_AUTO_SIZE 55,SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 25);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"click_login_btn.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [mineTitleView addSubview:loginButton];
    
    
    UILabel * welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_SIZE_WIDTH-SCREEN_AUTO_SIZE 200)/2, loginButton.top-SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 200, SCREEN_AUTO_SIZE 30)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.text = @"欢迎来到口袋逛~";
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.textColor = [UIColor whiteColor];
    [mineTitleView addSubview:welcomeLabel];
    [welcomeLabel release];
    
    
    
    //添加四个功能区button
    NSArray * picNameArray = @[@"collect.png",@"clock.png",@"history.png",@"mine_selected.png"];
    NSArray * picSelectedArray = @[@"collect_selected.png",@"clock_selected.png",@"history_selected.png",@"mine_btn_click.png"];
    for (int i = 0; i<4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_SIZE_WIDTH/4 * i + SCREEN_SIZE_WIDTH/4 * 0.05,SCREEN_AUTO_SIZE 100 + (SCREEN_AUTO_SIZE 55)*0.15, SCREEN_SIZE_WIDTH/4 *0.9, (SCREEN_AUTO_SIZE 55)*0.7);
        if (i == 0) {
            [btn setBackgroundImage:[UIImage imageNamed:picSelectedArray[i]] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:picNameArray[i]] forState:UIControlStateNormal];
        }
        [btn setBackgroundImage:[UIImage imageNamed:picSelectedArray[i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 650+i;
        [mineTitleView addSubview:btn];
    }
    

    //添加商品收藏为空时的 button
    self.likeGoodsPicView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_SIZE_WIDTH - (SCREEN_AUTO_SIZE 225))/2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150)];
    //打开用户交互
    _likeGoodsPicView.userInteractionEnabled = YES;
    UIButton * likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = _likeGoodsPicView.bounds;
    [likeButton setBackgroundImage:[UIImage imageNamed:@"me_info_like.png"] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [_likeGoodsPicView addSubview:likeButton];
    [self.collectionView addSubview:_likeGoodsPicView];
    [_likeGoodsPicView release];
    
    //添加明日提醒为空时的 button
    self.remindPicView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 500, 0, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150)];
    //打开用户交互
    _remindPicView.userInteractionEnabled = YES;
    UIButton * remindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    remindButton.frame = _remindPicView.bounds;
    [remindButton setBackgroundImage:[UIImage imageNamed:@"me_info_follow.png"] forState:UIControlStateNormal];
    [remindButton addTarget:self action:@selector(remindButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_remindPicView addSubview:remindButton];
    [self.collectionView addSubview:_remindPicView];
    [_remindPicView release];
    
    //注册cell
    [self.collectionView registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //设置
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStyleDone target:self action:@selector(setParam)] autorelease];
    // Do any additional setup after loading the view.
}
#pragma mark- 不同的button 方法
-(void)functionBtnClick:(UIButton *)btn
{
    
    NSArray * picNameArray = @[@"collect.png",@"clock.png",@"history.png",@"mine_selected.png"];
    NSArray * picSelectedArray = @[@"collect_selected.png",@"clock_selected.png",@"history_selected.png",@"mine_btn_click.png"];
    NSInteger index = btn.tag -650;
    
    for (int i = 0; i<4; i++) {
        UIButton * button = (UIButton *)[self.collectionView viewWithTag:i+650];
        if (index == i) {
            [button setBackgroundImage:[UIImage imageNamed:picSelectedArray[i]] forState:UIControlStateNormal];
            
        }else{
            [button setBackgroundImage:[UIImage imageNamed:picNameArray[i]] forState:UIControlStateNormal];
        }
    }

    if (index == 0) {
        _currentButton = index;
        [self unarchiverMethod];
        self.remindPicView.frame = CGRectMake(SCREEN_AUTO_SIZE 500, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        [self.collectionView reloadData];
    }else if (index == 1){
        _currentButton = index;
        [self unarchiverMethod];
        //调整收藏按钮的frame
        self.likeGoodsPicView.frame = CGRectMake(SCREEN_AUTO_SIZE 500, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        [self.collectionView reloadData];
    }else if (index == 2){
        //充值页面
        Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
        webView.urlString = [NSString stringWithFormat:@"http://h5.m.taobao.com/app/cz/cost.html"];
        [self.navigationController pushViewController:webView animated:YES];
        [webView release];
    }else if (index == 3){
        //我的淘宝页面
        Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
        webView.urlString = [NSString stringWithFormat:@"http://h5.m.taobao.com/awp/mtb/mtb.htm"];
        [self.navigationController pushViewController:webView animated:YES];
        [webView release];
    }
}
//登录淘宝
-(void)loginClick:(UIButton *)btn
{
    //我的淘宝页面
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    webView.urlString = [NSString stringWithFormat:@"http://h5.m.taobao.com/awp/mtb/mtb.htm"];
    [self.navigationController pushViewController:webView animated:YES];
    [webView release];
}
//点击删除按钮
-(void)deleteGoods:(NSString *)num_iid
{
    //如果是收藏的商品
    if (_currentButton == 0) {
        //遍历收藏的Data数组
        for (int i = 0; i<_likeDataArray.count; i++) {
            //找到对应的model
            HomePageReuseCellData * likeData = _likeDataArray[i];
            if ([likeData.num_iid isEqualToString:num_iid]) {
                //把该model从数组删除
                [_likeDataArray removeObject:likeData];
            }
        }
        //归档
        [self archiveMethod];
        //调整收藏按钮的frame
        if (_likeDataArray.count == 0) {
            self.likeGoodsPicView.frame = CGRectMake((SCREEN_SIZE_WIDTH - (SCREEN_AUTO_SIZE 225))/2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        }
        //刷新UI
        [self.collectionView reloadData];
    //如果是提醒的商品
    }else{
        for (int i = 0; i<_remindDataArray.count;i++) {
            TomorrowCellData * remindData = _remindDataArray[i];
            if ([remindData.num_iid isEqualToString:num_iid]) {
                [_remindDataArray removeObject:remindData];

            }
        }
        [self archiveMethod];
        //调整收藏按钮的frame
        if (_remindDataArray.count == 0) {
            self.remindPicView.frame = CGRectMake((SCREEN_SIZE_WIDTH - (SCREEN_AUTO_SIZE 225))/2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        }
        //刷新UI
        [self.collectionView reloadData];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 空数据时点击button跳转
-(void)likeButtonClick
{
    [self.tabBarController setSelectedIndex:0];
}
-(void)remindButtonClick
{
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark 归档解档
//归档
-(void)archiveMethod
{
    if (_currentButton == 0) {
        //创建一个data容器
        NSMutableData * data = [NSMutableData dataWithCapacity:1];
        //创建一个归档器
        NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        //归档
        [keyedArchiver encodeObject:_likeDataArray forKey:@"Array"];
        [keyedArchiver finishEncoding];
        [data writeToFile:[@"likeGoodsHistory" documentsFilePath] atomically:YES];

    }else{
        //创建一个data容器
        NSMutableData * data = [NSMutableData dataWithCapacity:1];
        //创建一个归档器
        NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        //归档
        [keyedArchiver encodeObject:_remindDataArray forKey:@"Array"];
        [keyedArchiver finishEncoding];
        [data writeToFile:[@"remindGoodsHistory" documentsFilePath] atomically:YES];
    }
}
//解档
-(void)unarchiverMethod
{
    if (_currentButton == 0) {
        //文件路径
        NSString * filePath = [@"likeGoodsHistory" documentsFilePath];
        //    NSLog(@"%@",filePath);
        //读取data
        NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
        //解档器
        NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        //解档
        _likeDataArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
        //调整空数据button的位置
        if (_likeDataArray.count == 0) {
            self.likeGoodsPicView.frame = CGRectMake((SCREEN_SIZE_WIDTH - (SCREEN_AUTO_SIZE 225))/2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        }else{
            self.likeGoodsPicView.frame = CGRectMake(SCREEN_AUTO_SIZE 500, 0, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);

        }
        [self.collectionView reloadData];
    }else{
        //文件路径
        NSString * filePath = [@"remindGoodsHistory" documentsFilePath];
        //    NSLog(@"%@",filePath);
        //读取data
        NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
        //解档器
        NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        //解档
        _remindDataArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
        
        //调整空数据button的位置
        if (_remindDataArray.count == 0) {
            self.remindPicView.frame = CGRectMake((SCREEN_SIZE_WIDTH - (SCREEN_AUTO_SIZE 225))/2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        }else{
            self.remindPicView.frame = CGRectMake(SCREEN_AUTO_SIZE 500, 0, SCREEN_AUTO_SIZE 225, SCREEN_AUTO_SIZE 150);
        }
        [self.collectionView reloadData];
    }
    

    
}
//懒加载
-(NSMutableArray *)likeDataArray
{
    if (_likeDataArray ==nil) {
        self.likeDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _likeDataArray;
}
-(NSMutableArray *)remindDataArray
{
    if (_remindDataArray ==nil) {
        self.remindDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _remindDataArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 配置CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (_currentButton == 0) {
        return _likeDataArray.count;
    }else if (_currentButton == 1){
        return _remindDataArray.count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentButton == 0) {
        MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        //给Cell 的model赋值
        HomePageReuseCellData * likeModel = _likeDataArray[indexPath.row];
        MineReuseData * data  = [[MineReuseData alloc]init];
        data.num_iid = likeModel.num_iid;
        data.pic_url = likeModel.pic_url;
        cell.dataModel = data;
        return cell;
    }else if (_currentButton == 1){
        MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        //给Cell 的model赋值
        TomorrowCellData * remindModel = _remindDataArray[indexPath.row];
        MineReuseData * data  = [[MineReuseData alloc]init];
        data.num_iid = remindModel.num_iid;
        data.pic_url = remindModel.pic_url;
        cell.dataModel = data;
        return cell;
    }
    

    
    return nil;
}


- (void)setParam{
    
    SetParamViewController * setParamVC = [[SetParamViewController alloc] init];
    [self.navigationController pushViewController:setParamVC animated:YES];
    [setParamVC release];
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentButton == 0) {
        Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
        HomePageReuseCellData * model = self.likeDataArray[indexPath.row];
        webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",model.num_iid];
        [self.navigationController pushViewController:webView animated:YES];
        [webView release];
    }else if (_currentButton == 1)
    {
        Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
        TomorrowCellData * model = self.remindDataArray[indexPath.row];
        webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=810952387b3dc09b9759ba9b76ccb3ff729217b2&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu",model.num_iid];
        [self.navigationController pushViewController:webView animated:YES];
        [webView release];
    }
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
