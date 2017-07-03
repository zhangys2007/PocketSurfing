

#import <UIKit/UIKit.h>
@class Subject;
@class SubjectView;
@interface SubjectCell : UITableViewCell

@property (nonatomic, retain)SubjectView * subjectView;
@property (nonatomic, retain)Subject * subject;

@end
