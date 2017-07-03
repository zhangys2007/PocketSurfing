

#import <UIKit/UIKit.h>
#import "RefreshBaseTableVC.h"

@class Shop;
@interface GoodShopViewController : RefreshBaseTableVC<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)Shop * shop;
- (void)rotateImage;

@end
