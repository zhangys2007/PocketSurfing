

#import "MineCollectionViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "MineReuseData.h"
@implementation MineCollectionViewCell
- (void)dealloc
{
    self.imageView = nil;
    self.deleteButton = nil;
    self.dataModel = nil;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.frame = self.bounds;
        [self.contentView addSubview:_imageView];
        [_imageView release];
        
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(self.bounds.size.width - (SCREEN_AUTO_SIZE 30), self.bounds.size.height - (SCREEN_AUTO_SIZE 30), SCREEN_AUTO_SIZE 30, SCREEN_AUTO_SIZE 30);
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"garbage.png"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_deleteButton];
    }
    return self;
}
-(void)btnClick:(UIButton *)btn
{
    [_delegate deleteGoods:_dataModel.num_iid];
}
-(void)setDataModel:(MineReuseData *)dataModel
{
    if (_dataModel != dataModel) {
        [_dataModel release];
        _dataModel = [dataModel retain];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic_url]];
    }
}
@end
