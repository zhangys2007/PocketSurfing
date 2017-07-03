

#import <Foundation/Foundation.h>

@interface HomePageReuseCellData : NSObject
@property(nonatomic, copy)NSString * pic_url;
@property(nonatomic, copy)NSString * title;
@property(nonatomic, copy)NSString * now_price;
@property(nonatomic, copy)NSString * origin_price;
@property(nonatomic, copy)NSString * total_love_number;
@property(nonatomic, copy)NSString * discount;
@property(nonatomic, copy)NSString * num_iid;
@property(nonatomic, assign)BOOL isLike;
-(id)initWithDic:(NSDictionary *)dic;
@end
