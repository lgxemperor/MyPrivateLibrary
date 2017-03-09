// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping
#import <UIKit/UIKit.h>

@interface UIImage (Resize)
///设定宽度，根据宽高比例计算Size
-(CGSize)resizeImageWith:(CGFloat)imageWidth;
///设定高度，根据宽高比例计算Size
-(CGSize)resizeImageHeight:(CGFloat)imageHeight;
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size ;
//- (UIImage *)cutCircleImage;
@end
