
#import <UIKit/UIKit.h>
@class MineReuseData;

@protocol MineDeleteDelegate <NSObject>
-(void)deleteGoods:(NSString *)num_iid;
@end

@interface MineCollectionViewCell : UICollectionViewCell

@property(nonatomic, retain)UIImageView * imageView;
@property(nonatomic, retain)UIButton * deleteButton;
@property(nonatomic, retain)MineReuseData * dataModel;
@property(nonatomic, assign)id<MineDeleteDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;

@end
