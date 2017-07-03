

#import "HomePageReuseCellData.h"
#define PICURL @"PICURL"
#define TITLE @"TITLE"
#define NOW_PRICE @"NOW_PRICE"
#define ORIGIN_PRICE @"ORIGIN_PRICE"
#define TOTAL_LOVE_NUMBER @"TOTAL_LOVE_NUMBER"
#define DISCOUNT @"DISCOUNT"
#define NUM_IID @"NUM_IID"
@implementation HomePageReuseCellData
- (void)dealloc
{
    self.pic_url = nil;
    self.title = nil;
    self.now_price = nil;
    self.origin_price = nil;
    self.total_love_number = nil;
    self.discount = nil;
    self.num_iid = nil;
//    self.dic = nil;
    [super dealloc];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.pic_url = [dic objectForKey:@"pic_url"];
        self.title = [dic objectForKey:@"title"];
        self.now_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"now_price"]];
        self.discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discount"]];
        self.origin_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"origin_price"]];
        self.total_love_number = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total_love_number"]];
        self.num_iid = [dic objectForKey:@"num_iid"];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.pic_url forKey:PICURL];
    [aCoder encodeObject:self.title forKey:TITLE];
    [aCoder encodeObject:self.now_price forKey:NOW_PRICE];
    [aCoder encodeObject:self.discount forKey:DISCOUNT];
    [aCoder encodeObject:self.origin_price forKey:ORIGIN_PRICE];
    [aCoder encodeObject:self.total_love_number forKey:TOTAL_LOVE_NUMBER];
    [aCoder encodeObject:self.num_iid forKey:NUM_IID];
}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.pic_url = [aDecoder decodeObjectForKey:PICURL];
        self.title = [aDecoder decodeObjectForKey:TITLE];
        self.now_price = [aDecoder decodeObjectForKey:NOW_PRICE];
        self.discount = [aDecoder decodeObjectForKey:DISCOUNT];
        self.origin_price = [aDecoder decodeObjectForKey:ORIGIN_PRICE];
        self.total_love_number = [aDecoder decodeObjectForKey:TOTAL_LOVE_NUMBER];
        self.num_iid = [aDecoder decodeObjectForKey:NUM_IID];
    }
    return self;
}
@end
