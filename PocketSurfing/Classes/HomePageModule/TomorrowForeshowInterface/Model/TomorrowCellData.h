
#import <Foundation/Foundation.h>

@interface TomorrowCellData : NSObject
@property(nonatomic, copy)NSString * pic_url;
@property(nonatomic, copy)NSString * title;
@property(nonatomic, copy)NSString * now_price;
@property(nonatomic, copy)NSString * origin_price;
@property(nonatomic, copy)NSString * discount;
@property(nonatomic, copy)NSString * start_discount;
@property(nonatomic, copy)NSString * num_iid;
@property(nonatomic, assign)BOOL isRemind;
-(id)initWithDic:(NSDictionary *)dic;
@end
