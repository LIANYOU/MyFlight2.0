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



- (void) editPersonalInfo{
    
    PersonalInfoViewController *infoCcontroller = [[PersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoCcontroller animated:YES];
    
    [infoCcontroller release];
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPersonalInfo)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
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
@end
