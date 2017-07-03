

#import "GoodsView.h"
#import "Header.h"

@implementation GoodsView
-(void)dealloc{
    self.discountLable = nil;
    self.now_priceLable = nil;
    self.origin_priceLable = nil;
    self.titleLable = nil;
    self.pic_urlIV = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //图片
        self.pic_urlIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 90, SCREEN_AUTO_SIZE 90)];
        _pic_urlIV.layer.borderWidth = 1.0;
        //_pic_urlIV.layer.borderColor = COLOR(235, 235, 235);
        [self addSubview:_pic_urlIV];
        [_pic_urlIV release];
        //标题
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 105, SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 180, SCREEN_AUTO_SIZE 40)];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15.0];
        _titleLable.numberOfLines = 2;
        _titleLable.backgroundColor = DEBUG_COLOR;
        [self addSubview:_titleLable];
        [_titleLable release];
        
        //现价
        self.now_priceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 105, SCREEN_AUTO_SIZE 45, SCREEN_AUTO_SIZE 85, SCREEN_AUTO_SIZE 30)];
        _now_priceLable.textColor = COLOR(193, 41, 95);
        _now_priceLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 22.0];
        _now_priceLable.backgroundColor = DEBUG_COLOR;
        [self addSubview:_now_priceLable];
        [_now_priceLable release];
        
        //原价
        self.origin_priceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 200, SCREEN_AUTO_SIZE 45, SCREEN_AUTO_SIZE 85, SCREEN_AUTO_SIZE 30)];
        _origin_priceLable.textColor = [UIColor grayColor];
        _origin_priceLable.backgroundColor = DEBUG_COLOR;
        [self addSubview:_origin_priceLable];
 
        
        UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_AUTO_SIZE 14, SCREEN_AUTO_SIZE 80, SCREEN_AUTO_SIZE 2)];
        lineIV.image =[UIImage imageNamed:@"line.png"];
        [_origin_priceLable addSubview:lineIV];
        [_origin_priceLable release];
        
        //月销量
//        UILabel * salesLable = [[UILabel alloc] initWithFrame:CGRectMake(105, 75, 95, 27)];
//        salesLable.text = [NSString stringWithFormat:@"月销量: %d件", (arc4random() %100 + 200)];
//        salesLable.font = [UIFont systemFontOfSize:14];
//        salesLable.textColor = [UIColor grayColor];
//        salesLable.backgroundColor = DEBUG_COLOR;
//        [self addSubview:salesLable];
//        [salesLable release];
        
        //包邮
        UILabel * postLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 200, SCREEN_AUTO_SIZE 78, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 20)];
        postLable.text = @"包邮";
        postLable.textAlignment = NSTextAlignmentCenter;
        postLable.backgroundColor = [UIColor greenColor];
        postLable.textColor = [UIColor whiteColor];
        postLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15];
        [self addSubview:postLable];
        [postLable release];
        
        //新品
        UILabel * newLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 245, SCREEN_AUTO_SIZE 78, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 20)];
        newLable.text = @"新品";
        newLable.textAlignment = NSTextAlignmentCenter;
        newLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15];
        newLable.backgroundColor = COLOR(193, 41, 95);
        newLable.textColor = [UIColor whiteColor];
        [self addSubview:newLable];
        [newLable release];
        
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
