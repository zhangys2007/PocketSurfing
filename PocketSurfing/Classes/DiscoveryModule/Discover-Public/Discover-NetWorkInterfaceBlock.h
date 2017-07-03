

#import <Foundation/Foundation.h>

typedef void (^SuccessfulBlock)(NSArray * array);

typedef BOOL (^FailBlock)(NSError *error);

@interface Discover_NetWorkInterfaceBlock : NSObject



-(id)initWithSuccessful:(SuccessfulBlock)aSuccessBlock fail:(FailBlock)aFailBlock;
-(void)get:(NSString *)urlString;
-(void)post:(NSString *)urlString params:(NSString *)paramString;
@end
