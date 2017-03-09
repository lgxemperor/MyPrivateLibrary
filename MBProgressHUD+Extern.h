//
//  MBProgressHUD+Extern.h
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/17.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extern)

+ (BOOL)isInView:(UIView *)view;

+ (void)showText:(NSString *)text inView:(UIView *)view;

+ (void)startLoadingWithInfo:(NSString *)text inView:(UIView *)view;
+ (void)doneLoadingWithErrorInfo:(NSString *)text inView:(UIView *)view;
+ (void)doneLoadingWithCorrectInfo:(NSString *)text inView:(UIView *)view;
+ (void)doneLoadingWithInfo:(NSString *)text signImageName:(NSString *)imageName inView:(UIView *)view;

@end
