

#import <UIKit/UIKit.h>
#import "DetailGoodDataHandle.h"

@interface SecondViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, DetailGoodGetPostDelegate>

@property (nonatomic, retain) UICollectionView * collectionView;
@property (nonatomic, retain) UISegmentedControl * segmentControl;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, assign)BOOL isRefresh;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * keyWord;

@end
