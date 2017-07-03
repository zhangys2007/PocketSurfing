

#import "BrandShopCell.h"
#import "BrandShopView.h"
#import "BrandShop.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@implementation BrandShopCell
-(void)dealloc{
    self.brandShop = nil;
    self.brandShopView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.brandShopView = [[BrandShopView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, 0, SCREEN_AUTO_SIZE 310, SCREEN_AUTO_SIZE 180)];
        _brandShopView.backgroundColor = [UIColor whiteColor];;
        [self addSubview:_brandShopView];
        [_brandShopView release];
    }
    return self;
}

- (void)setBrandShop:(BrandShop *)brandShop{
    if (_brandShop != brandShop) {
        [_brandShop release];
        _brandShop = [brandShop retain];
    }
    self.brandShopView.brand_titLable.text = _brandShop.brand_tit;
    self.brandShopView.timLable.text = [NSString stringWithFormat:@"剩%@天", _brandShop.tim];
    //    //引用第三方 图片下载
    [self.brandShopView.brand_imgIV sd_setImageWithURL:[NSURL URLWithString:_brandShop.brand_img]placeholderImage:[UIImage imageNamed:@"waiting.png"]];
    [self.brandShopView.max_imgIV sd_setImageWithURL:[NSURL URLWithString:_brandShop.max_img]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
