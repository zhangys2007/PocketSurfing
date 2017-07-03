

#import "TomorrowCellData.h"
#define PICURL @"PICURL"
#define TITLE @"TITLE"
#define NOW_PRICE @"NOW_PRICE"
#define ORIGIN_PRICE @"ORIGIN_PRICE"
#define START_DISCOUNT @"START_DISCOUNT"
#define DISCOUNT @"DISCOUNT"
#define NUM_IID @"NUM_IID"
#define IS_REMIND @"IS_REMIND"
@implementation TomorrowCellData
- (void)dealloc
{
    self.pic_url = nil;
    self.title = nil;
    self.now_price = nil;
    self.origin_price = nil;
    self.discount = nil;
    self.start_discount =nil;
    self.num_iid = nil;
    [super dealloc];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.pic_url = [dic objectForKey:@"pic_url"];
        self.title = [dic objectForKey:@"title"];
        self.now_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"now_price"]];
        self.origin_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"origin_price"]];
        self.discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discount"]];
        self.start_discount =[dic objectForKey:@"start_discount"];
        self.num_iid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"num_iid"]];
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
    [aCoder encodeObject:self.start_discount forKey:START_DISCOUNT];
    [aCoder encodeObject:self.num_iid forKey:NUM_IID];
    [aCoder encodeBool:self.isRemind forKey:IS_REMIND];
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
        self.start_discount = [aDecoder decodeObjectForKey:START_DISCOUNT];
        self.num_iid = [aDecoder decodeObjectForKey:NUM_IID];
        self.isRemind = [aDecoder decodeBoolForKey:IS_REMIND];
    }
    return self;
}
@end
