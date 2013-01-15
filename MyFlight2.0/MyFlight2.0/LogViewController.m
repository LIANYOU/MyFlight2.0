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
#import "MyCenterTable_1.h"
#import "UIButton+BackButton.h"
#import "ASIFormDataRequest.h"
@interface LogViewController ()
{
    
    BOOL isRemember;
    IsLoginInSingle *loginSingle;
    LoginBusiness *loginBusiness;
    
    
}
@end

@implementation LogViewController
@synthesize weiboEngine;
//@synthesize sinaweibo;


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
    
    UISwipeGestureRecognizer *swip =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
    swip.direction =UISwipeGestureRecognizerDirectionDown|UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer: swip];
    
    [swip release];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKey:)];
    [self.view addGestureRecognizer:tap];
    
    [tap release];
    
    
    
    
    
    
    
    
//    self.swipGesture.direction =UISwipeGestureRecognizerDirectionDown|UISwipeGestureRecognizerDirectionUp;
//    
    
    logNumber.delegate =self;
    logPassword.delegate =self;
    
    [UIQuickHelp setRoundCornerForView:self.thisViewLogin withRadius:View_CoureRadious];
    [UIQuickHelp setBorderForView:self.thisViewLogin withWidth:1 withColor:View_BorderColor];
    
    [self.thisViewLogin.layer setShadowColor:View_ShadowColor;
     [self.thisViewLogin.layer setShadowRadius:2];
     [self.thisViewLogin.layer setShadowOffset:CGSizeMake(1, 3)];
     
     //新浪微博登陆初始化定义
     //    sinaweibo = [[SinaWeibo alloc] initWithAppKey:sinaWeiboAppKey appSecret:sinaWeiboAppSecret appRedirectURI:sinaWeiboAppRedirectURI andDelegate:self];
     
     //腾讯QQ登陆初始化定义
     _permissions =  [[NSArray arrayWithObjects:
                       @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                       @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
     
     _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100353306"
                                             andDelegate:self];
     _tencentOAuth.redirectURI = @"www.qq.com";
     
     //腾讯微博登陆初始化定义
     TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.51you.com/mobile/myflight.html"];
     [engine setRootViewController:self];
     self.weiboEngine = engine;
     [engine release];
     
     
     //默认设置先回到我的个人中心
     // self.loginSuccessReturnType = Login_Success_ReturnMyCenterDefault_Type;
     
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
         
         logPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_Password];
         
         
     } else{
         
         [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
         
         
     }
     
     
     logNumber.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_AccountName];
     
     
     //    if (iPhone5) {
     //
     //        CCLog(@"是iPhone5");
     //
     //        ScrollerView.contentSize = CGSizeMake(320, MainHeight_withNavBar+10);
     //
     //    } else{
     //
     //        ScrollerView.contentSize =CGSizeMake(320, <#CGFloat height#>)
     //    }
     
     
     
     
     self.title = @"用户登录";
     
     
     
     // Do any additional setup after loading the view from its nib.
     }
     
     - (void)didReceiveMemoryWarning
     {
         [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }
     
     - (void)dealloc {
         [_swipGesture release];
         [logNumber release];
         [logPassword release];
         [loginBusiness release];
         [ScrollerView release];
         [_remembePasswordBn release];
         [_thisViewLogin release];
         [super dealloc];
     }
     - (void)viewDidUnload {
         [logNumber release];
         logNumber = nil;
         [logPassword release];
         logPassword = nil;
         self.swipGesture =nil;
         [ScrollerView release];
         ScrollerView = nil;
         [self setRemembePasswordBn:nil];
         [self setThisViewLogin:nil];
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
     
     
- (void)initLocalDatabase{
         
    
    
         LoginBusiness *bis =[[LoginBusiness alloc] init];
         
         [bis getCommonPassengerWithMemberId:Default_UserMemberId_Value andDelegate:nil];
         
         [bis getOrderListWithCurrentPage:@"1" rowsOfPage:@"100" andDelegate:nil];
         [bis release];
    
    
    
    
    
     }
     
     
#pragma mark -
#pragma mark 登录成功时的操作
     
     - (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
         
         //    用户输入什么就会记录 用户账户的默认值
         CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
         
         CCLog(@"保存的用户名：%@",logNumber.text);
         
         [[NSUserDefaults standardUserDefaults] setObject:logNumber.text forKey:KEY_Default_AccountName];
         
         
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         
         
         if (isRemember) {
             
             [[NSUserDefaults standardUserDefaults] setObject:logPassword.text forKey:KEY_Default_Password];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             
         } else{
             
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_Password];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
         
         
         //     [UIQuickHelp showAlertViewWithTitle:@"登录成功" message:@"即将跳转" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
         
         
         NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_Token];
         NSString *memberID = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_MemberId];
         
         
         NSString *idUser = loginSingle.userAccount.memberId;
         
         NSLog(@"登录成功后用户id为：%@",memberID);
         NSLog(@"用户id =%@",idUser);
         NSLog(@"token = %@",token);
         
         //    sleep(1);
         
         
         [self performSelectorInBackground:@selector(initLocalDatabase) withObject:nil];
         
         
         
         
         if ([self.loginSuccessReturnType isEqualToString:Login_Success_ReturnMyCenterDefault_Type]) {
             CCLog(@"默认返回我的个人中心操作");
             
             
             
             
             MyCenterTable_1 *controller = [[MyCenterTable_1 alloc] init];
             
             UINavigationController *con =[[UINavigationController alloc] initWithRootViewController:controller];
             [controller release];
             
             
             //    [loginBusiness getAccountInfoWithMemberId:memberID andDelegate:controller];
             
             //更新界面
             [self presentViewController:con animated:YES completion:^{
                 
                 
                 
                 
             }];
             
         } else{
             
             
             [self.navigationController popViewControllerAnimated:YES];
         }
         
         
     }
     //登陆
#pragma mark -
#pragma mark 登录操作
     - (IBAction)beginLoging:(id)sender {
         
         NSString *account = [logNumber.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         NSString *pwd = [logPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         CCLog(@"账号 ：%@",account);
         
         CCLog(@"登录密码：%@",pwd);
         
         if ([account length]==0) {
             
             
             [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"请输入账号" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
             [logNumber becomeFirstResponder];
             
         } else if ([pwd length]==0) {
             
             
             [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
             [logPassword becomeFirstResponder];
             
         } else{
             
             [logNumber resignFirstResponder];
             [logPassword resignFirstResponder];
             
             
             [loginBusiness loginWithName:account password:pwd andDelegate:self];
             
             
         }
         
         
         
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
         [_tencentOAuth authorize:_permissions inSafari:NO];
     }
     
     - (IBAction)LoginWithTencentWeiBo:(id)sender {
         [weiboEngine logInWithDelegate:self
                              onSuccess:@selector(onSuccessLogin)
                              onFailure:@selector(onFailureLogin:)];
     }
     
     
     - (IBAction)LoginWithWeiXin:(id)sender {
         
     }
     
     - (IBAction)LoginWithSinaWeiBo:(id)sender {
         SinaWeibo *sinaweibo = [self sinaweibo];
         [sinaweibo logIn];
     }
     
#pragma mark --SinaWeibo functions
     - (SinaWeibo *)sinaweibo
     {
         AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
         return appDelegate.sinaweibo;
     }
#pragma mark SinaWeibo Delegate
     -(void) sinaweiboDidLogIn:(SinaWeibo *)sinaweiboLogined{
         NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] init];
         [userInfoDict setObject:sinaweiboLogined.userID forKey:@"usrId"];
         [userInfoDict setObject:@"sinaweibo" forKey:@"source"];
         [userInfoDict setObject:sinaweiboLogined.accessToken forKey:@"token"];
         
         [loginBusiness loginWithOAuth:userInfoDict andDelegate:self];
         
         //    [[NSUserDefaults standardUserDefaults] setObject:sinaweiboLogined forKey:@"sinaweiboUserInfo"];
         //    [[NSUserDefaults standardUserDefaults] synchronize];
     }
     
     //记住密码按钮
     
#pragma mark TencentQQ Delegate
     - (void)tencentDidLogin {
         NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] init];
         [userInfoDict setObject:_tencentOAuth.openId forKey:@"usrId"];
         [userInfoDict setObject:@"tencentQQ" forKey:@"source"];
         [userInfoDict setObject:_tencentOAuth.accessToken forKey:@"token"];
         
         [loginBusiness loginWithOAuth:userInfoDict andDelegate:self];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:_tencentOAuth forKey:@"tencentQQUserinfo"];
     }
     
#pragma mark TencentWeibo Delegate
     
     //登录成功回调
     - (void)onSuccessLogin
     {
         NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] init];
         [userInfoDict setObject:weiboEngine.openId forKey:@"usrId"];
         [userInfoDict setObject:@"tencentWeibo" forKey:@"source"];
         [userInfoDict setObject:weiboEngine.accessToken forKey:@"token"];
         
         [loginBusiness loginWithOAuth:userInfoDict andDelegate:self];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:weiboEngine forKey:@"tencentweiboUserInfo"];
     }
     
     //登录失败回调
     - (void)onFailureLogin:(NSError *)error
     {
         NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
                                                             message:message
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
         [alertView show];
         [alertView release];
         [message release];
     }
     
     
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
     
     
     - (BOOL) textFieldShouldReturn:(UITextField *)textField{
         
         if ([textField isEqual:logNumber]) {
             
             //             [logNumber resignFirstResponder];
             [logPassword becomeFirstResponder];
             
             
         } else{
             
             [textField resignFirstResponder];
             
             //          [self performSelector:@selector(beginLoging:)];
             
             
         }
         
         
         return true;
         
     }
     
     
     
     - (IBAction)backKey:(id)sender {
         
         [logNumber resignFirstResponder];
         [logPassword resignFirstResponder];
     }
     @end
