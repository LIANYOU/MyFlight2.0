//
//  ModifyPassWordViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface ModifyPassWordViewController : UIViewController<ServiceDelegate,UITextFieldDelegate,UIAlertViewDelegate>


@property (retain, nonatomic) IBOutlet UIView *modifyView;

//第一次输入新密码
@property (retain, nonatomic) IBOutlet UITextField *newPasswdOne;
//原密码
@property (retain, nonatomic) IBOutlet UITextField *orignPasswdTextField;

@property (retain, nonatomic) IBOutlet UIImageView *orignPasswdState;

//确认新密码
@property (retain, nonatomic) IBOutlet UITextField *newPasswdAgainTextField;



- (IBAction)backKeyBoard:(id)sender; //回收键盘 



@end
