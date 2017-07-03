

#import "SubjectView.h"
#import "Header.h"
@implementation SubjectView
-(void)dealloc{
    self.imageView = nil;
    self.dayLable = nil;
    self.dateLable = nil;
    self.titleLable = nil;
    self.desLable = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 120)];
        _imageView.backgroundColor = DEBUG_COLOR;
        [self addSubview:_imageView];
        [_imageView release];
        
        self.dayLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 125, SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 30)];
        _dayLable.backgroundColor = DEBUG_COLOR;
        _dayLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 20];
        _dayLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dayLable];
        [_dayLable release];
        
        UIImageView * dataLineIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 42, SCREEN_AUTO_SIZE 120, SCREEN_AUTO_SIZE 21, SCREEN_AUTO_SIZE 68)];
        dataLineIV.image = [UIImage imageNamed:@"time_line_bg.png"];
        [self addSubview:dataLineIV];
        [dataLineIV release];
        
        self.dateLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 120, SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 40)];
        _dateLable.backgroundColor = DEBUG_COLOR;
        _dateLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 15.0];
        _dateLable.numberOfLines = 2;
        [self addSubview:_dateLable];
        [_dateLable release];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 130, SCREEN_AUTO_SIZE 120, SCREEN_AUTO_SIZE 170, SCREEN_AUTO_SIZE 40)];
        _titleLable.backgroundColor = DEBUG_COLOR;
        [self addSubview:_titleLable];
        [_titleLable release];
        
        self.desLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 160, SCREEN_AUTO_SIZE 230, SCREEN_AUTO_SIZE 30)];
        _desLable.textColor = [UIColor grayColor];
        _desLable.backgroundColor = DEBUG_COLOR;
        _desLable.font = [UIFont systemFontOfSize:SCREEN_AUTO_SIZE 14.0];
        [self addSubview:_desLable];
        [_desLable release];
        
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
