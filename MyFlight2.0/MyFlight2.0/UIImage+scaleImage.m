//
//  UIImage+scaleImage.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "UIImage+scaleImage.h"

@implementation UIImage (scaleImage)

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    
	UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
    
}

@end
