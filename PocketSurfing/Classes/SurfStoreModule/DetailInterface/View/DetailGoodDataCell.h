

#import <UIKit/UIKit.h>

@class DetailGoodData;
@interface DetailGoodDataCell : UICollectionViewCell
/*
 "title": "百搭！玉栗贝人2015春秋装牛仔外套女长袖短款夹克牛仔上衣韩版潮",
 "sold": "1.0万",
 "pic_path": "http://gi3.mlist.alicdn.com/bao/uploaded/i3/T1aw8QFlhXXXXXXXXX_!!0-item_pic.jpg",
 "price": 308,
 "price_with_rate": 127,
 "discount": 4.1,
 "item_id": "21357783072"
 */

@property (nonatomic, retain) DetailGoodData * data;
@property (nonatomic, retain) UIImageView * imageView;
@property (nonatomic, retain) UILabel * nameLabel;
@property (nonatomic, retain) UILabel * priceLabel;
@property (nonatomic, retain) UILabel * price_with_rateLabel;
@property (nonatomic, retain) UILabel * discountLabel;
@property (nonatomic, retain) UILabel * soldLabel;

@end
