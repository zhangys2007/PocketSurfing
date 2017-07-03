

#import "CollectionView.h"
#import "SurfStoreVC.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@implementation CollectionView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.itemSize = CGSizeMake(SCREEN_AUTO_SIZE 60, SCREEN_AUTO_SIZE 85);
        self.flowLayout.minimumInteritemSpacing = SCREEN_AUTO_SIZE 5;
        self.flowLayout.minimumLineSpacing = SCREEN_AUTO_SIZE 15;
        self.flowLayout.headerReferenceSize = CGSizeMake(SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 100);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.flowLayout] autorelease];
        [self.flowLayout release];
        self.collectionView.contentInset = UIEdgeInsetsMake(SCREEN_AUTO_SIZE 10, SCREEN_AUTO_SIZE 10, 0, SCREEN_AUTO_SIZE 10);
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setDelegate:(id)delegate
{
    if (_delegate != delegate) {
        [_delegate release];
        _delegate = [delegate retain];
    }
    _collectionView.dataSource = _delegate;
    _collectionView.delegate = _delegate;
}
- (void)dealloc
{
    self.flowLayout = nil;
    self.collectionView = nil;
    self.delegate = nil;
    [super dealloc];
}
@end
