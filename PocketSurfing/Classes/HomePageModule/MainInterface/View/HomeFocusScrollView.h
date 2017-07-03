

#import <UIKit/UIKit.h>

@protocol HomeFocusViewDelegate <NSObject>
-(void)FocusButtonClick:(UIButton *)btn;
@end


@interface HomeFocusScrollView : UIScrollView
@property(nonatomic,retain)NSArray * picURLArray;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,assign)id<HomeFocusViewDelegate> focusDelegate;
@end
