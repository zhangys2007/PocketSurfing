

#import "LeftDrawTableViewCell.h"
#import "Header.h"
#define K_LEFT_MARGIN SCREEN_AUTO_SIZE 19
#define K_TOP_MARGIN SCREEN_AUTO_SIZE 7
#define K_IMAGE_LENGTH SCREEN_AUTO_SIZE 36

@interface LeftDrawTableViewCell()
@property (nonatomic, retain)UILabel * titleLabel;
@end

@implementation LeftDrawTableViewCell
- (void)dealloc
{
    self.title = nil;
    self.roundImageView = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.roundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(K_LEFT_MARGIN, K_TOP_MARGIN, K_IMAGE_LENGTH, K_IMAGE_LENGTH)];
//        _roundImageView.layer.borderWidth =SCREEN_AUTO_SIZE 0.5;
        _roundImageView.layer.masksToBounds = YES;
        _roundImageView.layer.cornerRadius = K_IMAGE_LENGTH/2;
        _roundImageView.backgroundColor = DEBUG_COLOR;
        [self.contentView addSubview:_roundImageView];
        [_roundImageView release];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_roundImageView.right+SCREEN_AUTO_SIZE 10, _roundImageView.top+SCREEN_AUTO_SIZE 3, SCREEN_AUTO_SIZE 50, SCREEN_AUTO_SIZE 30)];
        _titleLabel.text = self.title;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        UIImageView * arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+SCREEN_AUTO_SIZE 10, _titleLabel.top, SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 30)];
        arrowView.image = [UIImage imageNamed:@"right_btn.png"];

        [self.contentView addSubview:arrowView];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    if (_title !=title) {
        [_title release];
        _title = [title retain];
        self.titleLabel.text = _title;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
