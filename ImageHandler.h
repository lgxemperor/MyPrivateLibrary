//
//  ImageHandler.h
//  TFriends
//
//  Created by  on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageHandler : NSObject
+(UIImage *)imageScale:(UIImage *)image toScale:(float)scale;
+(UIImage *)imageToNewSize:(UIImage *)image andTopX:(float)topX andTopY:(float)topY andWidth:(float)newWidth andHeight:(float)newHeight;
+(UIImage *)imageFromView:(UIView *)view;
+(BOOL)imageSaveTo:(NSString *)imageName andImage:(UIImage *)image;
+(UIImage *)imageFromView:(UIView *)view andRect:(CGRect)rect;
+(NSString *)imageSavedUrl:(NSString *)path withImage:(UIImage *)image anddeleteExistfile:(BOOL)del;
+(NSString *)imageToStr:(UIImage *)image;
+(NSURL *)imageDefaultImageSavePath;
+(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
