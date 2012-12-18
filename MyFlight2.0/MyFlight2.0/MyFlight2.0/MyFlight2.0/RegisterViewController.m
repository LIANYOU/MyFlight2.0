//
//  RegisterViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "RegisterViewController.h"
#import "DNWrapper.h"
@interface RegisterViewController ()
{
    
    BOOL isShowPassword;
}
@end

@implementation RegisterViewController

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
    self.accountFiled.delegate = self;
    self.securityCodeField.delegate = self;
    self.passWordFiled.delegate = self;
    self.passWordFiled.secureTextEntry = NO;
    
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
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountFiled:nil];
    [self setPassWordFiled:nil];
    [self setSecurityCodeField:nil];
    [self setShowPassWordBn:nil];
    [super viewDidUnload];
}
- (IBAction)getSecurityCode:(id)sender {
}

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
            self.passWordFiled.secureTextEntry = YES;
        

       self.passWordFiled.text=string;
//        self.passWordFiled.secureTextEntry = NO;
//
        isShowPassword = YES;
      [self.showPassWordBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];  
        NSLog(@"显示密码");
                
    }
    
    
}




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
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
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
        NSString * urlStr = [NSString stringWithFormat:@"http://test.51you.com/web/phone/register.jsp?mobile=%@&pwd=%@&source=%@hwId=%@&serviceCode=01",phoneStr,passWordStr];  // 有几个参数还不确定
        
        NSString *newStr = [DNWrapper getMD5String:urlStr];
        
        // 下一步进行ASIHttp请求
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
