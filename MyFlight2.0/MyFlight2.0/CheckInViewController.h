//
//  CheckInViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ChooseAirPortViewController.h"
#import "ChooseFlightViewController.h"
#import "AirPortData.h"

@interface CheckInViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ChooseAirPortViewControllerDelegate>
{
    UITableView *checkInInfoTable;
    
    IBOutlet UIButton *registerforCheckIn;
    IBOutlet UIButton *checkforProgress;
    
    NSArray *titleArray;
    
    NSString *passengerName;
    NSString *passportType;
    NSString *passportNumber;
    NSString *departureAirport;
    NSString *isLogined;
    
    UITextField *input;
    
    __block NSDictionary *responseDictionary;
}

- (void) changeName;
- (void) changePassportNumber;
- (void) cancelChange;

- (IBAction)checkIn:(UIButton *)sender;
- (IBAction)progressQuery:(UIButton *)sender;

@end
