
#import <UIKit/UIKit.h>
#import "HomePageReuseCellData.h"


@protocol ReuseCollectionCellDelegate <NSObject>
-(void)likeBtnClick:(HomePageReuseCellData *)data cell:(id)cell;
-(void)similarBtnClick:(UIButton *)btn;
@end

@interface HomepageReuseCollectionCell : UICollectionViewCell
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)UILabel * nowPriceLabel;
@property(nonatomic, retain)UILabel * oldPriceLabel;
@property(nonatomic, retain)UILabel * titleLabel;
@property(nonatomic, retain)UILabel * likeCountLabel;
@property(nonatomic, retain)UIButton * likeButton;
@property(nonatomic, retain)HomePageReuseCellData * dataModel;
@property(nonatomic, assign)id<ReuseCollectionCellDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;
@end

