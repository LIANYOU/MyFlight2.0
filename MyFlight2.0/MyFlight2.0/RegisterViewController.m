//
//  RegisterViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "RegisterViewController.h"
#import "DNWrapper.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "AppConfigure.h"
#import "UIButton+BackButton.h"
@interface RegisterViewController ()
{
    
    BOOL isShowPassword;
    NSTimer *thisTimer;
    BOOL isSecretBnEnabled;
    int timeValue;
}
@end

@implementation RegisterViewController





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
    
    
  [self setNav];
    
    
    
    
    [UIQuickHelp setRoundCornerForView:self.thisView withRadius:8];
    
    
    
    
    [UIQuickHelp setRoundCornerForView:self.thisView withRadius:8];
    [UIQuickHelp setBorderForView:self.thisView withWidth:1 withColor:[UIColor colorWithRed:206/255.0 green:197/255.0 blue:184/255.0 alpha:1]];
    
    [self.thisView.layer setShadowColor:[UIColor colorWithRed:206/255.0 green:197/255.0 blue:184/255.0 alpha:1].CGColor];
    [self.thisView.layer setShadowRadius:2];
    [self.thisView.layer setShadowOffset:CGSizeMake(1, 3)];
    
    
    
    self.accountFiled.delegate = self;
    self.securityCodeField.delegate = self;
    self.passWordFiled.delegate = self;
    self.passWordFiled.secureTextEntry = YES;
    //默认获取验证码按钮可以使用
    isSecretBnEnabled = YES;
    timeValue = 59;
    
    [self.secretCodeBn setBackgroundImage:[UIImage imageNamed:@"green_btn.png"] forState:UIControlStateNormal];
    
    
    self.title  =@"注册";
    self.accountFiled.keyboardType = UIKeyboardTypeNamePhonePad;  // 设置键盘样式
    self.passWordFiled.keyboardType = UIKeyboardTypeDefault;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_accountFiled release];
    [_passWordFiled release];
    [_securityCodeField release];
    [_showPassWordBn release];
    [_secretCodeBn release];
    [_thisView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountFiled:nil];
    [self setPassWordFiled:nil];
    [self setSecurityCodeField:nil];
    [self setShowPassWordBn:nil];
    [self setSecretCodeBn:nil];
    [self setThisView:nil];
    [super viewDidUnload];
}





#pragma mark -
#pragma mark 返回有错误信息时的处理
//请求 返回失败时 调用的方法
- (void)requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    self.secretCodeBn.userInteractionEnabled =YES;
    isSecretBnEnabled = YES;
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
        
        CCLog(@"这是请求验证码返回错误处理信号");
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    } else  if([thisMessage isEqualToString:Regist_RequestType_Value]){
        
        CCLog(@"这是注册请求返回的错误信号");
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    }
    
    
    
    
    
}

#pragma mark -
#pragma mark 成功执行注册操作
//正确信息后调用的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
        
        CCLog(@"这是请求验证码返回正确处理信号");
        returnMessage  = @"验证码已成功发送到您的手机";
        
        [self.secretCodeBn setBackgroundImage:[UIImage imageNamed:@"gray_btn.png"] forState:UIControlStateNormal];
        [self.secretCodeBn setTitle:[NSString stringWithFormat:@"%d秒",timeValue] forState:UIControlStateNormal];
        
        thisTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSecretBn) userInfo:nil repeats:YES];
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    } else if([thisMessage isEqualToString:Regist_RequestType_Value]){
        
        
        CCLog(@"这是注册请求返回正确信号");
        //这是注册请求返回时  需要做的处理
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"您已经注册成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark -
#pragma mark 网络返回失败时的处理
- (void) requestDidFailed:(NSDictionary *)info{
    
    
    
    
    isSecretBnEnabled = YES;
    
    self.secretCodeBn.userInteractionEnabled = YES;
    
    NSString *thisMessage = [info objectForKey:KEY_Request_Type];
    NSString *returnMessage = [info objectForKey:KEY_message];
    
    
    
    if ([thisMessage isEqualToString:GET_SecretCode_RequestType_Value]) {
        
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    } else if([thisMessage isEqualToString:Regist_RequestType_Value]){
        
        
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:returnMessage   delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        
    }
    
  
    
}


#pragma mark -
#pragma mark 更新验证码的按钮的状态
//更新获取验证码 按钮的状态
- (void) updateSecretBn{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    int thisTime = [[self.secretCodeBn titleForState:UIControlStateNormal] intValue];
    
    thisTime--;
    
    
    [self.secretCodeBn setTitle:[NSString stringWithFormat:@"%d秒",thisTime] forState:UIControlStateNormal];
    
    if (thisTime==0) {
        [self.secretCodeBn setTitle:@"获取验证码" forState:UIControlStateNormal];
        isSecretBnEnabled = YES;
        self.secretCodeBn.userInteractionEnabled = YES;
        [self.secretCodeBn setBackgroundImage:[UIImage imageNamed:@"green_btn.png"] forState:UIControlStateNormal];
        
        
        
        [thisTimer invalidate];
        
    }
    
    
    //    file://localhost/Users/LIANYOU/MyFlight2.0/MyFlight2.0/MyFlight2.0/%E7%99%BB%E5%BD%95/gray_btn.png
    //
    //
    //    file://localhost/Users/LIANYOU/MyFlight2.0/MyFlight2.0/MyFlight2.0/%E7%99%BB%E5%BD%95/green_btn.png
    
    
}

#pragma mark -
#pragma mark 获取验证码

//获取验证码
- (IBAction)getSecurityCode:(id)sender {
    
    
    LoginBusiness *getSecretCode = [[LoginBusiness alloc] init];
    
    
    
    //如果请求短信验证码 状态可用
    
    if (isSecretBnEnabled) {
        
        if (![self.accountFiled.text isEqualToString:@""]) {
            
            self.secretCodeBn.userInteractionEnabled = NO;
            
            [getSecretCode getSecretCode:self.accountFiled.text requestType:GETCode_ForRegist_Value andDelegate:self];
          
            
            
        } else{
            
            
            [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"手机号码为空，请先输入手机号码！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            
        }
    }
    
    
    [getSecretCode release];
    
    
}



#pragma mark -
#pragma mark 显示密码
//显示密码
- (IBAction)showPassWord:(id)sender {
    
    NSString *string = self.passWordFiled.text;
    
    if ([[self.showPassWordBn currentBackgroundImage] isEqual:[UIImage imageNamed:@"icon_choice.png"]]) {
        
        
        
        self.passWordFiled.text=@"";
        self.passWordFiled.secureTextEntry = YES;
        
        self.passWordFiled.text=string;
        
        
        
        NSLog(@"不显示密码");
        [self.showPassWordBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        isShowPassword = NO;
        
        
    } else{
        
        
        self.passWordFiled.text=@"";
        self.passWordFiled.secureTextEntry = NO;
        
        
        self.passWordFiled.text=string;
        //        self.passWordFiled.secureTextEntry = NO;
        //
        isShowPassword = YES;
        [self.showPassWordBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        NSLog(@"显示密码");
        
    }
    
    
}




#pragma mark -
#pragma mark 注册账号

//注册用户
- (IBAction)registerAccount:(id)sender {
    
    NSString * phoneStr = [self.accountFiled text];
    NSString * passWordStr = [self.passWordFiled text];
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ((([regextestmobile evaluateWithObject:phoneStr] == YES)
         || ([regextestcm evaluateWithObject:phoneStr] == YES)
         || ([regextestct evaluateWithObject:phoneStr] == YES)
         || ([regextestcu evaluateWithObject:phoneStr] == YES))
        && (passWordStr.length>4&&passWordStr.length<20))
    {
        //        NSString * urlStr = [NSString stringWithFormat:@"http://test.51you.com/web/phone/register.jsp?mobile=%@&pwd=%@&source=%@hwId=%@&serviceCode=01",phoneStr,passWordStr];  // 有几个参数还不确定
        //
        //        NSString *newStr = [DNWrapper getMD5String:urlStr];
        //
        // 下一步进行ASIHttp请求
        
        
        LoginBusiness *busi = [[LoginBusiness alloc] init];
        
        [busi registerWithAccount:self.accountFiled.text password:self.passWordFiled.text yaCode: self.securityCodeField.text andDelegate:self];
        [busi release];
        
        
        
        
    }
    else
    {
        UIAlertView *mailAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号或者邮箱不正确" delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
        [mailAlert show];
        [mailAlert release];
    }
    
    
    
}

- (IBAction)backToLogView:(id)sender {
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.frame.size.height/2;
    if (textField.center.y>180) {
        ce.y-=(textField.center.y-180);
    }
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGPoint ce=self.view.center;
    ce.y=self.view.frame.size.height/2;
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    self.view.center=ce;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES ;
}
@end
