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
    UITableView *detailedInfoTable;
    NSArray *detailedTitleArray;
    
    UITableView *flightInfoTable;
    
    NSString *departTime;
    NSString *departDate;
    NSString *departAirport;
    NSString *arrivalTime;
    NSString *arrivalDate;
    NSString *arrivalAirport;
    
    __block NSDictionary *responseDictionary;
}

@property (retain, nonatomic) NSString *tktno;
@property (retain, nonatomic) NSString *passName;
@property (retain, nonatomic) NSString *passID;
@property (retain, nonatomic) NSString *segIndex;
@property (retain, nonatomic) NSString *isLogined;

@property (retain, nonatomic) NSString *flightNo;
@property (retain, nonatomic) NSString *deCity;
@property (retain, nonatomic) NSString *arrCity;

- (void) cancelCheckIn;

@end
