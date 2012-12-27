//
//  FlightInformationViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FlightInformationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIButton *cancelCheckInButtom;
    UITableView *detailedInfoTable;
    NSArray *detailedTitleArray;
    NSArray *detailedValueArray;
    
    UITableView *flightInfoTable;
    
    NSString *flightNumber;
    NSString *departCity;
    NSString *arrivalCity;
    
    NSString *departTime;
    NSString *departDate;
    NSString *departAirport;
    NSString *arrivalTime;
    NSString *arrivalDate;
    NSString *arrivalAirport;
}

- (IBAction)cancelCheckIn:(UIButton *)sender;

@end
