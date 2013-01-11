//
//  PersonInfotoShowViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "PersonInfotoShowViewController.h"

#import "ModifyPassWordViewController.h"
#import "PersonalInfoViewController.h"
#import "UIQuickHelp.h"
#import "AppConfigure.h"
#import "IsLoginInSingle.h"
#import "AppConfigure.h"
#import "UserAccount.h"
#import "UIButton+BackButton.h"
@interface PersonInfotoShowViewController ()

@end

@implementation PersonInfotoShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    
    UIButton * rightBn = [UIButton  backButtonType:2 andTitle:@"修改"];
    [rightBn addTarget:self action:@selector(editPersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:rightBn];
    
    self.navigationItem.rightBarButtonItem=backBtn2;
    [rightBn release];
    
    
    
       
}


- (void) editPerson{
    
    CCLog(@"执行保存密码操作");
    
    
}

- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void) viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:YES];
    
    
    [self initPersonInfo];
}



- (void) editPersonalInfo{
    
    
    
    
    PersonalInfoViewController *infoCcontroller = [[PersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoCcontroller animated:YES];
    
    [infoCcontroller release];
  
}


- (void) initPersonInfo{
    
    IsLoginInSingle *single = [IsLoginInSingle shareLoginSingle];
    self.accountNameLabel.text =Default_AccountName_Value;
    self.nameLabel.text =single.userAccount.name;
    self.sexLabel.text =single.userAccount.sex;
    self.detailAddressLabel.text = single.userAccount.addr;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNav];
    
    [self initPersonInfo];
    
    
    [UIQuickHelp setRoundCornerForView:self.thisView withRadius:8];
    
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)modifyPasswd:(id)sender {
    
    ModifyPassWordViewController *con  =[[ModifyPassWordViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    [con release];
    
    
    
}
- (void)dealloc {
    [_thisView release];
    [_userNameLabel release];
    [_nameLabel release];
    [_sexLabel release];
    [_detailAddressLabel release];
    [_accountNameLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisView:nil];
    [self setUserNameLabel:nil];
    [self setNameLabel:nil];
    [self setSexLabel:nil];
    [self setDetailAddressLabel:nil];
    [self setAccountNameLabel:nil];
    [super viewDidUnload];
}
@end
