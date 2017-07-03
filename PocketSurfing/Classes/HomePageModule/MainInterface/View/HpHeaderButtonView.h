
#import <UIKit/UIKit.h>

@protocol HomePageHerderButtonDelegate <NSObject>

-(void)smallButtonClikc:(UIButton *)btn;
//-(void)worthToBuyClikc:(UIButton *)btn;
//-(void)everyoneBuyClick:(UIButton *)btn;
//-(void)tomorrowBuyClick:(UIButton *)btn;
//-(void)tryYourLuckClick:(UIButton *)btn;
@end


@interface HpHeaderButtonView : UIView
@property(nonatomic, assign)id<HomePageHerderButtonDelegate> delegate;
@end
