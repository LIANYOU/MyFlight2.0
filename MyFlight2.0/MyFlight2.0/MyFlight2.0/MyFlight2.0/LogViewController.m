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
@interface LogViewController ()

@end

@implementation LogViewController

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
    
    ScrollerView.contentSize = CGSizeMake(320, 600);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [logNumber release];
    [logPassword release];

    [ScrollerView release];
    [_remembePasswordBn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [logNumber release];
    logNumber = nil;
    [logPassword release];
    logPassword = nil;

    [ScrollerView release];
    ScrollerView = nil;
    [self setRemembePasswordBn:nil];
    [super viewDidUnload];
}


//登陆 
- (IBAction)beginLoging:(id)sender {
    
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
}

- (IBAction)LoginWithTencentWeiBo:(id)sender {
}

- (IBAction)LoginWithWeiXin:(id)sender {
}

- (IBAction)LoginWithSinaWeiBo:(id)sender {
}

//记住密码按钮 
- (IBAction)rememberPassword:(id)sender {
    
    if ([[self.remembePasswordBn currentBackgroundImage] isEqual:[UIImage imageNamed:@"icon_choice.png"]]) {
        //不记住密码
        
       [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"ico_def.png"] forState:UIControlStateNormal];
        
        
        
    } else{
        
        //记住密码
         [self.remembePasswordBn setBackgroundImage:[UIImage imageNamed:@"icon_choice.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    
}
@end
