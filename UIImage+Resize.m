// UIImage+Resize.m
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "UIImage+Resize.h"


// Private helper methods
@interface UIImage (ResizePrivateMethods)

@end

@implementation UIImage (Resize)
#pragma mark -
#pragma mark 图片宽高
-(CGSize)resizeImageWith:(CGFloat)imageWidth{
    CGFloat imageHeight=imageWidth*self.size.height/self.size.width;
    return CGSizeMake(imageWidth, imageHeight);
}
-(CGSize)resizeImageHeight:(CGFloat)imageHeight{
    CGFloat imageWidth=imageHeight*self.size.width/self.size.height;
    return CGSizeMake(imageWidth, imageHeight);
}
// 缩放图片到比例
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    
    // 创建context
    UIGraphicsBeginImageContext(size);
    // 改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
/** 设置圆形图片(放到分类中使用) */
//- (UIImage *)cutCircleImage {
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
//    // 获取上下文
//    CGContextRef ctr = UIGraphicsGetCurrentContext();
//    // 设置圆形
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextAddEllipseInRect(ctr, rect);
//    // 裁剪
//    CGContextClip(ctr);
//    // 将图片画上去
//    [self drawInRect:rect];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
@end
