//
//  ImageHandler.m
//  TFriends
//
//  Created by  on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageHandler.h"

@implementation ImageHandler

+(NSString *)imageToStr:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    return [data base64EncodedStringWithOptions:0];
}

+(UIImage *)imageFromView:(UIView *)view
{
    if([view isKindOfClass:[UIView class]])
    {
        CGRect frame=view.frame;
        UIGraphicsBeginImageContext(frame.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *im=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(im)
            return im;
    }
    return nil;
}

+(UIImage *)imageFromView:(UIView *)view andRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(im)
        return im;
    return nil;
}
+(UIImage *)imageScale:(UIImage *)image toScale:(float)scale
{
    float w=image.size.width*scale, h=image.size.height*scale;
    return [self imageToNewSize:image andTopX:0 andTopY:0 andWidth:w andHeight:h];
}

+(UIImage *)imageToNewSize:(UIImage *)image andTopX:(float)topX andTopY:(float)topY andWidth:(float)newWidth andHeight:(float)newHeight
{
    UIGraphicsBeginImageContext(CGSizeMake(newWidth,newHeight));
    [image drawInRect:CGRectMake(topX, topY, newWidth, newHeight)];
    UIImage *im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(im)
        return im;
    return nil;
}
+(BOOL)imageSaveTo:(NSString *)imageName andImage:(UIImage *)image
{
    NSData *picData=nil;NSString *extension=nil;
    picData=UIImageJPEGRepresentation(image,0.5);
    extension=@"png";
    if(!picData||picData.length<10)
    {
        picData=UIImageJPEGRepresentation(image, 0.5);
        extension=@"jpg";
    }
    if(picData)
    {
        NSURL *fileName=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        fileName=[fileName URLByAppendingPathComponent:imageName];
        fileName=[fileName URLByAppendingPathExtension:extension];
        
        return  [picData writeToURL:fileName atomically:YES];
    }
    return NO;
}

+(NSString *)imageSavedUrl:(NSString *)path withImage:(UIImage *)image anddeleteExistfile:(BOOL)del
{
    if(image){
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        
    }
    else
    {
        if(del)
        {
            NSError *er=nil;
            [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:path] error:&er];
        }
    }
    
    NSData *picData=nil;NSString *extension=nil;
    picData=UIImageJPEGRepresentation(image,0.5);
    extension=@"jpg";
    if(!picData||picData.length<10)
    {
        picData=UIImageJPEGRepresentation(image, 0.5);
        extension=@"jpg";
    }
    if(picData)
    {
        NSURL *fileName=[NSURL URLWithString:path];
        NSString *ext=fileName.pathExtension;
        if(!ext)
        {
            fileName=[fileName URLByAppendingPathExtension:extension];
        }
        [picData writeToURL:fileName atomically:YES];
        return extension;
    }
    }
    return nil;
}

+(NSURL *)imageDefaultImageSavePath
{
    NSURL *url=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    for(int i=0;i<2;i++)
    {
        url=[url URLByDeletingLastPathComponent];
    }
    url=[url URLByAppendingPathComponent:@"historyAndTemporaryForLZQ"];
    url=[url URLByAppendingPathComponent:@"tempic"];
    return url;
}

+(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIImage *i;
    //    CGSize itemSize=CGSizeMake(30, 30);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    i=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return img;
        
    }
}
@end
