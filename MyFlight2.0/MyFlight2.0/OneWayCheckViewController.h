//
//  OneWayCheckViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFlightData.h"
#import "ChooseAirPortViewController.h"
@interface OneWayCheckViewController : UIViewController<ChooseAirPortViewControllerDelegate>
{
    IBOutlet UIButton *returnBtn;
    IBOutlet UILabel *retrunDateTitle;
    IBOutlet UILabel *returnDate;
    IBOutlet UILabel *startDate;
    IBOutlet UILabel *endAirport;
    IBOutlet UILabel *startAirport;
    
    IBOutlet UISegmentedControl *selectSegment;
    
    NSString * startCode;
    NSString * endCode;
    
    SearchFlightData * searchDate;
}
- (IBAction)getStartPort:(id)sender;

- (IBAction)getStartDate:(id)sender;
- (IBAction)getBackData:(id)sender;

- (IBAction)getEndPort:(id)sender;
- (IBAction)selectFlayWay:(UISegmentedControl *)sender;
- (IBAction)select:(id)sender;
@end
