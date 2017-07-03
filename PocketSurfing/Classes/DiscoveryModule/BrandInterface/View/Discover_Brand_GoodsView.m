

#import "Discover_Brand_GoodsView.h"
#import "Header.h"

@implementation Discover_Brand_GoodsView


- (void)dealloc
{
    self.imgIV = nil;
    self.titleLable = nil;
    self.now_priceLable = nil;
    self.priceLable = nil;
    self.discountLable = nil;
    self.paixiaLable = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * right_btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 270, SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 50)];
        right_btnImageView.image = [UIImage imageNamed:@"right_btn_HD.png"];
        [self addSubview:right_btnImageView];
        [right_btnImageView release];
        
        self.imgIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 120, SCREEN_AUTO_SIZE 90)];
        _imgIV.backgroundColor = DEBUG_COLOR;
        _imgIV.layer.cornerRadius = SCREEN_AUTO_SIZE 5;
        [self addSubview:_imgIV];
        [_imgIV release];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 170, SCREEN_AUTO_SIZE 30)];
        _titleLable.backgroundColor = DEBUG_COLOR;
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 14.0];
        [self addSubview:_titleLable];
        [_titleLable release];
        
        self.now_priceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 75, SCREEN_AUTO_SIZE 40)];
        _now_priceLable.backgroundColor =DEBUG_COLOR;
        _now_priceLable.textColor = [UIColor redColor];
        _now_priceLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 20];
        _now_priceLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_now_priceLable];
        [_now_priceLable release];
        
        self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 215, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 40)];
        _priceLable.backgroundColor = DEBUG_COLOR;
        _priceLable.textColor = [UIColor grayColor];
        _priceLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLable];

        
        UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 19, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 2)];
        lineIV.image =[UIImage imageNamed:@"line.png"];
        [_priceLable addSubview:lineIV];
        [lineIV release];
        [_priceLable release];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 75, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 20)];
        imageView.image = [UIImage imageNamed:@"bg_tuan_detail_zhekou.png"];
        [self addSubview:imageView];
        
        
        self.discountLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 20)];
        _discountLable.textColor = [UIColor whiteColor];
        _discountLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 14.0];
        
        _discountLable.textAlignment = NSTextAlignmentCenter;
        //_discountLable.backgroundColor = DEBUG_COLOR;
        [imageView addSubview:_discountLable];
        [imageView release];
        [_discountLable release];
        
        self.paixiaLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 180, SCREEN_AUTO_SIZE 75, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 20)];
        _paixiaLable.textColor = [UIColor whiteColor];
        _paixiaLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15.0];
        _paixiaLable.backgroundColor = [UIColor redColor];
        [self addSubview:_paixiaLable];
        [_paixiaLable release];
        
        UILabel * pastLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 250, SCREEN_AUTO_SIZE 75, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 20)];
        pastLable.backgroundColor = [UIColor greenColor];
        pastLable.textColor = [UIColor whiteColor];
        pastLable.textAlignment = NSTextAlignmentCenter;
        pastLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15.0];
        pastLable.layer.cornerRadius = SCREEN_AUTO_SIZE 2;
        pastLable.text  = @"包邮";
        [self addSubview:pastLable];
        [pastLable release];
        
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
