






//字体大小
#define FONT(A) [UIFont systemFontOfSize:A]
//颜色的RGB值
#define COLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define SCREEN_SIZE_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_SIZE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_AUTO_SIZE SCREEN_SIZE_WIDTH/320*


#define MAIN_COLOR COLOR(85,150,201)

//用来调试的条件编译
#if 0
#define DEBUG_COLOR [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define LOG(A) NSLog(@"%@",A);

#else
#define DEBUG_COLOR [UIColor clearColor]
#define LOG(A) ;
#endif


