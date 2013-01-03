//
//  PersonalInfoViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "UIQuickHelp.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) save {
    
    LoginBusiness  *bis = [[LoginBusiness alloc] init];
    
    [bis editAccountInfoWithMemberId:Default_UserMemberId_Value userName:@"代俊友爱" userSex:@"男" userAddress:@"保密" andDelegate:self];
    [bis release];
    
    
    
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
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    right.tintColor = [UIColor colorWithRed:35/255.0 green:103/255.0 blue:188/255.0 alpha:1];
    
    self.navigationItem.rightBarButtonItem = right;
    
    [right release];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNav];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
   
    [_personalName release];
    [_detailAddress release];
    [_sexChoice release];
    [_sexName release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setPersonalName:nil];
    [self setDetailAddress:nil];
    [self setSexChoice:nil];
    [self setSexName:nil];
    [super viewDidUnload];
}
- (IBAction)backKeyBoard:(id)sender {
    
    [sender resignFirstResponder];
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
    
    
    
    
    
    
    
}


@end
