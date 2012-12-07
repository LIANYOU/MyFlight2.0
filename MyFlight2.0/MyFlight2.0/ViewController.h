//
//  ViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//显示机票预订
- (IBAction)showTicketReservation:(id)sender;

//显示我的中心
- (IBAction)showMyCenter:(id)sender;

//显示更多 设置
- (IBAction)showMoreView:(id)sender;

//显示出行助手
- (IBAction)showTravelAssistant:(id)sender;

//在线选座
- (IBAction)chooseSeatOnline:(id)sender;
//显示航空公司常旅客
- (IBAction)showRegularPassengerController:(id)sender;

- (IBAction)logMyAccount:(id)sender;

- (IBAction)showFlightCondition:(id)sender;
@end
