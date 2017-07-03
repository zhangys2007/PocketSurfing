

#import "GoodsCell.h"
#import "GoodsView.h"
#import "Goods.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation GoodsCell
-(void)dealloc{
    self.goods = nil;
    self.goodsView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.goodsView = [[GoodsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 197)];
        _goodsView.backgroundColor = DEBUG_COLOR;
        [self addSubview:_goodsView];
        [_goodsView release];
    }
    return self;
}

- (void)setGoods:(Goods *)goods{
    if (_goods != goods) {
        [_goods release];
        _goods = [goods retain];
    }
    self.goodsView.titleLable.text = _goods.title;
    self.goodsView.now_priceLable.text = [NSString stringWithFormat:@" ￥ %@", _goods.now_price];
    self.goodsView.origin_priceLable.text = [NSString stringWithFormat:@" ￥ %@", _goods.origin_price];
    self.goodsView.discountLable.text = _goods.discount;
    //引用第三方 图片下载
    [self.goodsView.pic_urlIV sd_setImageWithURL:[NSURL URLWithString:_goods.pic_url] placeholderImage:[UIImage imageNamed:@"upload.png"]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
