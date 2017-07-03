

#import <UIKit/UIKit.h>

#import "RefreshBaseTableVC.h"

@class Discover_Brand_Goods;
@interface Discover_Brand_GoodsViewController : RefreshBaseTableVC<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)Discover_Brand_Goods * discover_brand_goods;

@property (nonatomic, copy)NSString * max_imgUrlString;
@property (nonatomic, copy)NSString * brand_titString;
@property (nonatomic, copy)NSString * brandString;

@end
