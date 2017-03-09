//
//  MBProgressHUD+Extern.m
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/17.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import "MBProgressHUD+Extern.h"

@implementation MBProgressHUD (Extern)

+ (BOOL)isInView:(UIView *)view {
    
    if ([[MBProgressHUD allHUDsForView:view] count] > 0) {
        MBProgressHUD *hud = [[MBProgressHUD allHUDsForView:view] objectAtIndex:0];
        if (hud && hud.alpha > 0.5) {
            return YES;
        }
    }
    return NO;
}

+ (void)showText:(NSString *)text inView:(UIView *)view {

    NSArray *huds = [MBProgressHUD allHUDsForView:view];
    if (huds.count == 0) {
        MBProgressHUD *_progressHud = [[MBProgressHUD alloc] initWithFrame:view.frame];
        _progressHud.detailsLabelText = text;
        _progressHud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        _progressHud.mode = MBProgressHUDModeText;
        _progressHud.minSize = CGSizeMake(100, 40);
        [view addSubview:_progressHud];
        [_progressHud show:YES];
        [_progressHud hide:YES afterDelay:1.5];
    }
    else {
        MBProgressHUD *_progressHud = [huds objectAtIndex:0];
        _progressHud.detailsLabelText = text;
        _progressHud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        _progressHud.mode = MBProgressHUDModeText;
        _progressHud.minSize = CGSizeMake(100, 40);
        [view addSubview:_progressHud];
        [_progressHud show:YES];
        [_progressHud hide:YES afterDelay:1.5];
    }
}

#pragma mark -

+ (void)startLoadingWithInfo:(NSString *)text inView:(UIView *)view {
    
    NSArray *huds = [MBProgressHUD allHUDsForView:view];
    if (huds.count == 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:view.frame];
        hud.mode = MBProgressHUDModeIndeterminate;
        [view addSubview:hud];
        [hud show:YES];
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        hud.minSize = CGSizeMake(100, 100);
    }
    else {
        MBProgressHUD *hud = [huds objectAtIndex:0];
        [view addSubview:hud];
        [hud show:YES];
        hud.detailsLabelText = text;
        hud.mode = MBProgressHUDModeIndeterminate;
    }
}

+ (void)doneLoadingWithErrorInfo:(NSString *)text inView:(UIView *)view {
    
    [self doneLoadingWithInfo:text signImageName:@"alert_false" inView:view];
}

+ (void)doneLoadingWithCorrectInfo:(NSString *)text inView:(UIView *)view {
    
    [self doneLoadingWithInfo:text signImageName:@"alert_true" inView:view];
}

+ (void)doneLoadingWithInfo:(NSString *)text signImageName:(NSString *)imageName inView:(UIView *)view {
    
    NSArray *huds = [MBProgressHUD allHUDsForView:view];
    if (huds.count == 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:view.frame];
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        hud.minSize = CGSizeMake(100, 100);
        [view addSubview:hud];
        [hud show:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [hud hide:YES afterDelay:1.5];
    }
    else {
        MBProgressHUD *hud = [huds objectAtIndex:0];
        [view addSubview:hud];
        [hud show:YES];
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [hud hide:YES afterDelay:1.5];
    }
}

@end
