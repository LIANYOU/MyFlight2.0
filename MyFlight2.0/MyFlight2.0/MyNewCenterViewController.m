//
//  MyNewCenterViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyNewCenterViewController.h"
#import "PersonalInfoViewController.h"


@interface MyNewCenterViewController ()

@end

@implementation MyNewCenterViewController

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

- (IBAction)gotoPersonalInfo:(id)sender {
    
    PersonalInfoViewController *controller = [[PersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
       
}

- (IBAction)gotoMyCoupons:(id)sender {
}

- (IBAction)gotoMyOrderList:(id)sender {
}

- (IBAction)gotoCommonPerson:(id)sender {
}

- (IBAction)gotoMyCheapFlightList:(id)sender {
}

- (IBAction)gotoMakeAccountFull:(id)sender {
}
@end
