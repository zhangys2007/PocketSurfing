

#import <UIKit/UIKit.h>
#import "SearchBarHotWordDataHandle.h"

@class MySearchBar;
@interface ModalVCTableVC : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SearchBarGetPostDelegate>

@property (nonatomic, retain) UISegmentedControl * segmentControl;
@property (nonatomic, retain) UIButton * clearButton;
@property (nonatomic, retain) MySearchBar * searchBar;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * oneDayDataArray;
@property (nonatomic, retain) NSMutableArray * oneWeekDataArray;
@property (nonatomic, retain) NSMutableArray * tempArray;
@property (nonatomic, retain) NSMutableArray * historyArray;
@property (nonatomic, retain) UIButton * cancleButton;

@end
