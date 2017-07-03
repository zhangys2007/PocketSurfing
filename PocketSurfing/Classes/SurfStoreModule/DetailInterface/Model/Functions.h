
#import <Foundation/Foundation.h>
#import "DetailGoodDataHandle.h"
typedef void (^SuccessfullyBlock)(NSArray *array);

@interface Functions : NSObject<DetailGoodGetPostDelegate>

@property (nonatomic, retain) NSMutableArray * dataArray;
- (void)getArrayFromUrl:(NSString *)url;
-(id)initWithSuccessful:(SuccessfullyBlock)aSuccessful;
@end
