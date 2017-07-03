

#import "BottomView.h"
#import "Header.h"

@implementation BottomView

- (void)dealloc
{
    self.goBackButton = nil;
    self.leftButton = nil;
    self.rightButton = nil;
    self.shareButton = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //forward_icon@2x.png
        //back_icon@2x.png
        //share@2x.png
        //back_tabbar_btn@2x.png
        self.goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goBackButton.frame = CGRectMake(SCREEN_AUTO_SIZE 20, 0, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 40);
        [self.goBackButton setBackgroundImage:[UIImage imageNamed:@"back_tabbar_btn.png"] forState:UIControlStateNormal];
        //self.goBackButton.backgroundColor = [UIColor grayColor];
        [self addSubview:self.goBackButton];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(SCREEN_AUTO_SIZE 100, 0, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 40);
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
        //self.leftButton.backgroundColor = [UIColor grayColor];
        [self addSubview:self.leftButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(SCREEN_AUTO_SIZE 180, 0, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 40);
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"forward_icon.png"] forState:UIControlStateNormal];
        //self.rightButton.backgroundColor = [UIColor grayColor];
        [self addSubview:self.rightButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareButton.frame = CGRectMake(SCREEN_AUTO_SIZE 260, 0, SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 40);
        [self.shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [self addSubview:self.shareButton];
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
