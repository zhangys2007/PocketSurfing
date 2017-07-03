

#import "Subject.h"

@implementation Subject
- (void)dealloc{
    self.addtime = nil;
    self.author = nil;
    self.des = nil;
    self.detail_content = nil;
    self.open = nil;
    self.pic_b_type = nil;
    self.pic_b_url = nil;
    self.pic_s_type = nil;
    self.pic_s_url = nil;
    self.showtime = nil;
    self.time = nil;
    self.title = nil;
    [super dealloc];
}


- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.addtime = [dic objectForKey:@"addtime"];
        self.author = [dic objectForKey:@"author"];
        self.des = [dic objectForKey:@"des"];
        self.detail_content = [dic objectForKey:@"detail_content"];
        self.detail_url = [dic objectForKey:@"detail_url"];
        self.open = [dic objectForKey:@"open"];
        self.pic_b_type = [dic objectForKey:@"pic_b_type"];
        self.pic_b_url = [dic objectForKey:@"pic_b_url"];
        self.pic_s_type = [dic objectForKey:@"pic_s_type"];
        self.pic_s_url = [dic objectForKey:@"pic_s_url"];
        self.showtime = [dic objectForKey:@"showtime"];
        self.time = [dic objectForKey:@"time"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}
@end
