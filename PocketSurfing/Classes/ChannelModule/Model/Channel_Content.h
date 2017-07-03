

#import <Foundation/Foundation.h>

@interface Channel_Content : NSObject

@property (nonatomic, copy)NSString * idString;
@property (nonatomic, copy)NSString * is_select;
@property (nonatomic, copy)NSString * logo;
@property (nonatomic, copy)NSString * logo_2x;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * url;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
