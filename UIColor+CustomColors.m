//
//  UIColor+CustomColors.m
//  toHomeMerchant
//
//  Created by emperor on 16/6/28.
//  Copyright © 2016年 JUN XUN. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)
+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}
@end
