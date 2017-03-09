//
//  LGXAppUtil.h
//  EnjoyNight
//
//  Created by XIAOCAN JUN on 15/9/28.
//  Copyright © 2015年 XIAOCAN JUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
@interface LGXAppUtil : NSObject
+(CGFloat)statusBarHeight;
+(CGFloat)navigationBarHeight;
+(CGFloat)tabBarHeight;
///屏幕高度
+(CGFloat)screenHeight;
///屏幕宽度
+(CGFloat)screenWidth;
///屏幕除Statusbar外的高度
+(CGFloat)mainFrameHeight;
///屏幕除Statusbar和导航条外的高度
+(CGFloat)usableHeight;
///屏幕宽度
+(CGFloat)mainFrameWidth;
///APP_NAME
+(NSString *)appName;
///APP_BUILD
+(NSString *)appBuild;
///APP_VERSION
+(NSString *)appVersion;
///IOS_VERSION
+(float)iosVersion;
+(void)makePhoneCall:(NSString *)phoneNumber;
@end
