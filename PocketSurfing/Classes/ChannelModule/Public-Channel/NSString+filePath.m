

#import "NSString+filePath.h"

@implementation NSString (filePath)
+(NSString *)filePath:(NSString *)fileName
{
    NSString * documentsPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString * filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return filePath;
}
-(NSString *)documentsFilePath
{
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString * filePath = [documentsPath stringByAppendingPathComponent:self];
    return filePath;
}
@end
