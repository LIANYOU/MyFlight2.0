//
//  SearchFlightConditionController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "ChooseAirPortViewController.h"
@interface SearchFlightConditionController : UIViewController<SVSegmentedControlDelegate,ChooseAirPortViewControllerDelegate>{
    SVSegmentedControl * mySegmentController;
    NSString * startAirPortCode;
    NSString * arrAirPortCode;
}
@property (nonatomic,retain)IBOutlet UILabel * flightTimeByNumber;

@property (retain, nonatomic) IBOutlet UILabel *startAirPort;
@property (retain, nonatomic) IBOutlet UILabel *endAirPort;
@property (retain, nonatomic) IBOutlet UILabel *time;

@property (retain, nonatomic) IBOutlet UITextField *flightNumber;

@property (retain, nonatomic) IBOutlet UIView *selectedByDate;

@property (retain, nonatomic) IBOutlet UIView *selectedByAirPort;
- (IBAction)selectedInquireType:(UISegmentedControl *)sender;

- (IBAction)searchFligth:(id)sender;


- (IBAction)chooseStartAirPort:(id)sender;

- (IBAction)chooseEndAirPort:(id)sender;

@end
