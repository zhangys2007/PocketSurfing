

#import <UIKit/UIKit.h>
@class TomorrowCellData;
@interface TomorrowCell : UICollectionViewCell
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)UILabel * nowPriceLabel;
@property(nonatomic, retain)UILabel * oldPriceLabel;
@property(nonatomic, retain)UILabel * titleLabel;
@property(nonatomic, retain)TomorrowCellData * dataModel;
@end
