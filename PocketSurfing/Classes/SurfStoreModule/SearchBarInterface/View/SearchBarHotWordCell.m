

#import "SearchBarHotWordCell.h"
#import "SearchBarHotWordData.h"
#import "Header.h"
@implementation SearchBarHotWordCell
- (void)dealloc
{
    self.name = nil;
    self.aView = nil;
    self.rate = nil;
//    self.data = nil;
    self.nameLabel = nil;
    self.aImageView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.aView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 15, SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 20)];
        [self.contentView addSubview:self.aView];
        self.aView.backgroundColor = [UIColor grayColor];
        [self.aView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 40, SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 180, SCREEN_AUTO_SIZE 30)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel release];
        
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 280, SCREEN_AUTO_SIZE 15, SCREEN_AUTO_SIZE 20, SCREEN_AUTO_SIZE 20)];
        [self.contentView addSubview:self.aImageView];
        [self.aImageView release];
    }
    return self;
}
- (void)setData:(SearchBarHotWordData *)data
{
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }
    
    self.nameLabel.text = data.name;
    if ([data.rate isEqualToString:@"rateup"]) {
        self.aImageView.image = [UIImage imageNamed:@"up.png"];
    }else{
        self.aImageView.image = [UIImage imageNamed:@"down.png"];
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
