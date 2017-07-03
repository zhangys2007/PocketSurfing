

#import "BrandShop.h"

@implementation BrandShop

-(void)dealloc{
    self.brand = nil;
    self.brand_cont = nil;
    self.brand_img = nil;
    self.brand_name = nil;
    self.brand_tit = nil;
    self.max_img = nil;
    self.tim = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.brand = [dic objectForKey:@"brand"];
        self.brand_cont = [dic objectForKey:@"brand_cont"];
        self.brand_img = [dic objectForKey:@"brand_img"];
        self.brand_name = [dic objectForKey:@"brand_name"];
        self.brand_tit = [dic objectForKey:@"brand_tit"];
        self.tim = [dic objectForKey:@"tim"];
        self.max_img = [dic objectForKey:@"max_img"];
    }
    return self;
}


@end
