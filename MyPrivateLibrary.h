#ifndef MyPrivateLibrary_h
#define MyPrivateLibrary_h
#import "UIView+Frame.h"
#import "UIImage+Resize.h"
#import "UIView+Toast.h"
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#endif /* MyPrivateLibrary_h */
