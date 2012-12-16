//
//  LogViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController
{
    IBOutlet UITextField *logPassword;   // 登陆密码
    IBOutlet UITextField *logNumber;     // 登陆账号
}
- (IBAction)beginLoging:(id)sender;      // 登陆
- (IBAction)registerNewNumber:(id)sender;// 注册
@property (retain, nonatomic) IBOutlet UIButton *forgetPassword;  // 找回密码

@end
