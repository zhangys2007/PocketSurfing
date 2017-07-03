

#import "ResentSearchCell.h"
#import "SearchBarHotWordData.h"
#import "Header.h"
@implementation ResentSearchCell

- (void)dealloc
{
    self.cellName = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 160, SCREEN_AUTO_SIZE 30)];
        //self.cellName.backgroundColor = [UIColor grayColor];
        [self addSubview:self.cellName];
        [self.cellName release];
    }
    return self;
}
- (void)setData:(SearchBarHotWordData *)data
{
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }
    self.cellName.text = [NSString stringWithFormat:@"商品: %@", data.name];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
