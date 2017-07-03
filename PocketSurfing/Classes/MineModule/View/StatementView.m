

#import "StatementView.h"
#import "Header.h"

@implementation StatementView
- (void)dealloc
{
    self.statementLable = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.statementLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 300, SCREEN_AUTO_SIZE 400)];
        _statementLable.numberOfLines = 0;
        _statementLable.text = @"    我们是一个致力于移动电商领域软件研发与应用服务的团队.\n    我们的架构师,开发工程师,产品设计师,或许是你曾耳熟能详的业内大拿.\n";
        [self addSubview:_statementLable];
        [_statementLable release];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
