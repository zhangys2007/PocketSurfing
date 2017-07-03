

#import <Foundation/Foundation.h>

@interface RandomPageData : NSObject
@property(nonatomic, copy)NSString * rp_pic_url;
@property(nonatomic, copy)NSString * rp_title;
@property(nonatomic, copy)NSString * rp_price;
@property(nonatomic, copy)NSString * rp_old_price;
@property(nonatomic, copy)NSString * rp_discount;
@property(nonatomic, copy)NSString * rp_iid;
@property(nonatomic, assign)BOOL isLike;
-(id)initWithDic:(NSDictionary *)dic;
@end
