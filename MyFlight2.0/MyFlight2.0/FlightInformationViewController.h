//
//  FlightInformationViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "BasicViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"

@interface FlightInformationViewController : BasicViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *detailedInfoTable;
    NSArray *detailedTitleArray;
    
    UITableView *flightInfoTable;
    
    UIAlertView *alertMessage;
    
    __block NSDictionary *responseDictionary;
}

@property (retain, nonatomic) NSString *org;
@property (retain, nonatomic) NSString *passName;
@property (retain, nonatomic) NSString *idNo;

- (void) requestForData;
- (void) cancelCheckIn;

@end
