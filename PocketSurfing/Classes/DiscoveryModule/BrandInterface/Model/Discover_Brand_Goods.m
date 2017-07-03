
#import "Discover_Brand_Goods.h"

@implementation Discover_Brand_Goods


-(void)dealloc{
    self.discount = nil;
    self.img = nil;
    self.now_price = nil;
    self.num_id = nil;
    self.paixia = nil;
    self.price = nil;
    self.tao_mao = nil;
    self.tim = nil;
    self.title = nil;
    [super dealloc];
}


- (id)initWithDictionary:(NSDictionary * )dic{
    self = [super init];
    if (self) {
        self.discount = [dic objectForKey:@"discount"];
        self.img = [dic objectForKey:@"img"];
        self.now_price = [dic objectForKey:@"now_price"];
        self.num_id = [dic objectForKey:@"num_id"];
        self.paixia = [dic objectForKey:@"paixia"];
        self.price = [dic objectForKey:@"price"];
        self.tao_mao = [dic objectForKey:@"tao_mao"];
        self.tim = [dic objectForKey:@"tim"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}


@end
