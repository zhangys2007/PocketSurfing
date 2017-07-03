

#import <UIKit/UIKit.h>
#import "SurfStoreMainInterfaceDataHandle.h"
#import "MainInterfaceHeader.h"

@class MySearchBar, SMVerticalSegmentedControl, CollectionView, SearchController;
@interface SurfStoreVC : UIViewController<UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, GetPostDelegate, ImageButtonDelegate>
/*****************************************************************************/
@property (nonatomic, retain) CollectionView * collectionView;
@property (nonatomic, retain) MySearchBar * searchBar;
@property (nonatomic, retain) SMVerticalSegmentedControl * segmentControl;
@property (nonatomic, retain) NSMutableArray * dataArray;
//@property (nonatomic, retain) NSArray * detailDataArray;
@property (nonatomic, retain) NSMutableDictionary * dataDic;
@property (nonatomic, retain) UIButton * helpButton;
/*****************************************************************************/

@end
