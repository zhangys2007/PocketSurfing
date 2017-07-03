

#import <UIKit/UIKit.h>
#import "RefreshBaseTableVC.h"

@class BrandShop;
@interface BrandViewController : RefreshBaseTableVC<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)BrandShop * brandShop;

@end
