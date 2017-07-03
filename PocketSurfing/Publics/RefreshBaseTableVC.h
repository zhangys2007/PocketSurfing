

#import <UIKit/UIKit.h>

@interface RefreshBaseTableVC : UITableViewController
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain)UITableView * tableView;
@property (nonatomic, assign)NSInteger  pageNum;
@property (nonatomic, assign)BOOL isRefresh;

-(void)loadDataWithPage:(NSInteger)pageNumber;
-(void)loadNewData;
@end
