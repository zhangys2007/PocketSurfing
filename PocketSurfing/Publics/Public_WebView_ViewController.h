

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@class BottomView;
@interface Public_WebView_ViewController :UITableViewController<UMSocialUIDelegate>
@property (copy, nonatomic)NSString * urlString;
@property (retain, nonatomic)BottomView * bottomView;
@property (nonatomic, copy) NSString * iconUrlString;
@property (nonatomic, copy) NSString * umSharecontent_text;
@end
