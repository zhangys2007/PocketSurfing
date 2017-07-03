
#import <UIKit/UIKit.h>

@class ChannelVC;

@interface AddChannelViewController : UITableViewController<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain)UICollectionView * collectionView;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)NSMutableArray * indexArray;
@property (nonatomic, retain)ChannelVC * channleVC;


@end
