//
//  LoginForFrequentFlayer.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "LoginForFrequentFlayer.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
#import "SPHFrequentMainViewController.h"
#import "FrequentFlyNetWorkHelper.h"
#import "isFrequentPassengerLogin.h"
#import "FrequentPassengerData.h"
#import "AirCompanyDataBase.h"

@interface LoginForFrequentFlayer (){
    
    BOOL isRemember;
}

@end

@implementation LoginForFrequentFlayer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) initThisView{
    
    
    
    isRemember = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_FrequentFly_isRememberPwd];
    
    
    
    if (isRemember) {
        
        [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        
        self.passwdLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FrequentFly_User_pwd];
        
     } else{
        
        [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
    }
    
      self.accountLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FrequentFly_User_Account];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
    
//    [AirCompanyDataBase initDataBase];
    
    [UIQuickHelp setRoundCornerForView:self.thisView withRadius:View_CoureRadious];
    [UIQuickHelp setBorderForView:self.thisView withWidth:1 withColor:View_BorderColor];
    
    [self.thisView.layer setShadowColor:View_ShadowColor;
     [self.thisView.layer setShadowRadius:2];
     [self.thisView.layer setShadowOffset:CGSizeMake(1, 3)];

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_accountLabel release];
    [_passwdLabel release];
    [_rememberPwdStateBn release];
    [_thisView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountLabel:nil];
    [self setPasswdLabel:nil];
    [self setRememberPwdStateBn:nil];
    [self setThisView:nil];
    [super viewDidUnload];
}
//回收键盘
- (IBAction)backKeyBoard:(id)sender {
    
    NSLog(@"回收键盘");
    
    [self.accountLabel resignFirstResponder];
    [self.passwdLabel resignFirstResponder];
//    [sender resignFirstResponder];
    
}

- (IBAction)rememberPwdBn:(id)sender {
    
    if (isRemember) {
        //不记住密码
        isRemember = false;
        
        [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:KEY_FrequentFly_isRememberPwd];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSLog(@"*******不记住 %d",[[NSUserDefaults standardUserDefaults] boolForKey:KEY_FrequentFly_isRememberPwd]);
        [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        
        
        
    } else{
        
        isRemember = true;
        //记住密码
        [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:KEY_FrequentFly_isRememberPwd];
        [ [NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"******* 记住%d",[[NSUserDefaults standardUserDefaults] boolForKey:KEY_FrequentFly_isRememberPwd]);
        
        //        [[NSUserDefaults standardUserDefaults] setObject:logPassword.text forKey:KEY_Default_Password];
        
        
        [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
    }
    
    
    
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
    
        
    
   
        
        [[NSUserDefaults standardUserDefaults] setObject:self.passwdLabel.text forKey:KEY_FrequentFly_User_pwd];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
//    } else{
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_FrequentFly_User_pwd];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    
//    isFrequentPassengerLogin *single = [isFrequentPassengerLogin shareFrequentPassLogin];
//    
//    NSString *cardNo = single.frequentPassData.cardNo;
//    NSString *pwd = self.passwdLabel.text;
//    
//    
//    [FrequentFlyNetWorkHelper getMemberPointInfoWithCardNo:cardNo passwd:pwd ndDelegate:self];
    
        
    SPHFrequentMainViewController *con =[[SPHFrequentMainViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    
    
//    [UIQuickHelp showAlertViewWithTitle:@"登录成功" message:@"即将跳转" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    
    
}




- (IBAction)goToMyviewpage:(id)sender {
    
       NSString *account = [self.accountLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [self.passwdLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    CCLog(@"登录名字 ：%@",account);
    
    CCLog(@"密码是 %@",pwd);
    
    if ([account length]==0) {
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"您还没有输入账号，请输入" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    } else if([pwd length]==0){
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"您还没有输入密码，请输入" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    } else{
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:self.accountLabel.text forKey:KEY_FrequentFly_User_Account];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [FrequentFlyNetWorkHelper loginWithName:self.accountLabel.text password:self.passwdLabel.text andDelegate:self];

    }
    
   
    
}
@end
