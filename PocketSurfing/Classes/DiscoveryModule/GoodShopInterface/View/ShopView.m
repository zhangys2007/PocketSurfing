

#import "ShopView.h"
#include "Header.h"
#import "UIImageView+WebCache.h"

@implementation ShopView
-(void)dealloc{
    self.dateLable = nil;
    self.discountLable = nil;
    self.infoLable = nil;
    self.logoIV = nil;
    self.picIV = nil;
    self.titleLable = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundImageView.image = [UIImage imageNamed:@"backgrd.png"];
        [self addSubview:backgroundImageView];
        
        //小图标
        self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 18, SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 15)];
        _logoIV.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_logoIV];
        
        //品牌折扣
        UILabel * rebateLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 40, 0, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 50)];
        rebateLable.text = @"品牌折扣";
        rebateLable.textColor = [UIColor whiteColor];
        rebateLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 11.0];
        [backgroundImageView addSubview:rebateLable];
        [rebateLable release];
        
        //打折
        self.discountLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 95, SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 100, SCREEN_AUTO_SIZE 30)];
        _discountLable.textColor = [UIColor redColor];
        _discountLable.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_discountLable];
        [_discountLable release];
        
        //简介
        self.infoLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 80, SCREEN_AUTO_SIZE 150, SCREEN_AUTO_SIZE 60)];
        _infoLable.numberOfLines = 0;
        _infoLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 13.0];
        _infoLable.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_infoLable];
        [_infoLable release];

        //大图片
        self.picIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 195, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 105, SCREEN_AUTO_SIZE 105)];
        _picIV.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_picIV];
        

        
        //日期
        self.dateLable  = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 165, SCREEN_AUTO_SIZE 80, SCREEN_AUTO_SIZE 30)];
        _dateLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 13.0];
        _dateLable.textColor = [UIColor grayColor];
        _dateLable.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_dateLable];
        [_dateLable release];
        
        //标题
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 195, SCREEN_AUTO_SIZE 165, SCREEN_AUTO_SIZE 100, SCREEN_AUTO_SIZE 30)];
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 13.0];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor grayColor];
        _titleLable.backgroundColor = DEBUG_COLOR;
        [backgroundImageView addSubview:_titleLable];
        [_titleLable release];
        
    }
    return self;
}




@end
