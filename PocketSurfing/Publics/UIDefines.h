
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CustomView)

+ (UIImageView *)imageViewWithRect:(CGRect)rect image:(UIView *)aImage;

+ (UIImageView *)imageViewWithRect:(CGRect)rect backgroundColor:(UIColor *)color;



@end

@interface UILabel (CustomView)

+ (UILabel *)lableWithRect:(CGRect)rect
           backgroundColor:(UIColor *)color
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor;


@end


