

#import "Discover_Brand_GoodsCell.h"
#import "Discover_Brand_GoodsView.h"
#import "Discover_Brand_Goods.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@implementation Discover_Brand_GoodsCell

-(void)dealloc{
    self.discover_brand_goods = nil;
    self.discover_brand_goodsView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.discover_brand_goodsView = [[Discover_Brand_GoodsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 100)];
        _discover_brand_goodsView.backgroundColor = [UIColor whiteColor];;
        [self addSubview:_discover_brand_goodsView];
        [_discover_brand_goodsView release];
    }
    return self;
}

- (void)setDiscover_brand_goods:(Discover_Brand_Goods *)discover_brand_goods{
    if (_discover_brand_goods != discover_brand_goods) {
        [_discover_brand_goods release];
        _discover_brand_goods = [discover_brand_goods retain];
    }
        self.discover_brand_goodsView.titleLable.text = _discover_brand_goods.title;
        self.discover_brand_goodsView.discountLable.text = [NSString stringWithFormat:@"%@折", _discover_brand_goods.discount];
        self.discover_brand_goodsView.paixiaLable.text = _discover_brand_goods.paixia;
        self.discover_brand_goodsView.now_priceLable.text = [NSString stringWithFormat:@"￥%@", _discover_brand_goods.now_price];
        self.discover_brand_goodsView.priceLable.text = [NSString stringWithFormat:@"￥%@", _discover_brand_goods.price];
        //引用第三方 图片下载
       [self.discover_brand_goodsView.imgIV sd_setImageWithURL:[NSURL URLWithString:_discover_brand_goods.img]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
