//
//  ViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ViewController.h"
#import "OneWayTicketCheckController.h"
#import "MyCenterViewController.h"

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
    
    CCLog(@"显示机票预订");

    OneWayTicketCheckController *one = [[OneWayTicketCheckController alloc] init];
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
@end
