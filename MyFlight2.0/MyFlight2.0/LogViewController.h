//
//  LogViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"

//登陆界面  
@interface LogViewController : UIViewController<ServiceDelegate>
{
    IBOutlet UITextField *logPassword;   // 登陆密码
    IBOutlet UITextField *logNumber;     // 登陆账号
    
    IBOutlet UIScrollView *ScrollerView;
    
}



- (IBAction)beginLoging:(id)sender;      // 登陆



- (IBAction)registerNewNumber:(id)sender;// 注册

- (IBAction)backKeyBoard:(id)sender; //回收键盘 

//记住密码按钮
- (IBAction)rememberPassword:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *remembePasswordBn;


//找回密码 
- (IBAction)LookForPassword:(id)sender;

//用QQ账户登陆
- (IBAction)LoginWithQQ:(id)sender;

//用腾讯微博登陆
- (IBAction)LoginWithTencentWeiBo:(id)sender;

//用微信登陆
- (IBAction)LoginWithWeiXin:(id)sender;

//用新浪微博登陆
- (IBAction)LoginWithSinaWeiBo:(id)sender;

@end
