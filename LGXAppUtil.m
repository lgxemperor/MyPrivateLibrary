//
//  LGXAppUtil.m
//  EnjoyNight
//
//  Created by XIAOCAN JUN on 15/9/28.
//  Copyright © 2015年 XIAOCAN JUN. All rights reserved.
//

#import "LGXAppUtil.h"

@implementation LGXAppUtil
+(CGFloat)statusBarHeight{
    return 20.0f;
}
+(CGFloat)tabBarHeight{
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        return 49.0f;
    }else{
        return 44.0f;
    }
}
+(CGFloat)navigationBarHeight{
    return 44.0f;
}
+(CGFloat)screenHeight{
    CGRect keyFrame=[[UIScreen mainScreen] bounds];
    return CGRectGetHeight(keyFrame);
}
+(CGFloat)screenWidth{
    CGRect keyFrame=[[UIScreen mainScreen] bounds];
    return CGRectGetWidth(keyFrame);
}
+(CGFloat)mainFrameWidth{
    CGRect keyFrame=[[UIScreen mainScreen] bounds];
    return CGRectGetWidth(keyFrame);
}
+(CGFloat)mainFrameHeight{
    CGRect keyFrame=[[UIScreen mainScreen] bounds];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        return CGRectGetHeight(keyFrame);
    }else{
        return CGRectGetHeight(keyFrame)-20.0f;
    }
}
+(CGFloat)usableHeight{
    CGRect keyFrame=[[UIScreen mainScreen] bounds];
    return CGRectGetHeight(keyFrame)-64.0f;
}
+(NSString *)appName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)appBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+(float)iosVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+(void)makePhoneCall:(NSString *)phoneNumber{
     //iOS 拨打电话三种方式总结
    //打完电话后还会回到原来的程序，也会弹出提示，推荐这种
    UIWindow *keyWindow=[[UIApplication sharedApplication] keyWindow];
    NSMutableString * phoneStr=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneStr]]];
    [keyWindow addSubview:callWebview];
}


@end
