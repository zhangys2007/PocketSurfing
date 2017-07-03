
#import "MineFlowLayout.h"
#import "Header.h"
@implementation MineFlowLayout
-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(SCREEN_AUTO_SIZE 90, SCREEN_AUTO_SIZE 90);
        //滚动方向上的间隔
        self.minimumLineSpacing = SCREEN_AUTO_SIZE 10;
        //另一方向上的间隔
        self.minimumInteritemSpacing = 0;
        //设置区头视图的大小
        self.headerReferenceSize = CGSizeMake(SCREEN_SIZE_WIDTH, SCREEN_SIZE_WIDTH*10/320);
        //设置cell的margin
        self.sectionInset = UIEdgeInsetsMake(0, SCREEN_AUTO_SIZE 20, 0, SCREEN_AUTO_SIZE 10);
    }
    return self;
}
@end
