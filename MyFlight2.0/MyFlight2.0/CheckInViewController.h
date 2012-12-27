//
//  CheckInViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ChooseFlightViewController.h"

@interface CheckInViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *checkInInfoTable;
    IBOutlet UIButton *registerforCheckIn;
    IBOutlet UIButton *checkforProgress;
    NSArray *titleArray;
    NSString *passengerName;
    NSString *passportType;
    NSString *passportNumber;
    NSString *departureAirport;
}

- (IBAction)checkIn:(UIButton *)sender;
- (IBAction)progressQuery:(UIButton *)sender;

@end
