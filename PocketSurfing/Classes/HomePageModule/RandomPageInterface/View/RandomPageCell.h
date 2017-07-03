


#import <UIKit/UIKit.h>
#import "RandomPageData.h"

@protocol RandomPageCollectionCellDelegate <NSObject>
-(void)likeBtnClick:(RandomPageData *)data cell:(id)cell;
-(void)similarBtnClick:(UIButton *)btn;
@end

@interface RandomPageCell : UICollectionViewCell
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)UILabel * nowPriceLabel;
@property(nonatomic, retain)UILabel * oldPriceLabel;
@property(nonatomic, retain)UILabel * titleLabel;
@property(nonatomic, retain)UILabel * likeCountLabel;
@property(nonatomic, retain)UIButton * likeButton;
@property(nonatomic, retain)RandomPageData * dataModel;

@property(nonatomic, assign)id<RandomPageCollectionCellDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;
@end
