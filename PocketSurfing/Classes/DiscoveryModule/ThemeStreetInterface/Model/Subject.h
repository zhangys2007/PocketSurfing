

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property (nonatomic, copy)NSString * addtime;
@property (nonatomic, copy)NSString * author;
@property (nonatomic, copy)NSString * des;
@property (nonatomic, copy)NSString * detail_content;
@property (nonatomic, copy)NSString * detail_url;
@property (nonatomic, copy)NSString * open;
@property (nonatomic, copy)NSString * pic_b_type;
@property (nonatomic, copy)NSString * pic_b_url;
@property (nonatomic, copy)NSString * pic_s_type;
@property (nonatomic, copy)NSString * pic_s_url;
@property (nonatomic, copy)NSString * showtime;
@property (nonatomic, copy)NSString * time;
@property (nonatomic, copy)NSString * title;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
