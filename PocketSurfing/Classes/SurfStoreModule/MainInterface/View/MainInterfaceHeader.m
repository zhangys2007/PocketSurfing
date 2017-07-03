

#import "MainInterfaceHeader.h"
#import "SurfStoreMainInterfaceData.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@implementation MainInterfaceHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageButton.frame = CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 215, SCREEN_AUTO_SIZE 75);
        self.imageButton.backgroundColor = [UIColor grayColor];
        [self.imageButton addTarget:self.delegate action:@selector(imageButtonDoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageButton];
    }
    return self;
}
- (void)imageButtonDoClick:(UIButton *)button
{
    [_delegate pushNextPage];
}
- (void)setData:(SurfStoreMainInterfaceData *)data
{
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }
}
- (void)dealloc
{
    self.delegate = nil;
    self.imageButton = nil;
    self.data = nil;
    [super dealloc];
}
@end
