

#import "SearchBarHotWordData.h"
#define NAME_KEY @"name"
#define RATE_KEY @"key"

@implementation SearchBarHotWordData

- (void)dealloc
{
//    self.name = nil;
    self.rate = nil;
    [super dealloc];
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:NAME_KEY];
    [aCoder encodeObject:self.rate forKey:RATE_KEY];
}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:NAME_KEY];
        self.rate = [aDecoder decodeObjectForKey:RATE_KEY];
    }
    return self;
}
@end
