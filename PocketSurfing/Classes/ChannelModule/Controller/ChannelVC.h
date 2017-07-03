

#import <UIKit/UIKit.h>


@interface ChannelVC : UITableViewController<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain)NSMutableArray * indexArray;
@property (nonatomic, retain)UICollectionView * collectionView;
-(void)unarchiverMethod;

@end
