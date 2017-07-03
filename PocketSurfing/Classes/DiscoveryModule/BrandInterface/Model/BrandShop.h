

#import <Foundation/Foundation.h>

@interface BrandShop : NSObject

@property (nonatomic, copy)NSString * brand;
@property (nonatomic, copy)NSString * brand_cont;
@property (nonatomic, copy)NSString * brand_img;
@property (nonatomic, copy)NSString * brand_name;
@property (nonatomic, copy)NSString * brand_tit;
@property (nonatomic, copy)NSString * max_img;
@property (nonatomic, copy)NSString * tim;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
