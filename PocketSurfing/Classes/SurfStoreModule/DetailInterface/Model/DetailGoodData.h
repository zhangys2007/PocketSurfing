

#import <Foundation/Foundation.h>

@interface DetailGoodData : NSObject
/*
 "title": "百搭！玉栗贝人2015春秋装牛仔外套女长袖短款夹克牛仔上衣韩版潮",
 "sold": "1.0万",
 "pic_path": "http://gi3.mlist.alicdn.com/bao/uploaded/i3/T1aw8QFlhXXXXXXXXX_!!0-item_pic.jpg",
 "price": 308,
 "price_with_rate": 127,
 "discount": 4.1,
 "item_id": "21357783072"
 */
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * sold;
@property (nonatomic, copy) NSString * pic_path;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * price_with_rate;
@property (nonatomic, retain) NSNumber * discount;
@property (nonatomic, copy) NSString * item_id;

@end
