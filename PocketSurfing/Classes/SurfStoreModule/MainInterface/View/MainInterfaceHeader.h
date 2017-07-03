

#import <UIKit/UIKit.h>

@protocol ImageButtonDelegate <NSObject>

@required
- (void)pushNextPage;

@end
@class SurfStoreMainInterfaceData;
@interface MainInterfaceHeader : UICollectionReusableView

@property (nonatomic, assign) id<ImageButtonDelegate> delegate;
@property (nonatomic, retain) UIButton * imageButton;
@property (nonatomic, retain) SurfStoreMainInterfaceData * data;

@end
