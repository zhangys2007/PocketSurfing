

#import "GoodShopCell.h"
#import "ShopView.h"
#import "Shop.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation GoodShopCell
-(void)dealloc{
    self.shopView = nil;
    self.shop = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shopView = [[ShopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 197)];
        _shopView.backgroundColor = DEBUG_COLOR;
        [self addSubview:_shopView];
        [_shopView release];
    }
    return self;
}

- (void)setShop:(Shop *)shop{
    if (_shop != shop) {
        [_shop release];
        _shop = [shop retain];
    }
    self.shopView.titleLable.text = _shop.title;
    self.shopView.dateLable.text = _shop.date;
    self.shopView.discountLable.text = _shop.discount;
    self.shopView.infoLable.text = _shop.info;
    //引用第三方 图片下载
    [self.shopView.picIV sd_setImageWithURL:[NSURL URLWithString:_shop.pic] placeholderImage:[UIImage imageNamed:@"upload.png"]];
    [self.shopView.logoIV sd_setImageWithURL:[NSURL URLWithString:_shop.logo]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
