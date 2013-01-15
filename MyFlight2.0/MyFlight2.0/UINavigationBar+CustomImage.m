//
//  UINavigationBar+CustomImage.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-15.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//


#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)
UIImageView *backgroundView;



-(void)setBackgroundImage:(UIImage*)image

{
    
    if(image == nil)
        
    {
        
        [backgroundView removeFromSuperview];
        
    }
    
    else
        
    {
        
        backgroundView = [[UIImageView alloc] initWithImage:image];
        
        backgroundView.tag = 1;
        
        backgroundView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
        
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:backgroundView];
        
        [self sendSubviewToBack:backgroundView];
        
        [backgroundView release];
        
    }
    
}



//for other views

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index

{
    
    [super insertSubview:view atIndex:index];
    
    [self sendSubviewToBack:backgroundView];   
    
}   

@end