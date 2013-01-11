//
//  ResetPassWordViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface ResetPassWordViewController : UIViewController<ServiceDelegate,UIAlertViewDelegate>



- (IBAction)backKey:(id)sender;







//用户输入的新密码
@property (retain, nonatomic) IBOutlet UITextField *newPassword;

//是否显示 密码 
- (IBAction)showPasswordState:(id)sender;


//发送重置密码 请求 
- (IBAction)commitResetPasswordRequest:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *textView;


@property(nonatomic,retain)NSString *mobile; //用户输入的手机
@property(nonatomic,retain)NSString *code; //用户输入的验证码
@end
