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
    [_forgetPassword release];
    [super dealloc];
}
- (void)viewDidUnload {
    [logNumber release];
    logNumber = nil;
    [logPassword release];
    logPassword = nil;
    [self setForgetPassword:nil];
    [super viewDidUnload];
}
- (IBAction)beginLoging:(id)sender {
    
}

- (IBAction)registerNewNumber:(id)sender {
    RegisterViewController * view = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
- (IBAction)LookForPassword:(id)sender {
    
    
    LookForPasswordFirstStepViewController *controller =[[LookForPasswordFirstStepViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
       
}
@end
