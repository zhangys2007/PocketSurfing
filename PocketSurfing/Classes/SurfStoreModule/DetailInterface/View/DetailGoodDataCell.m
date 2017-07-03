

#import "DetailGoodDataCell.h"
#import "DetailGoodData.h"
#import "UIImageView+WebCache.h"
#import "SurfStoreMarcos.h"
#import "Header.h"
@implementation DetailGoodDataCell
//flowLayout.itemSize = CGSizeMake(145, 145 + 70);

- (void)dealloc
{
    self.data = nil;
    self.imageView = nil;
    self.nameLabel = nil;
    self.price_with_rateLabel = nil;
    self.priceLabel = nil;
    self.discountLabel = nil;
    self.soldLabel = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CELL_BACKGROUND_COLOR;
        
        self.imageView = [[UIImageView alloc] initWithFrame:IMAGEVIEW_SIZE];
        [self addSubview:self.imageView];
        [self.imageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + SCREEN_AUTO_SIZE 2, SCREEN_AUTO_SIZE 145, LABEL_HEIGHT)];
        self.nameLabel.font = FONT(SCREEN_AUTO_SIZE 16.0);
        [self addSubview:self.nameLabel];
        [self.nameLabel release];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 90, LABEL_HEIGHT)];
        //self.priceLabel.backgroundColor = [UIColor grayColor];
        self.priceLabel.textColor = RED_COLOR;
        self.priceLabel.font = FONT(SCREEN_AUTO_SIZE 14.0);
        [self addSubview:self.priceLabel];
        [self.priceLabel release];
        
        self.price_with_rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame), CGRectGetMinY(self.priceLabel.frame) + SCREEN_AUTO_SIZE 3, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 14)];
        self.price_with_rateLabel.tintColor = GRAY_COLOR;
        self.price_with_rateLabel.font = FONT(SCREEN_AUTO_SIZE 10.0);
        [self addSubview:self.price_with_rateLabel];
        [self.price_with_rateLabel release];
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.price_with_rateLabel.frame), CGRectGetMidY(self.price_with_rateLabel.frame), CGRectGetWidth(self.price_with_rateLabel.frame), SCREEN_AUTO_SIZE 1)];
        aView.backgroundColor = [UIColor grayColor];
        [self addSubview:aView];
        [aView release];
        
        
        self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 78, CGRectGetMaxY(self.priceLabel.frame), SCREEN_AUTO_SIZE 30, LABEL_HEIGHT)];
        self.discountLabel.font = FONT(SCREEN_AUTO_SIZE 12.0);
        self.discountLabel.textAlignment = NSTextAlignmentCenter;
        self.discountLabel.textColor = [UIColor whiteColor];
        self.discountLabel.backgroundColor = GREEN_COLOR;
        [self addSubview:self.discountLabel];
        [self.discountLabel release];
        
        UILabel * postLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.discountLabel.frame) + SCREEN_AUTO_SIZE 1, CGRectGetMinY(self.discountLabel.frame), self.discountLabel.frame.size.width, self.discountLabel.frame.size.height)];
        postLabel.textAlignment = NSTextAlignmentCenter;
        postLabel.textColor = [UIColor whiteColor];
        postLabel.backgroundColor = GREEN_COLOR;
        postLabel.font = FONT(SCREEN_AUTO_SIZE 12.0);
        [self addSubview:postLabel];
        postLabel.text = @"包邮";
        [postLabel release];
        
        self.soldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.priceLabel.frame), SCREEN_AUTO_SIZE 78, LABEL_HEIGHT)];
        self.soldLabel.tintColor = [UIColor grayColor];
        self.soldLabel.font = FONT(SCREEN_AUTO_SIZE 12.0);
        [self addSubview:self.soldLabel];
        [self.soldLabel release];
    }
    return self;
}
- (void)setData:(DetailGoodData *)data
{
    if (_data!= data) {
        [_data release];
        _data = [data retain];
    }
    self.nameLabel.text = data.title;
    self.priceLabel.text = [NSString stringWithFormat:@"现价￥:%@", data.price_with_rate];
    //self.priceLabel.tintColor = [UIColor colorWithRed:207 green:65 blue:125 alpha:0];
    self.price_with_rateLabel.text = [NSString stringWithFormat:@"￥:%@", data.price];
    self.discountLabel.text = [NSString stringWithFormat:@"%@折", data.discount];
    self.soldLabel.text = [NSString stringWithFormat:@"月销%@件", data.sold];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.pic_path] placeholderImage:[UIImage imageNamed:@"upload.png"]];
}

@end
