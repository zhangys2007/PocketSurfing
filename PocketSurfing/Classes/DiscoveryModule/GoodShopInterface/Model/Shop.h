

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, copy)NSString * date;
@property (nonatomic, copy)NSString * discount;
@property (nonatomic, copy)NSString * aId;
@property (nonatomic, copy)NSString * info;
@property (nonatomic, copy)NSString * logo;
@property (nonatomic, copy)NSString * pic;
@property (nonatomic, copy)NSString * title;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
