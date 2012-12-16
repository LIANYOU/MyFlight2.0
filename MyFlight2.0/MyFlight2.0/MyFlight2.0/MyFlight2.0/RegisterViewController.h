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
@property (retain, nonatomic) IBOutlet UITextField *accountFiled;
@property (retain, nonatomic) IBOutlet UITextField *securityCodeField;
@property (retain, nonatomic) IBOutlet UITextField *passWordFiled;
- (IBAction)getSecurityCode:(id)sender;
- (IBAction)showPassWord:(id)sender;
- (IBAction)registerAccount:(id)sender;
- (IBAction)backToLogView:(id)sender;


@end
