//
//  ChooseFlightViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PickSeatViewController.h"
#import "FlightInformationViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface ChooseFlightViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *passengerInfoTable;
    UITableView *flightInfoTable;
    
    NSInteger currentSelection;
    
    __block NSDictionary *responseDictionary;
}

@property (nonatomic, assign) BOOL isQuery;

@property (nonatomic, retain) NSString *passName;
@property (nonatomic, retain) NSString *idNo;
@property (nonatomic, retain) NSString *depCity;

- (void) requestForData;
- (void) confirmSelection;

@end
