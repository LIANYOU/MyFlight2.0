//
//  LookForPasswordViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForPasswordViewController : UIViewController

//用户手机上的验证码
@property (retain, nonatomic) IBOutlet UITextField *VerificationCode;

//显示倒计时 
@property (retain, nonatomic) IBOutlet UILabel *disPlayName;

//重新发送 
- (IBAction)RequestCodeAgain:(id)sender;


//重置密码 
- (IBAction)ResetPassword:(id)sender;


@end
