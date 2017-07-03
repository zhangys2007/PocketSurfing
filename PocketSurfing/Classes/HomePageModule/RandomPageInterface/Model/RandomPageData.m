

#import "RandomPageData.h"
#define PICURL @"PICURL"
#define TITLE @"TITLE"
#define NOW_PRICE @"NOW_PRICE"
#define ORIGIN_PRICE @"ORIGIN_PRICE"
#define TOTAL_LOVE_NUMBER @"TOTAL_LOVE_NUMBER"
#define DISCOUNT @"DISCOUNT"
#define NUM_IID @"NUM_IID"
#define IS_LIKE @"ISLIKE"
@implementation RandomPageData
- (void)dealloc
{
    self.rp_pic_url = nil;
    self.rp_title = nil;
    self.rp_price = nil;
    self.rp_old_price = nil;
    self.rp_discount = nil;
    self.rp_iid = nil;
    [super dealloc];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.rp_pic_url = [dic objectForKey:@"rp_pic_url"];
        self.rp_title = [dic objectForKey:@"rp_title"];
        self.rp_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rp_price"]];
        if ([self.rp_price floatValue]==0) {
            self.rp_price = @"0.0";
        }
        self.rp_old_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rp_old_price"]];
        self.rp_discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rp_discount"]];
        self.rp_iid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rp_iid"]];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.rp_pic_url forKey:PICURL];
    [aCoder encodeObject:self.rp_title forKey:TITLE];
    [aCoder encodeObject:self.rp_price forKey:NOW_PRICE];
    [aCoder encodeObject:self.rp_discount forKey:DISCOUNT];
    [aCoder encodeObject:self.rp_old_price forKey:ORIGIN_PRICE];
    [aCoder encodeObject:self.rp_iid forKey:NUM_IID];
    [aCoder encodeBool:self.isLike forKey:IS_LIKE];
}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.rp_pic_url = [aDecoder decodeObjectForKey:PICURL];
        self.rp_title = [aDecoder decodeObjectForKey:TITLE];
        self.rp_price = [aDecoder decodeObjectForKey:NOW_PRICE];
        self.rp_discount = [aDecoder decodeObjectForKey:DISCOUNT];
        self.rp_old_price = [aDecoder decodeObjectForKey:ORIGIN_PRICE];
        self.rp_iid = [aDecoder decodeObjectForKey:NUM_IID];
        self.isLike = [aDecoder decodeBoolForKey:IS_LIKE];
    }
    return self;
}
@end
