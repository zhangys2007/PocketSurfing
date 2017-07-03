
#import "RandomPageCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#define K_PICWIDTH SCREEN_AUTO_SIZE 145

@implementation RandomPageCell
- (void)dealloc
{
    self.imageView = nil;
    self.titleLabel = nil;
    self.oldPriceLabel = nil;
    self.nowPriceLabel = nil;
    self.likeButton = nil;
    self.dataModel = nil;
    self.likeCountLabel = nil;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:self.bounds];
        //打开用户交互,否则button事件不会被触发
        backgroundView.userInteractionEnabled = YES;
        //加上边框线
        backgroundView.layer.borderWidth = SCREEN_AUTO_SIZE 0.5;
        //边框颜色,转换成CGColor
        backgroundView.layer.borderColor = COLOR(216, 216, 216).CGColor;
        backgroundView.image = [UIImage imageNamed:@"goods11_bg.png"];
        [self.contentView addSubview:backgroundView];
        
        //大图
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, K_PICWIDTH, K_PICWIDTH)];
        
        
        //        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.picURL]]];
        [backgroundView addSubview:_imageView];
        
        //价格标签背景图
        UIView * priceBgImage = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 5, K_PICWIDTH-SCREEN_AUTO_SIZE 16, SCREEN_AUTO_SIZE 95, SCREEN_AUTO_SIZE 15)];
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
        self.nowPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 8, (priceBgImage.height-SCREEN_AUTO_SIZE 10)/2, SCREEN_AUTO_SIZE 45, SCREEN_AUTO_SIZE 10)];
        _nowPriceLabel.textColor = COLOR(255, 0, 100);
        _nowPriceLabel.font = [UIFont boldSystemFontOfSize:SCREEN_AUTO_SIZE 14];
        _nowPriceLabel.textAlignment = NSTextAlignmentRight;
        //自适应文字大小
        _nowPriceLabel.adjustsFontSizeToFitWidth = YES;
        _nowPriceLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        

        
        self.oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nowPriceLabel.right, _nowPriceLabel.top, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 10)];
        _oldPriceLabel.textColor = COLOR(170, 170, 170);
        _oldPriceLabel.font = FONT(SCREEN_AUTO_SIZE 12);
        _oldPriceLabel.textAlignment = NSTextAlignmentCenter;
        //自适应文字大小
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        _oldPriceLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        
        
        
        [priceBgImage addSubview:_nowPriceLabel];
        [priceBgImage addSubview:_oldPriceLabel];
        
        //原价横线
        UIImageView * oldPricelineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_nowPriceLabel.right, 0,_oldPriceLabel.right - _nowPriceLabel.right,SCREEN_AUTO_SIZE 1)];
        //保持相对位置
        oldPricelineImageView.center = _oldPriceLabel.center;
        oldPricelineImageView.backgroundColor = COLOR(170, 170, 170);
        [priceBgImage addSubview:oldPricelineImageView];
        
        //商品标题Label
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, self.bounds.size.width, SCREEN_AUTO_SIZE 33)];
        _titleLabel.font = FONT(SCREEN_AUTO_SIZE 12);
        _titleLabel.textColor = COLOR(129, 129, 129);
        _titleLabel.numberOfLines = 0;
        [backgroundView addSubview:_titleLabel];
        
        //最下面的喜欢和看相似
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(SCREEN_AUTO_SIZE 10, _titleLabel.bottom+SCREEN_AUTO_SIZE 5, SCREEN_AUTO_SIZE 18, SCREEN_AUTO_SIZE 18);
        [_likeButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:_likeButton];
        
        
        self.likeCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_likeButton.frame), _likeButton.top, SCREEN_AUTO_SIZE 50, _likeButton.height)];
        //        NSLog(@"%f",_likeButton.frame.origin.x);
        //        NSLog(@"%f",likeCountLabel.frame.origin.x);
        _likeCountLabel.font = FONT(SCREEN_AUTO_SIZE 15);
        _likeCountLabel.textColor = COLOR(150, 150, 150);
        [backgroundView addSubview:_likeCountLabel];
        
        
        UIButton * similarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        similarBtn.frame = CGRectMake(_likeButton.right +SCREEN_AUTO_SIZE 35, _likeButton.top, SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 20);
        [similarBtn setTitle:@"点我收藏" forState:UIControlStateNormal];
        similarBtn.titleLabel.font = FONT(SCREEN_AUTO_SIZE 15);
        similarBtn.tintColor = COLOR(150, 150, 150);
        [similarBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:similarBtn];
        
        
        
        
        //        titleLabel.text = @"带那块噶速度来房间阿里山的空间飞啦拉数据的离开阿斯顿";
        
        
        
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        
        [backgroundView release];
        [_imageView release];
        [_nowPriceLabel release];
        [_oldPriceLabel release];
        [oldPricelineImageView release];

        [_titleLabel release];
        [_likeCountLabel release];
        
    }
    return self;
}
-(void)btnClick:(UIButton * )btn
{
    if (!_dataModel.isLike) {
        //动画
        
        //        UILabel * addOne = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeButton.frame), self.titleLabel.bottom+5, self.width/4, self.height-self.imageView.height-self.titleLabel.height)] autorelease];
        //        addOne.text = @"+1";
        //        addOne.textColor = [UIColor colorWithRed:234/255.0 green:56/255.0 blue:130/255.0 alpha:1.0];
        //        [self.contentView addSubview:addOne];
        //        [UIView beginAnimations:nil context:nil];
        //        [UIView setAnimationDuration:1.0];
        //        addOne.frame = CGRectMake(addOne.frame.origin.x, addOne.frame.origin.y - 10, addOne.frame.size.width, addOne.frame.size.height);
        //        [UIView commitAnimations];
        //        [addOne performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
        //
        //        //        [btn setImage:[UIImage imageNamed:@"icon_bbs_like_on_bottom.png"] forState:UIControlStateNormal];
        //        _likeCountLabel.text = [NSString stringWithFormat:@"%ld",[_likeCountLabel.text integerValue]+1];
        
        [_delegate likeBtnClick:self.dataModel cell:self];
    }
}
-(void)setDataModel:(RandomPageData *)dataModel
{
//    if (_dataModel != dataModel) {
//        [_dataModel release];
//        _dataModel = [dataModel retain];
//        [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataModel.rp_pic_url]] placeholderImage:[UIImage imageNamed:@"upload.png"]];
//        NSString * string;
//        if (_dataModel.rp_price.length >5) {
//            string = [_dataModel.rp_price substringToIndex:5];
//        }else{
//            string = _dataModel.rp_price;
//        }
//        
//        _nowPriceLabel.text = [NSString stringWithFormat:@"¥%@",string];
//        _oldPriceLabel.text = _dataModel.rp_old_price;
//        _titleLabel.text =[NSString stringWithFormat:@"【%@折】%@",_dataModel.rp_discount,_dataModel.rp_title];
//        _likeCountLabel.text = @"0";
//
//    }
    if (_dataModel != dataModel) {
        [_dataModel release];
        _dataModel = [dataModel retain];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataModel.rp_pic_url]] placeholderImage:[UIImage imageNamed:@"upload.png"]];
        NSString * string;
        if (_dataModel.rp_price.length >5) {
            string = [_dataModel.rp_price substringToIndex:5];
        }else{
            string = _dataModel.rp_price;
        }
        _nowPriceLabel.text = [NSString stringWithFormat:@"¥%@",string];
        _oldPriceLabel.text = _dataModel.rp_old_price;
        _titleLabel.text = [NSString stringWithFormat:@"【%@折】%@",_dataModel.rp_discount,_dataModel.rp_title];
        _likeCountLabel.text = @" ";
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"icon_bbs_like_on_bottom.png"] forState:UIControlStateSelected];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"icon_bbs_like_bottom.png"] forState:UIControlStateNormal];
        if (dataModel.isLike) {
            self.likeButton.selected = YES;
        }else{
            self.likeButton.selected = NO;
        }
    }
}
@end
