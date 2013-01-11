//
//  ViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ViewController.h"
#import "OneWayCheckViewController.h"

#import "LogViewController.h"
#import "SearchFlightConditionController.h"
#import "HomeMoreController.h"
#import "TravelAssistantViewController.h"
#import "WriteOrderViewController.h"
#import "ChooseSpaceViewController.h"
#import "MyNewCenterViewController.h"
#import "MyCenterUnLoginViewController.h"
#import "AppConfigure.h"
#import "MyCenterTable_1.h"
#import "ChooseSeatOnlineViewController.h"
#import "AirportMainScreenViewController.h"

#import "DetailsOrderViewController.h"




#import "MyLowOrderListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar1.png"] forBarMetrics:UIBarMetricsDefault];
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

    id controller =nil;
    

    
    BOOL  isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsUserLogin];
    
//   isLogin = false;
    CCLog(@"用户登陆 %d",isLogin);
    
    if (isLogin) {

        
        controller = [[MyCenterTable_1 alloc] init];
        
               
    } else{
        
        
      controller = [[MyCenterUnLoginViewController alloc] init];
     
        
        
    }
    
       
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction)showMoreView:(id)sender {
    HomeMoreController * more = [[HomeMoreController alloc] init];
    [self.navigationController pushViewController:more animated:YES];
    [more release];
}

- (IBAction)showTravelAssistant:(id)sender {
    CCLog(@"显示出行助手");
    TravelAssistantViewController * travelAss = [[TravelAssistantViewController alloc]init];
    [self.navigationController pushViewController:travelAss animated:YES];
    [travelAss release];
}

- (IBAction)chooseSeatOnline:(id)sender {
    ChooseSeatOnlineViewController * travelAss = [[ChooseSeatOnlineViewController alloc]init];
    [self.navigationController pushViewController:travelAss animated:YES];
    [travelAss release];
    CCLog(@"显示在线选座");
}

- (IBAction)showRegularPassengerController:(id)sender {
    MyLowOrderListViewController * log = [[MyLowOrderListViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
    [log release];

    CCLog(@"显示航空公司常旅客");
}

- (IBAction)logMyAccount:(id)sender {
    LogViewController * log = [[LogViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
    [log release];
}

- (IBAction)showFlightCondition:(id)sender {
    SearchFlightConditionController * figth = [[SearchFlightConditionController alloc] init];
    [self.navigationController pushViewController:figth animated:YES];
    [figth release];
}

- (IBAction)showAirportMainScreen:(id)sender
{
    AirportMainScreenViewController *screen = [[AirportMainScreenViewController alloc] init];
    
    [self presentViewController:screen
                       animated:YES
                     completion:^(void){
                         [screen release];
                     }];
}

@end
