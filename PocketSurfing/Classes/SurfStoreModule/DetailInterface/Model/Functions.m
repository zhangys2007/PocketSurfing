
#import "Functions.h"
#import "DetailGoodDataHandle.h"
#import "DetailGoodData.h"

@interface Functions ()
@property (nonatomic,copy)SuccessfullyBlock successBlock;
@end

@implementation Functions
- (void)dealloc
{
    self.dataArray = nil;
    [super dealloc];
}
-(id)initWithSuccessful:(SuccessfullyBlock)aSuccessful
{
    self = [super init];
    if (self) {
        self.successBlock = aSuccessful;
    }
    return self;
}
- (void)getArrayFromUrl:(NSString *)url
{
    DetailGoodDataHandle * handle = [[[DetailGoodDataHandle alloc] init] autorelease];
    [handle synchronousGetRequest:url];
    handle.delegate = self;
}
- (void)getData:(id)netData
{
    NSDictionary * dic = netData;
    NSArray * array = [dic objectForKey:@"list"];
    for (NSDictionary * dictionary in array) {
        DetailGoodData * data = [[DetailGoodData alloc] init];
        [data setValuesForKeysWithDictionary:dictionary];
        [self.dataArray addObject:data];
        [data release];
    }
    self.successBlock(_dataArray);
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
