
#import "HpHeaderButtonView.h"
#import "Header.h"
@implementation HpHeaderButtonView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:self.bounds];
        backgroundView.image = [UIImage imageNamed:@"homepageBigView.jpg"];
        [self addSubview:backgroundView];
        
        for (int i  = 0; i<4; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor  = [UIColor clearColor];
            button.frame = CGRectMake(SCREEN_SIZE_WIDTH/4*i, 0, SCREEN_SIZE_WIDTH/4, SCREEN_AUTO_SIZE 40);
            button.tag = 500+i;
            [button addTarget:_delegate action:@selector(smallButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        //下面四个图片
        for (int i = 0; i<4; i++) {
            UIButton * button = [[UIButton buttonWithType:UIButtonTypeSystem] retain];
            button.backgroundColor  = [UIColor clearColor];
            if (i==0 || i==1 ) {
                button.frame = CGRectMake(SCREEN_AUTO_SIZE 320/3*i, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 320/3, SCREEN_AUTO_SIZE 130);
            }else if (i==2){
                button.frame = CGRectMake(SCREEN_AUTO_SIZE 320/3*2, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 320/3, SCREEN_AUTO_SIZE 70);
            }else{
                button.frame = CGRectMake(SCREEN_AUTO_SIZE 320/3*2, SCREEN_AUTO_SIZE 110, SCREEN_AUTO_SIZE 320/3, SCREEN_AUTO_SIZE 60);
            }
            button.tag = 504+i;
            [button addTarget:_delegate action:@selector(smallButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }


        
        
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
