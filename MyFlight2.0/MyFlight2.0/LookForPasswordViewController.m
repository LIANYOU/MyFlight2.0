//
//  LookForPasswordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "LookForPasswordViewController.h"
#import "ResetPassWordViewController.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "UIButton+BackButton.h"
@interface LookForPasswordViewController ()
{
    
    NSTimer *thisTimer;
    BOOL isSecretBnEnabled;
    int timeValue;
    
}
@end

@implementation LookForPasswordViewController

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
    
    if (thisTimer!=nil) {
        
        [thisTimer invalidate];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNav];
    
    UISwipeGestureRecognizer *swip =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
    swip.direction =UISwipeGestureRecognizerDirectionDown|UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer: swip];
    
    [swip release];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
    [self.view addGestureRecognizer:tap];
    
    [tap release];

    
    
    self.title = @"找回密码";
    CCLog(@"找回密码时 用户上一个界面 用户输入的手机号为：%@",self.userMobile);
    isSecretBnEnabled = YES;
    timeValue = 59;
    self.userNumber.text =self.userMobile;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_VerificationCode release];
    [_disPlayName release];
    [_getSecretCodeBn release];
    [_textView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setVerificationCode:nil];
    [self setDisPlayName:nil];
    [self setGetSecretCodeBn:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark 重新获取验证码
//获取验证码 
- (IBAction)RequestCodeAgain:(id)sender {
    
    
    
    LoginBusiness *getSecretCode = [[LoginBusiness alloc] init];
    
    
    
    //如果请求短信验证码 状态可用
    
    if (isSecretBnEnabled) {
        
        
        
        if (![self.userMobile isEqualToString:@""]) {
            
            self.getSecretCodeBn.userInteractionEnabled = NO;
            
            [getSecretCode findPasswd_getSecrectCode:self.userMobile andDelegate:self];
            
            
//            这是旧的获取验证码的方式
//            [getSecretCode getSecretCode:self.userMobile requestType:GetCode_ForFindPassWd_Value andDelegate:self];
            
            
        } else{
            
            
            [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"手机号码为空，请先输入手机号码！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            
        }
        
        
        
    }
    
    
    [getSecretCode release];
    
    
    
}

- (IBAction)ResetPassword:(id)sender {
    
    
    
    NSString *pwd =[self.VerificationCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if (![pwd length]==0) {
        
        
        LoginBusiness *bis = [[LoginBusiness alloc] init];
        [bis findPasswd_VerCodeIsRight:self.userMobile code:self.VerificationCode.text andDelegate:self];
        
        [bis release];
        
    } else{
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"请输入验证码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
    }
 }




#pragma mark -
#pragma mark 返回有错误信息时的处理
//请求 返回失败时 调用的方法
- (void)requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    self.getSecretCodeBn.userInteractionEnabled =YES;
    
    isSecretBnEnabled = YES;
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    if (![thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
    
        CCLog(@"这是请求验证码返回错误处理信号");
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    }  else{
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    }
}



//#define VER_CodeISRight_RequestType_Value @"codeIsRight"  

#pragma mark -
#pragma mark 成功执行注册操作
//正确信息后调用的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
   if (![thisMessage isEqualToString:VER_CodeISRight_RequestType_Value]) {
    
        CCLog(@"这是请求验证码返回正确处理信号");
        returnMessage  = @"验证码已成功发送到您的手机";
        
        [self.getSecretCodeBn setBackgroundImage:[UIImage imageNamed:@"gray_btn.png"] forState:UIControlStateNormal];
        [self.getSecretCodeBn setTitle:[NSString stringWithFormat:@"%d秒",timeValue] forState:UIControlStateNormal];
        
        thisTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSecretBn) userInfo:nil repeats:YES];
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
   } else{
       
       if (thisTimer!=nil) {
           
           [thisTimer invalidate];
       }
       
       //重置密码界面
       ResetPassWordViewController *controller = [[ResetPassWordViewController alloc] init];

       controller.mobile = self.userMobile;
       controller.code = self.VerificationCode.text;
       [self.navigationController pushViewController:controller animated:YES];
       
       
       
   }
    
    
    
    
    
    
    
}

#pragma mark -
#pragma mark 网络返回失败时的处理
- (void) requestDidFailed:(NSDictionary *)info{
    
    
    
    
    isSecretBnEnabled = YES;
    
    self.getSecretCodeBn.userInteractionEnabled = YES;
    
//    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    
//    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
    
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
//    }     
}



#pragma mark -
#pragma mark 更新验证码的按钮的状态
//更新获取验证码 按钮的状态
- (void) updateSecretBn{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    int thisTime = [[self.getSecretCodeBn titleForState:UIControlStateNormal] intValue];
    
    thisTime--;
    
    
    [self.getSecretCodeBn setTitle:[NSString stringWithFormat:@"%d秒",thisTime] forState:UIControlStateNormal];
    
    if (thisTime==0) {
        
        [self.getSecretCodeBn setTitle:@"获取验证码" forState:UIControlStateNormal];
        isSecretBnEnabled = YES;
        self.getSecretCodeBn.userInteractionEnabled = YES;
        [self.getSecretCodeBn setBackgroundImage:[UIImage imageNamed:@"green_btn.png"] forState:UIControlStateNormal];
         [thisTimer invalidate];
        thisTimer=nil;
        
    }
    
    
       
}
     
     
     
- (IBAction)backKey:(id)sender {
    
    [self.VerificationCode resignFirstResponder];
    
    
}
@end
