//
//  ModifyPassWordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ModifyPassWordViewController.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
#import "LoginBusiness.h"
#import "UIButton+BackButton.h"
@interface ModifyPassWordViewController ()


- (void) setNav;
@end

@implementation ModifyPassWordViewController

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
    
    
    
    
    
    
    
//    LoginBusiness *bis = [[LoginBusiness alloc] init];
//    
//    [bis updatePassWdWithOldPasswd:<#(NSString *)#> newPasswd:<#(NSString *)#> andDelegate:<#(id<ServiceDelegate>)#>]
    
    
    
    [self setNav];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    UIButton *rightBn =[UIButton backButtonType:7 andTitle:@"保存"];
    
    [rightBn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc] initWithCustomView:rightBn];
    
    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemSave target:self action:@selector(save)];
//    
//    right.tintColor = Right_BarItem_Green;
    
    
//    
    self.navigationItem.rightBarButtonItem = right;
    
    [right release];
    
    
    
    
    [UIQuickHelp setRoundCornerForView:self.modifyView withRadius:View_CoureRadious];
    
    [UIQuickHelp setRoundCornerForView:self.modifyView withRadius:View_CoureRadious];
    
    [UIQuickHelp setBorderForView:self.modifyView withWidth:1 withColor:View_BorderColor];
    
    [self.modifyView.layer setShadowColor:View_ShadowColor;
     
     [self.modifyView.layer setShadowRadius:2];
     [self.modifyView.layer setShadowOffset:CGSizeMake(1, 3)];

    
    
    
    
}


#pragma mark -
#pragma mark textField 代理
- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField ==self.orignPasswdTextField) {
        
    
        
        
    }
    
    
    //首次输入密码界面 
    if (textField ==self.newPasswdOne) {
        
        
    }
    
            
   
    
    
    
}

     
     
#pragma mark -
#pragma mark 保存密码操作
- (void) save{
    
    CCLog(@"执行保存密码操作");
    
    NSString *orignPwd =[self.orignPasswdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *newPwd1 =[self.newPasswdOne.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *newPwd2= [self.newPasswdAgainTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIAlertView *alertVerify = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil, nil];
    if ([orignPwd length]==0) {
        
        alertVerify.title = @"旧密码填写有误";
        alertVerify.message = @"请输入您的原密码";
        [alertVerify show];
        [alertVerify release];
        return;
        
        
    } else if (newPwd1.length<6) {
        
        alertVerify.title = @"新密码填写有误";
        alertVerify.message = @"为了您的账户安全，请输入最少6位字符";
        [alertVerify show];
        [alertVerify release];
        self.newPasswdOne.text = @"";
        [self.newPasswdOne becomeFirstResponder];
        
        return;
    } else if (![newPwd1 isEqualToString:newPwd2]){
        alertVerify.title = @"重复密码填写有误";
        alertVerify.message = @"两次密码输入要一致，请重新填写";
        [alertVerify show];
        [alertVerify release];
        
        self.newPasswdAgainTextField.text = @"";
        [self.newPasswdAgainTextField becomeFirstResponder];
        return;
        
    }
    
    [alertVerify release];
    
    [self.orignPasswdTextField resignFirstResponder];
    [self.newPasswdOne resignFirstResponder];
    [self.newPasswdAgainTextField resignFirstResponder];
    
    
    
    LoginBusiness *bis =[[LoginBusiness alloc] init];
    
    [bis updatePassWdWithOldPasswd:orignPwd newPasswd:newPwd1 andDelegate:self];
    
    [bis release];
    
    
    
    
}

- (void) back{
    
     [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backKeyBoard:(id)sender{
    
    
    [sender resignFirstResponder];
    
    
}
- (void)dealloc {
    [_modifyView release];
    [_newPasswdOne release];
    [_orignPasswdTextField release];
    [_newPasswdAgainTextField release];
    [_orignPasswdState release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setModifyView:nil];
    [self setNewPasswdOne:nil];
    [self setOrignPasswdTextField:nil];
    [self setNewPasswdAgainTextField:nil];
    [self setOrignPasswdState:nil];
    [super viewDidUnload];
}


#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
        
}



@end
