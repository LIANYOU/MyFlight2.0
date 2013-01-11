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
#import "IsLoginInSingle.h"
#import "UserAccount.h"
#import "UIButton+BackButton.h"
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
    
    NSString *name= [self.personalName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *sex =[self.sexName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *address =[self.detailAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if ([name length]==0) {
        
        [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"请输入姓名" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
    } else if([address length]==0){
        
        [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"请输入地址" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
    } else{
        
        
        NSString *sexNet = nil;
        
        if ([sex isEqualToString:@"男"]) {
            sexNet =@"0";
        } else{
            sexNet = @"1";
        }
        
        
        LoginBusiness  *bis = [[LoginBusiness alloc] init];
        
        [bis editAccountInfoWithMemberId:Default_UserMemberId_Value userName:name userSex:sexNet userAddress:address andDelegate:self];
        [bis release];
        
        
    }
    
    
}
#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    
    
    UIButton * rightBn = [UIButton  backButtonType:7 andTitle:@"保存"];
    [rightBn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:rightBn];
    
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];
    
}


//初始化视图
- (void) initThisView{
    
    IsLoginInSingle *single =[IsLoginInSingle shareLoginSingle];
    self.personalName.text =single.userAccount.name;
    self.detailAddress.text = single.userAccount.addr;
    
    if ([single.userAccount.sex isEqualToString:@"男"]) {
        
        self.sexChoice.selectedSegmentIndex=0;
        
    } else{
        
        self.sexChoice.selectedSegmentIndex=1;

    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
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
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    IsLoginInSingle *single =[IsLoginInSingle shareLoginSingle];
    
    single.userAccount.name = self.personalName.text;
    single.userAccount.addr = self.detailAddress.text;
    single.userAccount.sex = self.sexName.text;
    
    [self.navigationController popViewControllerAnimated:YES];
        
}


- (IBAction)segmentForSex:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex==0) {
        
        
        self.sexName.text = @"男";
    } else{
        
        self.sexName.text = @"女";
    }
    
    
}
@end
