//
//  FlightInformationViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface FlightInformationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *detailedInfoTable;
    NSArray *detailedTitleArray;
    
    UITableView *flightInfoTable;
    
    __block NSDictionary *responseDictionary;
}

@property (retain, nonatomic) NSString *org;
@property (retain, nonatomic) NSString *passName;
@property (retain, nonatomic) NSString *idNo;

- (void) requestForData;

- (void) back;
- (void) cancelCheckIn;

@end
