

#import "Goods.h"

@implementation Goods

-(void)dealloc{
    self.discount = nil;
    self.now_price = nil;
    self.num_iid = nil;
    self.origin_price = nil;
    self.pic_url = nil;
    self.title = nil;
    [super dealloc];
}

-(id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.discount = [dic objectForKey:@"discount"];
        self.now_price = [dic objectForKey:@"now_price"];
        self.num_iid = [dic objectForKey:@"num_iid"];
        self.origin_price = [dic objectForKey:@"origin_price"];
        self.pic_url = [dic objectForKey:@"pic_url"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}
@end
