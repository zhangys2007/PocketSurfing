

#import "MyFlowLayout.h"
#import "Header.h"
@implementation MyFlowLayout
-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(SCREEN_AUTO_SIZE 145, SCREEN_AUTO_SIZE 205);
        //滚动方向上的间隔
        self.minimumLineSpacing = SCREEN_AUTO_SIZE 5;
        //另一方向上的间隔
        self.minimumInteritemSpacing = 0;
        //设置区头视图的大小
        self.headerReferenceSize = CGSizeMake(SCREEN_SIZE_WIDTH, SCREEN_AUTO_SIZE 10);
        //设置cell的margin
        self.sectionInset = UIEdgeInsetsMake(0, SCREEN_AUTO_SIZE 10, 0, SCREEN_AUTO_SIZE 10);
    }
    return self;
}
@end
