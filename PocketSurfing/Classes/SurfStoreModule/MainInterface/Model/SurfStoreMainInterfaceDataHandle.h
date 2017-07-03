

#import <Foundation/Foundation.h>


@protocol GetPostDelegate <NSObject>
@required
- (void)getData:(id)netData;
@end
@interface SurfStoreMainInterfaceDataHandle : NSObject
@property (nonatomic, assign) id<GetPostDelegate>delegate;
-(void)synchronousGetRequest:(NSString *)urlNetwork;
-(void)asynchronousGetRequest:(NSString *)urlNetwork;
-(void)stopConnection;
@end
