

#import "Channel_Content.h"
#define IDSTRING @"id"
#define ISSELECT @"is_select"
#define LOGO @"logo"
#define LOGO2X @"logo_2x"
#define NAME @"name"
#define URL @"url"
@implementation Channel_Content
- (void)dealloc
{
    self.idString = nil;
    self.is_select = nil;
    self.logo = nil;
    self.logo_2x = nil;
    self.name = nil;
    self.url =  nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.idString = [dic objectForKey:IDSTRING];
        self.is_select = [dic objectForKey:ISSELECT];
        self.logo = [dic objectForKey:LOGO];
        self.logo_2x = [dic objectForKey:LOGO2X];
        self.name = [dic objectForKey:NAME];
        self.url =  [dic objectForKey:URL];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.idString forKey:IDSTRING];
    [aCoder encodeObject:self.is_select forKey:ISSELECT];
    [aCoder encodeObject:self.logo forKey:LOGO];
    [aCoder encodeObject:self.logo_2x forKey:LOGO2X];
    [aCoder encodeObject:self.name forKey:NAME];
    [aCoder encodeObject:self.url forKey:URL];

}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.idString = [aDecoder decodeObjectForKey:IDSTRING];
        self.is_select = [aDecoder decodeObjectForKey:ISSELECT];
        self.logo = [aDecoder decodeObjectForKey:LOGO];
        self.logo_2x = [aDecoder decodeObjectForKey:LOGO2X];
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.url = [aDecoder decodeObjectForKey:URL];
    }
    return self;
}
@end
