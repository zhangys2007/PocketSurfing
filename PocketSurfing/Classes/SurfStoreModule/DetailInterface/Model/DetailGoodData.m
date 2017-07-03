

#import "DetailGoodData.h"

@implementation DetailGoodData
/*
 "title": "百搭！玉栗贝人2015春秋装牛仔外套女长袖短款夹克牛仔上衣韩版潮",
 "sold": "1.0万",
 "pic_path": "http://gi3.mlist.alicdn.com/bao/uploaded/i3/T1aw8QFlhXXXXXXXXX_!!0-item_pic.jpg",
 "price": 308,
 "price_with_rate": 127,
 "discount": 4.1,
 "item_id": "21357783072"

 */
- (void)dealloc
{
    self.title = nil;
    self.sold = nil;
    self.pic_path = nil;
    self.price = nil;
    self.price_with_rate = nil;
    self.discount = nil;
    self.item_id = nil;
    [super dealloc];
}
@end
