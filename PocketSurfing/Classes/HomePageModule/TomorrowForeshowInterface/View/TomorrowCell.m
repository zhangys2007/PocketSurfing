

#import "TomorrowCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "TomorrowCellData.h"
#define K_PICWIDTH SCREEN_AUTO_SIZE 145
@implementation TomorrowCell
- (void)dealloc
{
    self.imageView = nil;
    self.titleLabel = nil;
    self.oldPriceLabel = nil;
    self.nowPriceLabel = nil;

    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //加上边框线
        self.contentView.layer.borderWidth = SCREEN_AUTO_SIZE 0.5;
        //边框颜色,转换成CGColor
        self.contentView.layer.borderColor = COLOR(216, 216, 216).CGColor;
        //大图
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, K_PICWIDTH, K_PICWIDTH)];
        
        [self.contentView addSubview:_imageView];
        
        //价格标签背景图
        UIImageView * priceBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, K_PICWIDTH-SCREEN_AUTO_SIZE 16, SCREEN_AUTO_SIZE 95, SCREEN_AUTO_SIZE 15)];
        priceBgImage.backgroundColor = [UIColor whiteColor];
        priceBgImage.layer.masksToBounds = NO;
        priceBgImage.layer.cornerRadius = SCREEN_AUTO_SIZE 7;
        priceBgImage.alpha = 0.7;
        //边框粗细
        priceBgImage.layer.borderWidth = SCREEN_AUTO_SIZE 0.5;
        //边框颜色,转换成CGColor
        priceBgImage.layer.borderColor = [UIColor grayColor].CGColor;
        [_imageView addSubview:priceBgImage];
        
        //现价原价Label
        self.nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, (priceBgImage.height-SCREEN_AUTO_SIZE 10)/2, SCREEN_AUTO_SIZE 45, SCREEN_AUTO_SIZE 10)];
        _nowPriceLabel.textColor = COLOR(255, 0, 100);
        _nowPriceLabel.font = [UIFont boldSystemFontOfSize:SCREEN_AUTO_SIZE 15];
        _nowPriceLabel.textAlignment = NSTextAlignmentRight;
        

        
        self.oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nowPriceLabel.right, _nowPriceLabel.top, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 10)];
        _oldPriceLabel.textColor = COLOR(170, 170, 170);
        _oldPriceLabel.font = FONT(SCREEN_AUTO_SIZE 13);
        _oldPriceLabel.textAlignment = NSTextAlignmentCenter;
        

        
        [priceBgImage addSubview:_oldPriceLabel];
        [priceBgImage addSubview:_nowPriceLabel];
        

        //原价横线
        UIImageView * oldPricelineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_nowPriceLabel.right, 0,_oldPriceLabel.right - _nowPriceLabel.right,1)];
        //保持相对位置
        oldPricelineImageView.center = _oldPriceLabel.center;
        oldPricelineImageView.backgroundColor = COLOR(170, 170, 170);
        [priceBgImage addSubview:oldPricelineImageView];
        
        //商品标题Label
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, self.bounds.size.width, SCREEN_AUTO_SIZE 33)];
        _titleLabel.font = FONT(SCREEN_AUTO_SIZE 12);
        _titleLabel.textColor = COLOR(129, 129, 129);
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        


        
        
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        

        [_imageView release];
        [priceBgImage release];
        [_nowPriceLabel release];
        [_oldPriceLabel release];
        [oldPricelineImageView release];
        [_titleLabel release];

    }
    return self;
}

-(void)setDataModel:(TomorrowCellData *)dataModel
{
    if (_dataModel != dataModel) {
        [_dataModel release];
        _dataModel = [dataModel retain];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataModel.pic_url]] placeholderImage:[UIImage imageNamed:@"upload.png"]];
        NSString * string;
        if (_dataModel.now_price.length >5) {
            string = [_dataModel.now_price substringToIndex:5];
        }else{
            string = _dataModel.now_price;
        }
        _nowPriceLabel.text = [NSString stringWithFormat:@"¥%@",string];
        _oldPriceLabel.text = _dataModel.origin_price;
        _titleLabel.text = [NSString stringWithFormat:@"【%@折】%@",_dataModel.discount,_dataModel.title];
    }
}

@end
