//
//  UIView+Frame.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
#pragma mark - Shortcuts for the coords

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
#pragma mark - 寻找当前的Controller
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}
-(NSMutableAttributedString *)labelAttributedString:(NSString *)text Rang:(NSRange)range Color:(UIColor*)color Font:(UIFont *)font{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    return str;
}
-(UILabel *)label:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font{
    UILabel *label=[[UILabel alloc] init];
    label.frame=frame;
    CGSize rmSize = CGSizeMake(MAXFLOAT,CGRectGetHeight(frame)-6);  //上限
    CGSize rSize = [txt boundingRectWithSize:rmSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    label.width=rSize.width+4;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=textColor;
    label.font=font;
    label.text=txt;
    [self addSubview:label];
    return label;
}
-(UILabel *)labelFixedHeight:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font{
    UILabel *label=[[UILabel alloc] init];
    label.frame=frame;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.numberOfLines=0;
    label.textColor=textColor;
    label.font=font;
    label.text=txt;
    [self addSubview:label];
    return label;
}
-(UILabel *)labelVertical:(CGRect)frame Text:(NSString *)txt TextColor:(UIColor *)textColor Font:(UIFont *)font{
    UILabel *label=[[UILabel alloc] init];
    label.frame=frame;
    CGSize rmSize = CGSizeMake(CGRectGetWidth(frame)-6,MAXFLOAT);  //上限
    CGSize rSize = [txt boundingRectWithSize:rmSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    if (CGRectGetHeight(frame)<rSize.height) {
        label.height=rSize.height;
    }
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.numberOfLines=0;
    label.textColor=textColor;
    label.font=font;
    label.text=txt;
    [self addSubview:label];
    return label;
}
-(CGSize)labelSize:(CGRect)frame Text:(NSString *)txt Font:(UIFont *)font{
    CGSize rmSize = CGSizeMake(MAXFLOAT,CGRectGetHeight(frame)-6);  //上限
    CGSize rSize = frame.size;
    rSize =[txt boundingRectWithSize:rmSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    return rSize;
}
-(CGSize)labelHeight:(CGRect)frame Text:(NSString *)txt Font:(UIFont *)font{
    CGSize rmSize = CGSizeMake(CGRectGetWidth(frame)-6,MAXFLOAT);  //上限
    CGSize rSize = frame.size;
    rSize =[txt boundingRectWithSize:rmSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    return rSize;
}
-(UIView *)customViewWithFrame:(CGRect)frame{
    UIView *clView=[[UIView alloc] initWithFrame:frame];
    clView.backgroundColor=[UIColor clearColor];
    [self addSubview:clView];
    return clView;
}
-(UIControl *)customControlWithFrame:(CGRect)frame{
    UIControl *clView=[[UIControl alloc] initWithFrame:frame];
    clView.backgroundColor=[UIColor clearColor];
    [self addSubview:clView];
    return clView;
}
-(UIImageView *)customImageViewWithFrame:(CGRect)frame ImageName:(NSString *)iName{
    UIImageView *clView=[[UIImageView alloc] initWithFrame:frame];
    clView.backgroundColor=[UIColor clearColor];
    clView.image=[UIImage imageNamed:iName];
    [self addSubview:clView];
    return clView;
}
-(UIButton *)customButtonWithFrame:(CGRect)frame BImageName:(NSString *)iName{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setBackgroundImage:[UIImage imageNamed:iName] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    [button.titleLabel setNumberOfLines:0];
    [self addSubview:button];
    return button;
}
-(UITextField *)customTextFieldWithFrame:(CGRect)frame{
    UITextField *textField=[[UITextField alloc] initWithFrame:frame];
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField.backgroundColor=[UIColor clearColor];
    [self addSubview:textField];
    return textField;
}
-(UITextView *)customTextViewWithFrame:(CGRect)frame{
    UITextView *textView=[[UITextView alloc] initWithFrame:frame];
    textView.textAlignment=NSTextAlignmentLeft;
    textView.backgroundColor=[UIColor clearColor];
    [self addSubview:textView];
    return textView;
}
- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    // IOS7及其后续版本
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:
                                     @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invocation setTarget:self];
        [invocation setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invocation setArgument:&arg2 atIndex:2];
        [invocation setArgument:&arg3 atIndex:3];
        [invocation invoke];
    } else { // IOS7之前的版本
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}
- (UIImage *)imageFromColor:(UIColor *)color  InSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}
- (CGFloat)textHeightWithText:(NSString *)text margin:(CGFloat)margin fontSize:(CGFloat)fontSize {
    
    if ([text isEqualToString:@""]) {
        text = @"       ";
    }
    CGSize constrainSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - margin-10, MAXFLOAT);
    // 文本绘制规则
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 文本属性
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect bounds = [text boundingRectWithSize:constrainSize
                                       options:options
                                    attributes:attributes
                                       context:NULL];
    return bounds.size.height+2;
}
- (CGFloat)textWidthWithText:(NSString *)text Height:(CGFloat)height fontSize:(CGFloat)fontSize {
    if ([text isEqualToString:@""]) {
        text = @"       ";
    }
    CGSize constrainSize = CGSizeMake(MAXFLOAT,height);
    // 文本绘制规则
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 文本属性
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect bounds = [text boundingRectWithSize:constrainSize
                                       options:options
                                    attributes:attributes
                                       context:NULL];
    return bounds.size.width+4;
}
@end
@implementation UIViewController (Pop)

#pragma mark
#pragma mark - Pop
-(void)popToViewController:(NSString *)className animated:(BOOL)animated{
    NSMutableArray *vcs=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    int idx=0;
    for (NSInteger i=0; i<vcs.count; i++) {
        UIViewController *vc = [vcs objectAtIndex:i];
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            idx=i;
            break;
        }
    }
    for (NSInteger i=vcs.count-1; i>idx; i--) {
        [vcs removeObjectAtIndex:i];
    }
    [self.navigationController setViewControllers:vcs animated:animated];
}
-(void)pushViewController:(UIViewController *)viewController From:(NSString *)className animated:(BOOL)animated{
    NSMutableArray *vcs=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    int idx=0;
    for (NSInteger i=0; i<vcs.count; i++) {
        UIViewController *vc = [vcs objectAtIndex:i];
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            idx=i;
            break;
        }
    }
    for (NSInteger i=vcs.count-1; i>idx; i--) {
        [vcs removeObjectAtIndex:i];
    }
    [vcs addObject:viewController];
    [self.navigationController setViewControllers:vcs animated:animated];
}

@end
