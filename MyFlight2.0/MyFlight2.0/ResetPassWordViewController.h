//
//  ResetPassWordViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPassWordViewController : UIViewController

//用户输入的新密码
@property (retain, nonatomic) IBOutlet UITextField *newPassword;

//是否显示 密码 
- (IBAction)showPasswordState:(id)sender;


//发送重置密码 请求 
- (IBAction)commitResetPasswordRequest:(id)sender;


@end
