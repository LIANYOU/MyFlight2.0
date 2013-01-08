//
//  LookForPasswordFirstStepViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "LookForPasswordFirstStepViewController.h"

#import "LookForPasswordViewController.h"

#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "UIButton+BackButton.h"
@interface LookForPasswordFirstStepViewController ()

@end

@implementation LookForPasswordFirstStepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setNav{
    
    UIButton * backBtn = [UIButton  backButtonType:0 andTitle:@""];
    
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
}


- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNav];
    self.title  =@"找回密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_UserInputPhoneNumber release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserInputPhoneNumber:nil];
    [super viewDidUnload];
}
- (IBAction)goToNextStep:(id)sender {
    
    LoginBusiness *bis = [[LoginBusiness alloc] init];
    if (![self.UserInputPhoneNumber.text isEqualToString:@""]) {
       
        
        
    [bis findPasswd_getSecrectCode:self.UserInputPhoneNumber.text andDelegate:self];
        
        
//        此验证码请求方式 废弃不用
//
//        [bis getSecretCode:self.UserInputPhoneNumber.text requestType:GetCode_ForFindPassWd_Value andDelegate:self];
   
        
    } else{
        
        
    [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"手机号码为空，请先输入手机号码！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
    }

    [bis release];
    
    
       
}
- (IBAction)backKeyBoard:(id)sender {
    
    [sender resignFirstResponder];
}



#pragma mark -
#pragma mark 返回有错误信息时的处理
//请求 返回失败时 调用的方法
- (void)requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
            
        CCLog(@"这是请求验证码返回错误处理信号");
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    
}

#pragma mark -
#pragma mark 成功执行注册操作
//正确信息后调用的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
//    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
    
        CCLog(@"这是请求验证码返回正确处理信号");
        returnMessage  = @"验证码已成功发送到您的手机";
        
        
        
        LookForPasswordViewController *controller = [[LookForPasswordViewController alloc] init];
        
        // 属性传值
        controller.userMobile = self.UserInputPhoneNumber.text;
        
        
        [self.navigationController pushViewController:controller animated:YES];
        
        
        //        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        //
        
//    }
}

#pragma mark -
#pragma mark 网络返回失败时的处理
- (void) requestDidFailed:(NSDictionary *)info{
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
//    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
//    }
}




@end
