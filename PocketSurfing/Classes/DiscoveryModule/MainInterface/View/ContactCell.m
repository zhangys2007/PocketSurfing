

#import "ContactCell.h"
#import "Header.h"

@implementation ContactCell
- (void)dealloc{
    self.aImageView = nil;
    self.titleLable = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        UIView * backgroundView = [[UIView alloc] initWithFrame:self.bounds];
//        backgroundView.backgroundColor = COLOR(255, 255, 255);
//        self.selectedBackgroundView = backgroundView;
        
        self.aImageView = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 10 , 0 , SCREEN_AUTO_SIZE 55, SCREEN_AUTO_SIZE 55) backgroundColor:DEBUG_COLOR];
        [self.contentView addSubview:_aImageView];
        
        self.titleLable = [UILabel lableWithRect:CGRectMake(_aImageView.right, _aImageView.top, SCREEN_AUTO_SIZE 265, SCREEN_AUTO_SIZE 55) backgroundColor:DEBUG_COLOR font:FONT(SCREEN_AUTO_SIZE 17)  textColor:COLOR(0, 0, 0)];
        [self.contentView addSubview:_titleLable];
        
        UIImageView * lineImageVIew = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 70, SCREEN_AUTO_SIZE 55, SCREEN_AUTO_SIZE 250, SCREEN_AUTO_SIZE 2) backgroundColor:DEBUG_COLOR];
        lineImageVIew.image = [UIImage imageNamed:@"line.png"];
        [self.contentView addSubview:lineImageVIew];
        
        UIImageView * right_btnImageView = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 200, 0, SCREEN_AUTO_SIZE 55, SCREEN_AUTO_SIZE 55) backgroundColor:DEBUG_COLOR];
        right_btnImageView.image = [UIImage imageNamed:@"right_btn_HD.png"];
        [_titleLable addSubview:right_btnImageView];

        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
