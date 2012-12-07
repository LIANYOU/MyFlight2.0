//
//  UIQuickHelp.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "UIQuickHelp.h"

@implementation UIQuickHelp

+ (void)setRoundCornerForView:(UIView*)view
                   withRadius:(CGFloat)radius{
    
    view.layer.cornerRadius = radius;
    [view setNeedsDisplay];
}


+ (void)setBorderForView:(UIView*)view
               withWidth:(CGFloat)width
               withColor:(UIColor*)color{
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
    [view setNeedsDisplay];
}

@end
