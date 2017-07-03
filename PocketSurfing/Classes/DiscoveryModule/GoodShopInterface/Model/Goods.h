

#import <Foundation/Foundation.h>

@interface Goods : NSObject


@property (nonatomic, copy)NSString * discount;
@property (nonatomic, copy)NSString * now_price;
@property (nonatomic, copy)NSString * num_iid;
@property (nonatomic, copy)NSString * origin_price;
@property (nonatomic, copy)NSString * pic_url;
@property (nonatomic, copy)NSString * title;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
