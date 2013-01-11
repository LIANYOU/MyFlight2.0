//
//  UIButton+BackButton.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-31.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "UIButton+BackButton.h"

@implementation UIButton (BackButton)

+(UIButton *)backButtonType:(int)btnType andTitle:(NSString *)title
{
    NSString * normalImage = nil;
    NSString * clickIamge = nil;
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    switch (btnType) {
        case 0:
            backBtn.frame = CGRectMake(0, 0, 30, 30);
            normalImage = @"icon_return.png";
            clickIamge = @"icon_return_click.png";
            break;
        case 2:
            backBtn.frame = CGRectMake(0, 0, 60, 30);
            normalImage = @"btn_2words.png";
            clickIamge = @"btn_2words_click.png";
            break;
        case 4:
            backBtn.frame = CGRectMake(0, 0, 80, 30);
            normalImage = @"btn_4words.png";
            clickIamge = @"btn_4words_click.png";
            break;
        case 5:
            backBtn.frame = CGRectMake(0, 0, 90, 30);
            normalImage = @"btn_5words.png";
            clickIamge = @"btn_5words_click.png";
            
            break;
            //增加按钮
        case 6:
            backBtn.frame = CGRectMake(0, 0, 30, 30);
            normalImage = @"icon_add.png";
            clickIamge = @"icon_add_click.png";
            break;
        case 7:
            backBtn.frame = CGRectMake(0, 0, 60, 30);
            normalImage = @"btn_save_new.png";
            clickIamge = @"btn_save_click_new.png";
            break;
        case 8:
            backBtn.frame = CGRectMake(0, 0, 60, 30);
            normalImage = @"btn_save.png";
            clickIamge = @"btn_save_click.png";
            
            break;
            
        default:
            break;
    }
    
    
    [backBtn setBackgroundImage:[UIImage imageNamed:normalImage] forState:0];
    [backBtn setBackgroundImage:[UIImage imageNamed:clickIamge] forState:UIControlStateHighlighted];
    
    [backBtn setTitle:title forState:0];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    return backBtn;
    
}


@end
