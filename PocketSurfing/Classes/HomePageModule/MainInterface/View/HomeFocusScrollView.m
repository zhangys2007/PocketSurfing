

#import "HomeFocusScrollView.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "Public_WebView_ViewController.h"

@implementation HomeFocusScrollView
- (void)dealloc
{
    self.picURLArray = nil;
    self.scrollView = nil;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.contentSize = CGSizeMake(SCREEN_SIZE_WIDTH * 1,SCREEN_AUTO_SIZE 105);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
-(void)setPicURLArray:(NSArray *)picURLArray
{
    if (_picURLArray != picURLArray) {
        [_picURLArray release];
        _picURLArray = [picURLArray retain];
    }

    self.contentSize = CGSizeMake(SCREEN_SIZE_WIDTH * _picURLArray.count,SCREEN_AUTO_SIZE 105);
    for (int i = 0; i < _picURLArray.count; i++) {
        
        UIImageView * aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_SIZE_WIDTH * i, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 105)];
        aImageView.userInteractionEnabled  = YES;
        [aImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.picURLArray objectAtIndex:i]]]];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
//        button.backgroundColor = DEBUG_COLOR;
        button.frame = CGRectMake(0, 0, SCREEN_SIZE_WIDTH, aImageView.height);
        button.tag = 600+i;
        [button addTarget:_focusDelegate action:@selector(FocusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [aImageView addSubview:button];
        [self addSubview:aImageView];
        [aImageView release];
    }
    
}


@end
