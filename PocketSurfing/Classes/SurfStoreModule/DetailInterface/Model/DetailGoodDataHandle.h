

#import <Foundation/Foundation.h>


@protocol DetailGoodGetPostDelegate <NSObject>
@required
- (void)getData:(id)netData;
@end

@interface DetailGoodDataHandle : NSObject
@property (nonatomic, assign) id<DetailGoodGetPostDelegate>delegate;
-(void)synchronousGetRequest:(NSString *)urlNetwork;
@end
