//
//  LookForPasswordFirstStepViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "LookForPasswordFirstStepViewController.h"

#import "LookForPasswordViewController.h"
@interface LookForPasswordFirstStepViewController ()

@end

@implementation LookForPasswordFirstStepViewController

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
    self.title  =@"找回密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_UserInputPhoneNumber release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserInputPhoneNumber:nil];
    [super viewDidUnload];
}
- (IBAction)goToNextStep:(id)sender {
    LookForPasswordViewController *controller = [[LookForPasswordViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
@end
