

#import <UIKit/UIKit.h>

@class SearchBarHotWordData;
@interface SearchBarHotWordCell : UITableViewCell

@property (nonatomic, retain) UILabel * nameLabel;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * rate;
@property (nonatomic, retain) SearchBarHotWordData * data;
@property (nonatomic, retain) UIView * aView;
@property (nonatomic, retain) UIImageView * aImageView;

@end
