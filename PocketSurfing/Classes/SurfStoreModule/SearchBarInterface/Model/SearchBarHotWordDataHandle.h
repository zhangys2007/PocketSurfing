

#import <Foundation/Foundation.h>

@protocol SearchBarGetPostDelegate <NSObject>

@required
- (void)getData:(id)netData;

@end

@interface SearchBarHotWordDataHandle : NSObject

@property (nonatomic, assign) id<SearchBarGetPostDelegate>delegate;
-(void)synchronousGetRequest:(NSString *)urlNetwork;


@end
