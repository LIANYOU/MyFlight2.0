//
//  ChooseFlightViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ChooseFlightViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *passengerInfoTable;
    NSArray *passengerTitleArray;
    NSString *passengerName;
    NSString *passengerID;
    
    UITableView *flightInfoTable;
    NSArray *flightInfoArray;
    NSInteger flightCount;
    NSInteger currentSelection;
}

@property (nonatomic, assign) BOOL isQuery;

- (id) initWithNameAndID: (NSString *) name: (NSString *) ID;

@end
