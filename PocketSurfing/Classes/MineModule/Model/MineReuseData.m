
#import "MineReuseData.h"

@implementation MineReuseData
- (void)dealloc
{
    self.num_iid= nil;
    self.pic_url = nil;
    [super dealloc];
}

@end
