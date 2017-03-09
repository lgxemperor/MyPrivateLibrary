//
//  UIView+Frame.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
- (UIViewController *)findViewController:(UIView *)sourceView;
-(NSMutableAttributedString *)labelAttributedString:(NSString *)text Rang:(NSRange)range Color:(UIColor*)color Font:(UIFont *)font;
-(UILabel *)label:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font;
-(UILabel *)labelFixedHeight:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font;
-(UILabel *)labelVertical:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font;
-(CGSize)labelSize:(CGRect)frame Text:(NSString *)txt Font:(UIFont *)font;
-(CGSize)labelHeight:(CGRect)frame Text:(NSString *)txt Font:(UIFont *)font;
-(UIView *)customViewWithFrame:(CGRect)frame;
-(UIControl *)customControlWithFrame:(CGRect)frame;
-(UIImageView *)customImageViewWithFrame:(CGRect)frame ImageName:(NSString *)iName;
-(UIButton *)customButtonWithFrame:(CGRect)frame BImageName:(NSString *)iName;
-(UITextField *)customTextFieldWithFrame:(CGRect)frame;
-(UITextView *)customTextViewWithFrame:(CGRect)frame;
- (UIImage *)imageFromColor:(UIColor *)color  InSize:(CGSize)size;
- (UIImage *)screenshot;
- (CGFloat)textHeightWithText:(NSString *)text margin:(CGFloat)margin fontSize:(CGFloat)fontSize;
- (CGFloat)textWidthWithText:(NSString *)text Height:(CGFloat)height fontSize:(CGFloat)fontSize;
@end
@interface UIViewController (Pop)
-(void)popToViewController:(NSString *)className animated:(BOOL)animated;
-(void)pushViewController:(UIViewController *)viewController From:(NSString *)className animated:(BOOL)animated;
@end