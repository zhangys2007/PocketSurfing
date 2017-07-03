

#import <Foundation/Foundation.h>

@interface Discover_Brand_Goods : NSObject

@property (nonatomic, copy)NSString * discount;
@property (nonatomic, copy)NSString * img;
@property (nonatomic, copy)NSString * now_price;
@property (nonatomic, copy)NSString * num_id;
@property (nonatomic, copy)NSString * paixia;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, copy)NSString * tao_mao;
@property (nonatomic, copy)NSString * tim;
@property (nonatomic, copy)NSString * title;

- (id)initWithDictionary:(NSDictionary * )dic;

@end
