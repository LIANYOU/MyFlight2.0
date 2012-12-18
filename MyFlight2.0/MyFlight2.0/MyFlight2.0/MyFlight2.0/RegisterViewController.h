//
//  RegisterViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>


//注册界面
@interface RegisterViewController : UIViewController<UITextFieldDelegate>
//账号输入框 
@property (retain, nonatomic) IBOutlet UITextField *accountFiled;

//验证码输入框
@property (retain, nonatomic) IBOutlet UITextField *securityCodeField;

//密码输入框
@property (retain, nonatomic) IBOutlet UITextField *passWordFiled;
//获取验证码
- (IBAction)getSecurityCode:(id)sender;


//显示密码 
- (IBAction)showPassWord:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *showPassWordBn;




//注册用户
- (IBAction)registerAccount:(id)sender;
- (IBAction)backToLogView:(id)sender;


@end
