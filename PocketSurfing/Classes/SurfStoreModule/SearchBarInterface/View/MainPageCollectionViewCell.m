

#import "MainPageCollectionViewCell.h"
#import "SurfStoreMainInterfaceData.h"
#import "Header.h"
@implementation MainPageCollectionViewCell

- (void)dealloc
{
    self.imageView = nil;
    self.aLabel = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, 0, SCREEN_AUTO_SIZE 45, SCREEN_AUTO_SIZE 65)];
        self.imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageView];
        
        self.aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 65, SCREEN_AUTO_SIZE 65, SCREEN_AUTO_SIZE 25)];
        self.aLabel.textAlignment = NSTextAlignmentCenter;
        //self.aLabel.backgroundColor = [UIColor redColor];
        self.aLabel.font = [UIFont systemFontOfSize:14.0];
        self.aLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.aLabel];
        
        [self.imageView release];
        [self.aLabel release];
    }
    return self;
}
- (void)setData:(SurfStoreMainInterfaceData *)data
{
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }
    self.aLabel.text = data.name;
}
@end
