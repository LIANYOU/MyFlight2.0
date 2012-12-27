//
//  LogViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "LogViewController.h"
#import "RegisterViewController.h"
#import "LookForPasswordFirstStepViewController.h"
#import "UIQuickHelp.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "IsLoginInSingle.h"
#import "UserAccount.h"

#import "MyNewCenterViewController.h"
@interface LogViewController ()
{
    
    BOOL isRemember;
    IsLoginInSingle *loginSingle;
    LoginBusiness *loginBusiness;
    
    
}
@end

@implementation LogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    //默认设置先回到我的个人中心
//    self.loginSuccessReturnType = Login_Success_ReturnMyCenterDefault_Type;
    
    
    loginBusiness = [[LoginBusiness alloc] init];
    

    
    
    
    loginSingle =[IsLoginInSingle shareLoginSingle];
    
    //默认记住密码
//    isRemember = true;
    
    isRemember =[[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsRememberPwd];
    
    NSLog(@"是否记住密码：%d",isRemember);
    
    if (isRemember) {
        
       
        [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
    } else{
        
        [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        

    }
    
    
    logNumber.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_AccountName];
    
    logPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_Password];
    
    ScrollerView.contentSize = CGSizeMake(320, 600);
    self.title = @"账户登录";
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [logNumber release];
    [logPassword release];
    [loginBusiness release];
    [ScrollerView release];
    [_remembePasswordBn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [logNumber release];
    logNumber = nil;
    [logPassword release];
    logPassword = nil;
    
    [ScrollerView release];
    ScrollerView = nil;
    [self setRemembePasswordBn:nil];
    [super viewDidUnload];
}


- (void) requestDidFailed:(NSDictionary *)info{
    
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"提醒" message: meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}


#pragma mark -
#pragma mark 请求有错误信息 

- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    NSString *meg =[[info objectForKey:KEY_message] retain];
    
    [UIQuickHelp showAlertViewWithTitle:@"提醒" message: meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [meg release];
    
}



#pragma mark -
#pragma mark 登录成功时的操作 
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
//    用户输入什么就会记录 用户账户的默认值 
    
    [[NSUserDefaults standardUserDefaults] setObject:logNumber.text forKey:KEY_Default_AccountName];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    if (isRemember) {
        
        [[NSUserDefaults standardUserDefaults] setObject:logPassword.text forKey:KEY_Default_Password];
        [[NSUserDefaults standardUserDefaults] synchronize];
 
                
    } else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_Password];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    [UIQuickHelp showAlertViewWithTitle:@"登陆成功" message:@"即将跳转" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_Token];
    NSString *memberID = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_MemberId];
    
    
    NSString *idUser = loginSingle.userAccount.memberId;
    
    NSLog(@"登录成功后用户id为：%@",memberID);
    NSLog(@"用户id =%@",idUser);
    NSLog(@"token = %@",token);
    sleep(1);
    
    
    
    if ([self.loginSuccessReturnType isEqualToString:Login_Success_ReturnMyCenterDefault_Type]) {
        
         MyNewCenterViewController *center = [[MyNewCenterViewController alloc] init];
        
        UINavigationController *con  =[[UINavigationController alloc] initWithRootViewController:center];
        
        [center release];
       
        
//        [loginBusiness getAccountInfoWithMemberId:memberID andDelegate:center];
        
        
        [self presentViewController:con animated:YES completion:^{
            
            
            [center updateThisViewWhenSuccess];
            
        }];
          
    } else{
        
        
         [self.navigationController popViewControllerAnimated:YES];
    }
        
    
}
//登陆
#pragma mark -
#pragma mark 登录操作
- (IBAction)beginLoging:(id)sender {
    
    //
    //    if ([logNumber.text isEqualToString:@""]) {
    //
    //
    //        [UIQuickHelp showAlertViewWithTitle:nil message:@"账号不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    //        [logNumber becomeFirstResponder];
    //
    //    }
    //
    //if ([logPassword.text isEqualToString:@""]) {
    //
    //
    //    [UIQuickHelp showAlertViewWithTitle:nil message:@"账号不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    //    [logPassword becomeFirstResponder];
    //
    //
    //}
    
    
    
    
    
    [loginBusiness loginWithName:logNumber.text password:logPassword.text andDelegate:self];
    
 
    
    
    
}

//注册账号
- (IBAction)registerNewNumber:(id)sender {
    RegisterViewController * view = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
- (IBAction)backKeyBoard:(UITextField *)sender {
    
    
    NSLog(@"回收键盘");
    [sender resignFirstResponder];
}

//找回密码
- (IBAction)LookForPassword:(id)sender {
    
    
    LookForPasswordFirstStepViewController *controller =[[LookForPasswordFirstStepViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)LoginWithQQ:(id)sender {
    
    
}

- (IBAction)LoginWithTencentWeiBo:(id)sender {
}

- (IBAction)LoginWithWeiXin:(id)sender {
}

- (IBAction)LoginWithSinaWeiBo:(id)sender {
}

//记住密码按钮

#pragma mark -
#pragma mark 是否记住密码
- (IBAction)rememberPassword:(id)sender {
    
    if (isRemember) {
        //不记住密码
        
        
        
        isRemember = false;
        
        
        
        [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:KEY_Default_IsRememberPwd];
        
        
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_Password];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSLog(@"*******不记住 %d",[[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsRememberPwd]);
        [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        
        
        
    } else{
        
        isRemember = true;
        //记住密码
        [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:KEY_Default_IsRememberPwd];
         [ [NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"******* 记住%d",[[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsRememberPwd]);
        
//        [[NSUserDefaults standardUserDefaults] setObject:logPassword.text forKey:KEY_Default_Password];
       
        
        [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    
}
@end
