

#import <UIKit/UIKit.h>

@interface UICollectionView ()

@property (nonatomic, assign) NSInteger index;

@end
@class SurfStoreVC;
@interface CollectionView : UIView

@property (nonatomic, retain) UICollectionView * collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, assign) id delegate;

@end
