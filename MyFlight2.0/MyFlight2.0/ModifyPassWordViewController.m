//
//  ModifyPassWordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ModifyPassWordViewController.h"
#import "AppConfigure.h"
@interface ModifyPassWordViewController ()

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
    
    [self setNav];
    // Do any additional setup after loading the view from its nib.
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
    
    right.tintColor = Right_BarItem_Green;
    
    self.navigationItem.rightBarButtonItem = right;
    
    [right release];
    
}


- (void) save{
    
    CCLog(@"执行保存密码操作");
    
    
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
@end
