//
//  ModifyPassWordViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ModifyPassWordViewController.h"

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
    // Do any additional setup after loading the view from its nib.
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
