//
//  ViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ViewController.h"
#import "OneWayCheckViewController.h"
#import "MyCenterViewController.h"
#import "LogViewController.h"
#import "SearchFlightConditionController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden  = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTicketReservation:(id)sender {

    OneWayCheckViewController *one = [[OneWayCheckViewController alloc] init];
    [self.navigationController pushViewController:one animated:YES];
    
    [one release];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;
    
}
- (IBAction)showMyCenter:(id)sender {
    CCLog(@"显示我的中心");

    MyCenterViewController *myCenter = [[MyCenterViewController alloc] init];
    [self.navigationController pushViewController:myCenter animated:YES];
    [myCenter release];
    
}

- (IBAction)showMoreView:(id)sender {
    CCLog(@"显示更多设置界面");
}

- (IBAction)showTravelAssistant:(id)sender {
    CCLog(@"显示出行助手");
}

- (IBAction)chooseSeatOnline:(id)sender {
    CCLog(@"显示在线选座");
}

- (IBAction)showRegularPassengerController:(id)sender {
    
    CCLog(@"显示航空公司常旅客");
}

- (IBAction)logMyAccount:(id)sender {
    LogViewController * log = [[LogViewController alloc] init];
    [self presentModalViewController:log animated:YES];
    [log release];
}

- (IBAction)showFlightCondition:(id)sender {
    SearchFlightConditionController * figth = [[SearchFlightConditionController alloc] init];
    [self.navigationController pushViewController:figth animated:YES];
    [figth release];
}
@end
