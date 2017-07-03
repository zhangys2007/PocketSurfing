
#import "Shop.h"

@implementation Shop

- (void)dealloc{
    self.date = nil;
    self.discount = nil;
    self.aId = nil;
    self.logo = nil;
    self.info = nil;
    self.pic = nil;
    self.title = nil;
    [super dealloc];
}

-(id)initWithDictionary:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        self.date = [dic objectForKey:@"date"];
        self.discount = [dic objectForKey:@"discount"];
        self.aId = [dic objectForKey:@"id"];
        self.logo = [dic objectForKey:@"logo"];
        self.info = [dic objectForKey:@"info"];
        self.pic = [dic objectForKey:@"pic"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}
@end
