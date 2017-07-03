

#import "SurfStoreMainInterfaceDataHandle.h"
#import "AFNetworking.h"

@interface SurfStoreMainInterfaceDataHandle ()
@property(nonatomic, retain )NSMutableData *data;
@property(nonatomic, retain)NSURLConnection * connection;
@end

@implementation SurfStoreMainInterfaceDataHandle
- (void)dealloc
{
    self.data = nil;
    [super dealloc];
}
-(void)synchronousGetRequest:(NSString *)urlNetwork
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

-(void)asynchronousGetRequest:(NSString *)urlNetwork
{
    //生成URL对象
    NSURL * url = [NSURL URLWithString:urlNetwork];
    //生成request(请求)
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

//已经接收相应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    //
    self.data = [NSMutableData dataWithCapacity:1];
    
}
//已经接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [_data appendData:data];
}
//已经接受完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    [self.delegate getData:dic];
}
-(void)stopConnection
{
    [self.connection cancel];
}


@end
