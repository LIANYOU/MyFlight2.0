//
//  OneWayCheckViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFlightData.h"
@interface OneWayCheckViewController : UIViewController
{
    IBOutlet UIButton *returnBtn;
    IBOutlet UILabel *retrunDateTitle;
    IBOutlet UILabel *returnDate;
    IBOutlet UILabel *startDate;
    IBOutlet UILabel *endAirport;
    IBOutlet UILabel *startAirport;
    
    IBOutlet UISegmentedControl *selectSegment;
    
    SearchFlightData * searchDate;
}

- (IBAction)selectFlayWay:(UISegmentedControl *)sender;
- (IBAction)select:(id)sender;
@end
