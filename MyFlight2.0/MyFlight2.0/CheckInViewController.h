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

@interface CheckInViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ChooseAirPortViewControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    UITableView *checkInInfoTable;
    
    UIButton *registerforCheckIn;
    UIButton *checkforProgress;
    
    NSArray *titleArray;
    
    UITextField *passName;
    UIButton *changeType;
    UILabel *typeLabel;
    UITextField *idNo;
    UIButton *changeCity;
    UILabel *cityLabel;
    
    UIButton *invisibleButton;
    
    NSString *depCity;
    NSString *depCityCode;
    
    unsigned char passportType;
    
    __block NSDictionary *responseDictionary;
}

- (void) back;

- (void) checkIn;
- (void) progressQuery;
- (void) chooseAirport;
- (void) choosePassportType;

@end
