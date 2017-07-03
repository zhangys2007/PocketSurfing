

#import <Foundation/Foundation.h>
typedef void (^SuccessfulBlock)(NSDictionary *dic);

typedef BOOL (^FailBlock)(NSError *error);

@interface NetWorkInterfaceBlock : NSObject



-(id)initWithSuccessful:(SuccessfulBlock)aSuccessBlock fail:(FailBlock)aFailBlock;
-(void)get:(NSString *)urlString;
-(void)post:(NSString *)urlString params:(NSString *)paramString;
@end
