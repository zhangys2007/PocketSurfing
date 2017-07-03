

#import "UIDefines.h"

@implementation UIImageView (CustomView)
+ (UIImageView *)imageViewWithRect:(CGRect)rect image:(UIImage *)aImage{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = aImage;
    return [imageView autorelease];
}

+ (UIImageView *)imageViewWithRect:(CGRect)rect backgroundColor:(UIColor *)color{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = color;
    return [imageView autorelease];
}



@end


@implementation UILabel (CustomView)

+ (UILabel *)lableWithRect:(CGRect)rect
           backgroundColor:(UIColor *)color
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor{
    UILabel * lable = [[UILabel alloc] initWithFrame:rect];
    lable.backgroundColor = color;
    lable.font = font;
    lable.textColor = textColor;
    return [lable autorelease];
}

@end
