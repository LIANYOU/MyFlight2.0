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
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonSystemItemSave target:self action:@selector(editPersonalInfo)];
    
    right.tintColor = Right_BarItem_Green;
    
    self.navigationItem.rightBarButtonItem = right;
    
    [right release];
    
}


- (void) editPerson{
    
    CCLog(@"执行保存密码操作");
    
    
}

- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}





- (void) editPersonalInfo{
    
    PersonalInfoViewController *infoCcontroller = [[PersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoCcontroller animated:YES];
    
    [infoCcontroller release];
    
   
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNav];
    
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
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisView:nil];
    [self setUserNameLabel:nil];
    [self setNameLabel:nil];
    [self setSexLabel:nil];
    [self setDetailAddressLabel:nil];
    [super viewDidUnload];
}
@end
