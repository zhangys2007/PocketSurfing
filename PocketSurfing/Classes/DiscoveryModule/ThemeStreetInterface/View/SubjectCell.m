
#import "SubjectCell.h"
#import "SubjectView.h"
#import "Subject.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation SubjectCell
-(void)dealloc{
    self.subjectView = nil;
    self.subject = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.subjectView = [[SubjectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 188)];
        //_subjectView.backgroundColor = DEBUG_COLOR;
        [self addSubview:_subjectView];
        [_subjectView release];
    }
    return self;
}

- (void)setSubject:(Subject *)subject{
    if (_subject != subject) {
        [_subject release];
        _subject = [subject retain];
    }
    self.subjectView.titleLable.text = _subject.title;
    self.subjectView.dayLable.text = [_subject.addtime substringWithRange:NSMakeRange(12, 2)];
    self.subjectView.desLable.text = _subject.des;
    self.subjectView.dateLable.text = [_subject.addtime substringWithRange:NSMakeRange(0, 11)];
//    //引用第三方 图片下载
     [self.subjectView.imageView sd_setImageWithURL:[NSURL URLWithString:_subject.pic_b_url]placeholderImage:[UIImage imageNamed:@"waiting.png"]];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
