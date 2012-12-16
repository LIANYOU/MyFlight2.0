//
//  ResetPassWordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ResetPassWordViewController.h"

@interface ResetPassWordViewController ()

@end

@implementation ResetPassWordViewController

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
    [_newPassword release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNewPassword:nil];
    [super viewDidUnload];
}
- (IBAction)showPasswordState:(id)sender {
}

- (IBAction)commitResetPasswordRequest:(id)sender {
}
@end
