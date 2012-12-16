//
//  LookForPasswordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "LookForPasswordViewController.h"
#import "ResetPassWordViewController.h"
@interface LookForPasswordViewController ()

@end

@implementation LookForPasswordViewController

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
    [_VerificationCode release];
    [_disPlayName release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setVerificationCode:nil];
    [self setDisPlayName:nil];
    [super viewDidUnload];
}
- (IBAction)RequestCodeAgain:(id)sender {
}

- (IBAction)ResetPassword:(id)sender {
    
    //重置密码界面 
    ResetPassWordViewController *controller = [[ResetPassWordViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
@end
