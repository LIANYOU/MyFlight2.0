//
//  MyNewCenterViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyNewCenterViewController.h"
#import "PersonalInfoViewController.h"
#import "PersonInfotoShowViewController.h"
#import "CommonContactViewController.h"

#import "MyCheapViewController.h"

#import "MyOrderListViewController.h"
#import "MyCheapViewController.h"
#import "HistoryCheckDataBase.h"

#import "UserAccount.h"
#import "IsLoginInSingle.h"
#import "AppConfigure.h"

#import "LoginBusiness.h"
#import "UIQuickHelp.h"


@interface MyNewCenterViewController ()

@end

@implementation MyNewCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) back{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//
- (void) loginOut{
    
    
    
    
    
}

#pragma mark -
#pragma mark 设置导航栏 
- (void) setNav{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonSystemItemSave target:self action:@selector(loginOut)];
    
    right.tintColor = [UIColor colorWithRed:35/255.0 green:103/255.0 blue:188/255.0 alpha:1];
    
    self.navigationItem.rightBarButtonItem = right;

    [right release];
    
       
}






//网络错误回调的方法 
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
     NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
    
    
    
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    
    
    
    
    
    
}



- (void) updateThisViewWhenSuccess{
    
   CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    //用户已经登录的情况下 显示用户相关的信息
    
    IsLoginInSingle *userSingle = [IsLoginInSingle shareLoginSingle];
    self.userNameLabel.text = Default_AccountName_Value;
    
    self.accountMoneyLabel.text = userSingle.userAccount.account;
    
    self.xlGoldMoneyLabel.text = userSingle.userAccount.xinlvGoldMoeny;
    self.xlSilverMoneyLabel.text = userSingle.userAccount.xinlvSilverMoney;

}


- (void)viewDidLoad
{
   
    [super viewDidLoad];
    NSString * string = KEY_FlightBook_FlightVo__aircraftType_WithType(@"Go");
    
    NSLog(@"type *************** =%@",string);
    
    
    LoginBusiness *busi = [[LoginBusiness alloc] init];
    
    NSString *memberId =Default_UserMemberId_Value;
    
    CCLog(@"在个人中心界面 memberId= %@",memberId);
    [busi getAccountInfoWithMemberId:memberId andDelegate:self];
    
    
    [self setNav];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoPersonalInfo:(id)sender {
    
    PersonInfotoShowViewController *controller = [[PersonInfotoShowViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
       
}

//推出我的优惠券界面 
- (IBAction)gotoMyCoupons:(id)sender {
    
    
    MyCheapViewController *con = [[MyCheapViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    [con release];
    
    
    
}


//显示我的订单列表 
- (IBAction)gotoMyOrderList:(id)sender {
    
    MyOrderListViewController *con = [[MyOrderListViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    
    [con release];
    
    
}

- (IBAction)gotoCommonPerson:(id)sender {
    
    
    CommonContactViewController *con = [[CommonContactViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    [con release];
    
}


//显示我订阅的低价航线

- (IBAction)gotoMyCheapFlightList:(id)sender {
    
//    MyCheapViewController *con= [[MyCheapViewController alloc] init];
//    [self.navigationController pushViewController:con animated:YES];
//    
//    [con release];
//    
    
}




//心愿旅行卡充值 
- (IBAction)gotoMakeAccountFull:(id)sender {
    
    
}
- (void)dealloc {
    [_accountMoneyLabel release];
    [_xlGoldMoneyLabel release];
    [_xlSilverMoneyLabel release];
    [_userNameLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountMoneyLabel:nil];
    [self setXlGoldMoneyLabel:nil];
    [self setXlSilverMoneyLabel:nil];
    [self setUserNameLabel:nil];
    [super viewDidUnload];
}
@end
