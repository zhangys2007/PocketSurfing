

#import "DetailGoodDataHandle.h"
#import "AFNetworking.h"

@implementation DetailGoodDataHandle

- (void)synchronousGetRequest:(NSString *)urlNetwork
{
    AFHTTPRequestOperationManager * mananger = [AFHTTPRequestOperationManager manager];
    
    [mananger GET:urlNetwork parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(getData:)]) {
            [self.delegate getData:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
    }];
    

}
@end
