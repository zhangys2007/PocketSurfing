
#import "BrandShopView.h"
#import "Header.h"

@implementation BrandShopView

-(void)dealloc{
    self.brand_imgIV = nil;
    self.brand_titLable = nil;
    self.max_imgIV = nil;
    self.timLable = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.max_imgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 310, SCREEN_AUTO_SIZE 130)];
        _max_imgIV.backgroundColor = DEBUG_COLOR;
        [self addSubview:_max_imgIV];

        self.timLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 260, 0, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 20)];
        _timLable.backgroundColor = [UIColor blackColor];
        _timLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15.0];
       // _timLable.textAlignment = NSTextAlignmentCenter;
        _timLable.textColor = [UIColor whiteColor];
        [_max_imgIV addSubview:_timLable];
        [_timLable release];
        
        UIImageView * watchIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 240, 0, SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 20)];
        watchIV.image = [UIImage imageNamed:@"goodlist_message_time_blue.png"];
        watchIV.backgroundColor = [UIColor blackColor];
        [_max_imgIV addSubview:watchIV];
        [watchIV release];
        [_max_imgIV release];
        
        self.brand_titLable = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 240, SCREEN_AUTO_SIZE 40)];
        _brand_titLable.backgroundColor = [UIColor whiteColor];
        _brand_titLable.textColor = [UIColor grayColor];
        [self addSubview:_brand_titLable];
        [_brand_titLable release];
        
        self.brand_imgIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 220, SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 80, SCREEN_AUTO_SIZE 40)];
        _brand_imgIV.backgroundColor = DEBUG_COLOR;
        [self addSubview:_brand_imgIV];
        [_brand_imgIV release];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
