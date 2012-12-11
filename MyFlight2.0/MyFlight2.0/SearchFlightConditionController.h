//
//  SearchFlightConditionController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFlightConditionController : UIViewController

@property (retain, nonatomic) IBOutlet UISegmentedControl *selectedSegment;
@property (retain, nonatomic) IBOutlet UILabel *startAirPort;
@property (retain, nonatomic) IBOutlet UILabel *endAirPort;
@property (retain, nonatomic) IBOutlet UILabel *time;

@property (retain, nonatomic) IBOutlet UITextField *flightNumber;

@property (retain, nonatomic) IBOutlet UIView *selectedByDate;

@property (retain, nonatomic) IBOutlet UIView *selectedByAirPort;
- (IBAction)selectedInquireType:(UISegmentedControl *)sender;

- (IBAction)searchFligth:(id)sender;
@end
