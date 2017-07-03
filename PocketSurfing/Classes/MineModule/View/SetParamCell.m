
#import "SetParamCell.h"
#import "Header.h"

@implementation SetParamCell

- (void)dealloc{
    self.aImageView = nil;
    self.titleLable = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//                UIView * backgroundView = [[UIView alloc] initWithFrame:self.bounds];
//                backgroundView.backgroundColor = COLOR(255, 255, 255);
//                self.selectedBackgroundView = backgroundView;
        
        self.aImageView = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 10 , SCREEN_AUTO_SIZE 10 , SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 30) backgroundColor:DEBUG_COLOR];
        [self.contentView addSubview:_aImageView];
        
        self.titleLable = [UILabel lableWithRect:CGRectMake( SCREEN_AUTO_SIZE 40,  0, SCREEN_AUTO_SIZE 245, SCREEN_AUTO_SIZE 50) backgroundColor:DEBUG_COLOR font:FONT(15)  textColor:[UIColor grayColor]];
        [self.contentView addSubview:_titleLable];
        
        UIImageView * lineImageVIew = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 300, SCREEN_AUTO_SIZE 1) backgroundColor:DEBUG_COLOR];
        lineImageVIew.image = [UIImage imageNamed:@"line.png"];
        [self.contentView addSubview:lineImageVIew];
        
        UIImageView * right_btnImageView = [UIImageView imageViewWithRect:CGRectMake(SCREEN_AUTO_SIZE 230, SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 30) backgroundColor:DEBUG_COLOR];
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
