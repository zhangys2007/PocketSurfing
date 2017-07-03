

#import "Channel_CustomCell.h"
#import "Header.h"
#import "Channel_Content.h"
#import "UIImageView+WebCache.h"

@implementation Channel_CustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 70)];
        _logoIV.backgroundColor = DEBUG_COLOR;
        _logoIV.layer.cornerRadius = SCREEN_AUTO_SIZE 2;
        
        [self addSubview:_logoIV];
        [_logoIV release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 20)];
        _nameLabel.backgroundColor = DEBUG_COLOR;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 14.0];
        [self addSubview:_nameLabel];
        [_nameLabel release];
        
    }
    return self;
}

- (void)setChannel_Content:(Channel_Content *)channel_Content{
    if (_channel_Content != channel_Content) {
        [_channel_Content  release];
        _channel_Content = [channel_Content retain];
    }
    self.nameLabel.text = _channel_Content.name;
    [self.logoIV sd_setImageWithURL:[NSURL URLWithString:_channel_Content.logo_2x]];
}

@end
