//
//  ResetPassWordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ResetPassWordViewController.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "LogViewController.h"
#import "ViewController.h"
#import "UIButton+BackButton.h"
#import "MBProgressHUD.h"
#import "IsLoginInSingle.h"
#import "LogViewController.h"

@interface ResetPassWordViewController ()
{
    
    
    BOOL isResetPwdSuccess;
    
    BOOL isShowPassword;
}
@end

@implementation ResetPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



- (void) setNav{
    
    
    

    [UIQuickHelp setRoundCornerForView:self.textView withRadius:View_CoureRadious];
    
    [UIQuickHelp setRoundCornerForView:self.textView withRadius:View_CoureRadious];
    
    [UIQuickHelp setBorderForView:self.textView withWidth:1 withColor:View_BorderColor];
    
    [self.textView.layer setShadowColor:View_ShadowColor;
     
     [self.textView.layer setShadowRadius:2];
     [self.textView.layer setShadowOffset:CGSizeMake(1, 3)];

    
    
    
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
    
//    UISwipeGestureRecognizer *swip =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
//    swip.direction =UISwipeGestureRecognizerDirectionDown|UISwipeGestureRecognizerDirectionUp;
//    
//    [self.view addGestureRecognizer: swip];
//    
//    [swip release];
//    
//    
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
//    [self.view addGestureRecognizer:tap];
//    
//    [tap release];
//
    
    
    [self setNav];
    self.title = @"重置密码";
    [self.newPassword becomeFirstResponder];
    self.newPassword.secureTextEntry = NO;
    
    isResetPwdSuccess = NO;
    CCLog(@"重置密码页面 用户手机号 %@ 验证码 %@",self.mobile,self.code);
    
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_newPassword release];
    [_textView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNewPassword:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}


//显示密码
- (IBAction)showPasswordState:(id)sender {
    
    
    
    NSString *string = self.newPassword.text;
    
    if ([[self.showStateBn currentBackgroundImage] isEqual:[UIImage imageNamed:@"icon_choice.png"]]) {
        
        [self.newPassword resignFirstResponder];
        
        self.newPassword.text=@"";
        self.newPassword.secureTextEntry = YES;
        
        self.newPassword.text=string;
        
        
        
        NSLog(@"不显示密码");
        [self.showStateBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        isShowPassword = NO;
        
        
    } else{
        
        [self.newPassword resignFirstResponder];
        
        self.newPassword.text=@"";
        self.newPassword.secureTextEntry = NO;
        
        
        self.newPassword.text=string;
        
        isShowPassword = YES;
        
        [self.showStateBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        NSLog(@"显示密码");
        
    }

    
    
    
    
    
    
    
    
}


//发送重置密码 请求 
- (IBAction)commitResetPasswordRequest:(id)sender {
    
    
    [self.newPassword resignFirstResponder];
    
    NSString *pwd = [self.newPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([pwd length]==0) {
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [self.newPassword becomeFirstResponder];
    } else{
        LoginBusiness *bis = [[LoginBusiness alloc] init];
        
        
        [bis findPassWd_ResetPassWdWithNewPwd:self.newPassword.text mobile:self.mobile code:self.code andDelegate:self];
        [bis release];
     }
    
         
}





#pragma mark -
#pragma mark 返回有错误信息时的处理
//请求 返回失败时 调用的方法
- (void)requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
       
//    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    //判断是哪一个业务返回的网络请求
    
            CCLog(@"这是请求重置密码返回错误处理信号");
        
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        

}



#pragma mark -
#pragma mark 成功执行注册操作
//正确信息后调用的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
//    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
//    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    IsLoginInSingle *single =[IsLoginInSingle shareLoginSingle];
    
    [single updateUserDefault];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_Password];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    BOOL flag = single.isLogin;
    BOOL flag1 =Default_IsUserLogin_Value;
    
    
    CCLog(@"初始密码成功,用户是否登录%d %d",flag,flag1);
    
    NSString *returnMessage = @"恭喜您，重置密码成功";
    
    isResetPwdSuccess = YES;

    [UIQuickHelp showAlertViewWithTitle:nil message:returnMessage   delegate:self cancelButtonTitle:@"回首页" otherButtonTitles:@"登录"];
        

    
}

#pragma mark -
#pragma mark 警告视图代理方法

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    
    if (isResetPwdSuccess) {
        
        switch (buttonIndex) {
            case 0:
            //回首页
                
                
               
                
            break;
            case 1:{
                //回到登录界面
                
                LogViewController *con =[[LogViewController alloc] init];
                
                con.loginSuccessReturnType =Login_Success_ReturnMyCenterDefault_Type;
                
                UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:con];
                
                [con release];
                [self presentModalViewController:nav animated:YES];
                break;
                
                
            }
                               
            default:
                break;
        }
        
        
        
    }
    
    
    
    
    
}


#pragma mark -
#pragma mark 网络返回失败时的处理
- (void) requestDidFailed:(NSDictionary *)info{
    
    
  //    isSecretBnEnabled = YES;
//    
//    self.getSecretCodeBn.userInteractionEnabled = YES;
//    
//    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    
        NSString *returnMessage = [info objectForKey:KEY_message];
              
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    
}


     
- (IBAction)backKey:(id)sender {
    
    CCLog(@"%@",sender);
    
    [self.newPassword resignFirstResponder];
    
    
     }

     
     
     
     
     - (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
         CCLog(@"*********&&&&&&&&");
         
         [self.newPassword resignFirstResponder];
     }
     
     
     - (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
         
         
         CCLog(@"$$$$$$$$$$$$$$$$$$");
         
         
        [self.newPassword resignFirstResponder];
         
     }
     

@end
