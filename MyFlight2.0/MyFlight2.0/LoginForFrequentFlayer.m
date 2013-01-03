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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (isRemember) {
        
    [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        
        self.passwdLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FrequentFly_User_pwd];
        
        
    } else{
        
        [self.rememberPwdStateBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    self.accountLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FrequentFly_User_Account];
    
    

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
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountLabel:nil];
    [self setPasswdLabel:nil];
    [self setRememberPwdStateBn:nil];
    [super viewDidUnload];
}
- (IBAction)backKeyBoard:(id)sender {
    
    NSLog(@"回收键盘");
    [sender resignFirstResponder];
    
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
    
    [[NSUserDefaults standardUserDefaults] setObject:self.accountLabel.text forKey:KEY_FrequentFly_User_Account];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    if (isRemember) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.passwdLabel.text forKey:KEY_FrequentFly_User_pwd];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    } else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_FrequentFly_User_pwd];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    [UIQuickHelp showAlertViewWithTitle:@"登录成功" message:@"即将跳转" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    
    
    
    
        
       
    
}




- (IBAction)goToMyviewpage:(id)sender {
    
    SPHFrequentMainViewController *controller = [[SPHFrequentMainViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
    
}
@end
