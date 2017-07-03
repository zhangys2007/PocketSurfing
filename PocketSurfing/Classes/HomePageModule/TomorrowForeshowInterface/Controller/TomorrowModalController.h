

#import <UIKit/UIKit.h>

@class TomorrowCellData,TomorrowCollectionViewController;
@interface TomorrowModalController : UIViewController
@property(nonatomic,retain)TomorrowCellData * dataModel;
@property(nonatomic, retain)TomorrowCollectionViewController * controller;
-(id)initWIthDataModel:(TomorrowCellData *)model;
@end
