//
//  OneWayCheckViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SearchFlightData.h"
#import "SVSegmentedControl.h"
#import "ChooseAirPortViewController.h"
@interface OneWayCheckViewController : UIViewController<SVSegmentedControlDelegate,ChooseAirPortViewControllerDelegate>
{
    IBOutlet UIButton *returnBtn;
    IBOutlet UIImageView *returnImage;
    IBOutlet UILabel *retrunDateTitle;
    IBOutlet UIImageView *image;
    IBOutlet UILabel *returnDate;
    IBOutlet UILabel *startDate;
    IBOutlet UILabel *endAirport;
    IBOutlet UILabel *startAirport;
    
    
    IBOutlet UILabel *oneStartAirPort;
    IBOutlet UILabel *oneSatrtDate;
    IBOutlet UILabel *oneEndAirPort;
    
    SVSegmentedControl * mySegmentController;
    
    NSString * startCode;
    NSString * endCode;
    NSString * oneStartCode;
    NSString * oneEndCode;
    
    SearchFlightData * searchDate;
}
@property (retain, nonatomic) IBOutlet UIView *selectOne;
@property (retain, nonatomic) IBOutlet UIView *selectTwoWay;
- (IBAction)getStartPort:(id)sender;

- (IBAction)getStartDate:(id)sender;
- (IBAction)getBackData:(id)sender;

- (IBAction)getEndPort:(id)sender;

- (IBAction)select:(id)sender;

- (IBAction)changeAirPort:(id)sender;
- (IBAction)oneChangeAirPort:(id)sender;

@end
