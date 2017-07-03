

#import <UIKit/UIKit.h>

@interface RefreshBaseCollectionVC : UICollectionViewController
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic, assign)NSInteger  pageNum;
@property (nonatomic, assign)BOOL isRefresh;

-(void)loadDataWithPage:(NSInteger)pageNumber;
@end
