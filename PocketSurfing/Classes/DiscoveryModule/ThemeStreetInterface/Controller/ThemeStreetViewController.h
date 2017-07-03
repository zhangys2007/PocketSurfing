

#import <UIKit/UIKit.h>
#import "RefreshBaseTableVC.h"
@class Subject;
@interface ThemeStreetViewController : RefreshBaseTableVC<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)Subject * subject;
- (void)rotateImage;
@end
