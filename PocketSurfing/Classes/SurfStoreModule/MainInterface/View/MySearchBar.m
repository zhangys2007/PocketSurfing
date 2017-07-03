

#import "MySearchBar.h"

@implementation MySearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索你感兴趣的商品";
        [self sizeToFit];
    }
    return self;
}

@end
