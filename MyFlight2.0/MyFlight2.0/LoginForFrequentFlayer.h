//
//  LoginForFrequentFlayer.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface LoginForFrequentFlayer : UIViewController<ServiceDelegate>

@property (retain, nonatomic) IBOutlet UITextField *accountLabel;

//密码
@property (retain, nonatomic) IBOutlet UITextField *passwdLabel;

//回收键盘 
- (IBAction)backKeyBoard:(id)sender;

//记住密码 
- (IBAction)rememberPwdBn:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *rememberPwdStateBn;

//登录操作
- (IBAction)goToMyviewpage:(id)sender;


@end
