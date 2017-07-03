

#import "RandomCollectionViewController.h"

#import "Header.h"
#import "NetWorkInterfaceBlock.h"
#import "RandomPageCell.h"
#import "HomePageReuseCellData.h"
@interface RandomCollectionViewController ()
@property(nonatomic, retain)NSMutableArray * dataArray;
@property(nonatomic, retain)NSMutableArray * likeDataArray;
@end

@implementation RandomCollectionViewController

static NSString * const reuseIdentifier = @"RandomCollectionCell";
- (void)dealloc
{
    self.dataArray = nil;
    self.likeDataArray =nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[RandomPageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self loadNewData];
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RandomPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.dataModel = self.dataArray[indexPath.row];
    // Configure the cell
    cell.delegate =self;
    return cell;
}

#pragma mark- 加载数据
//载入新数据
-(void)loadNewData
{
    [self loadDataWithPage:0];
}

-(void)loadDataWithPage:(NSInteger)pageNumber
{
    NetWorkInterfaceBlock * netWork = [[[NetWorkInterfaceBlock alloc]initWithSuccessful:^(NSDictionary *dic) {
        NSArray * resultArr = [dic objectForKey:@"data"];
        for (NSDictionary * dataDic  in resultArr) {
            RandomPageData * dataModel = [[RandomPageData alloc]initWithDic:dataDic];
            [self.dataArray addObject:dataModel];
            [dataModel release];
        }
        [self.collectionView reloadData];
    } fail:^BOOL(NSError *error) {
        return YES;
    }]autorelease];
    
    NSArray * array = @[@"%E9%92%B1%E5%8C%85",@"%E9%9B%A8%E4%BC%9E",@"%E7%AB%A5%E8%A3%85",@"%E6%AF%9B%E8%A1%A3",@"%E5%A4%96%E5%A5%97",@"%E5%A2%99%E7%BA%B8",@"%E6%89%8B%E6%9C%BA%E5%A3%B3"];
    NSArray * titleArray = @[@"钱包",@"雨伞",@"童装",@"毛衣",@"外套",@"墙纸",@"手机套"];
    NSInteger randomCount = (arc4random()%70)/10;
    self.title = titleArray[randomCount];
    NSString * urlString = [NSString stringWithFormat:@"http://m.repai.com/search/search_items_api/query/%@/offset/0/limit/130/price_start/0/price_end/80/appkey/100022/app_id/1066136336",array[randomCount]];
    
    
    [netWork get:urlString];
}


//懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
-(NSMutableArray *)likeDataArray
{
    if (_likeDataArray ==nil) {
        self.likeDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _likeDataArray;
}
#pragma mark 归档解档
//归档
-(void)archiveMethod
{
    //创建一个data容器
    NSMutableData * data = [NSMutableData dataWithCapacity:1];
    //创建一个归档器
    NSKeyedArchiver * keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //归档
    [keyedArchiver encodeObject:_likeDataArray forKey:@"Array"];
    [keyedArchiver finishEncoding];
    [data writeToFile:[@"likeGoodsHistory" documentsFilePath] atomically:YES];
    //刷新数组
    for (RandomPageData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.rp_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
}
//解档
-(void)unarchiverMethod
{
    //文件路径
    NSString * filePath = [@"likeGoodsHistory" documentsFilePath];
    //    NSLog(@"%@",filePath);
    //读取data
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:filePath];
    //解档器
    NSKeyedUnarchiver * keyedUnarchiver  = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //解档
    _likeDataArray = [keyedUnarchiver decodeObjectForKey:@"Array"];
//    NSLog(@"%@",_likeDataArray);
    
    
}
#pragma mark 点击"like" 和"相似"

-(void)likeBtnClick:(RandomPageData *)data cell:(id)cell
{
    //转化成 HomePageReuseCellData 类型数据
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:data.rp_pic_url,@"pic_url",data.rp_title,@"title",data.rp_price,@"now_price",data.rp_old_price,@"origin_price",@"0",@"total_love_number",data.rp_discount,@"discount",data.rp_iid,@"num_iid", nil];
    HomePageReuseCellData * newData = [[HomePageReuseCellData alloc]initWithDic:dic];
    //把对象放入收藏数组，先判断是否存在
    BOOL isExist = NO;
    for (HomePageReuseCellData * likeData in self.likeDataArray) {
        if ([likeData.num_iid isEqualToString:newData.num_iid]) {
            isExist = YES;
        }
    }
    if (!isExist) {
        //把从cell传过来的数据对象放入数组
        [self.likeDataArray addObject:newData];
    }

    //归档
    [self archiveMethod];
    //重新刷新当前 dataArray数据（修改是否被收藏）
    for (RandomPageData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.rp_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
    [self.collectionView reloadData];
}
-(void)similarBtnClick:(UIButton *)btn
{
//    NSLog(@"similarBtnClick");
}

#pragma mark- 视图将要出现
-(void)viewWillAppear:(BOOL)animated
{
    
    [self unarchiverMethod];
    //重新刷新当前 dataArray数据（修改是否被收藏）
    for (RandomPageData *netData in self.dataArray) {
        netData.isLike = NO;
        for (HomePageReuseCellData * likeData in self.likeDataArray) {
            if ([likeData.num_iid isEqualToString:netData.rp_iid]) {
                netData.isLike = YES;
                continue;
            }
        }
    }
    [self.collectionView reloadData];
    self.tabBarController.tabBar.hidden = YES;
}
//视图消失时候的方法
-(void)viewWillDisappear:(BOOL)animated
{
    self.title = nil;
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Public_WebView_ViewController * webView = [[Public_WebView_ViewController alloc]init];
    RandomPageData * model = self.dataArray[indexPath.row];
    webView.urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=b7546dbfd0cc03c8b63330a64bb59f0e29e9c944&app_version=2.5.3&app_channel=appstore&id=%@&sche=fenjiujiu&nine=1",model.rp_iid];
    [self.navigationController pushViewController:webView animated:YES];

    
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
