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
#import "Date.h"
#import "ViewControllerDelegate.h"
#import "HistroyCheckViewController.h"

@interface OneWayCheckViewController : UIViewController<SVSegmentedControlDelegate,ChooseAirPortViewControllerDelegate, ViewControllerDelegate>
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
   
    // one
    IBOutlet UIView *beginView;
    IBOutlet UIView *endView;
    IBOutlet UIImageView *beginImage;
    IBOutlet UIImageView *endImage;
    IBOutlet UILabel *beginTitle;
    IBOutlet UILabel *endTitle;
    
    // two
    IBOutlet UIView *twoBeginView;
    IBOutlet UIView *twoEndView;
    IBOutlet UIImageView *twoBeginImageView;
    IBOutlet UIImageView *twoEndImageView;
    IBOutlet UILabel *twoBeginTitle;
    IBOutlet UILabel *twoEndTitle;
    
    
    SVSegmentedControl * mySegmentController;
    
    NSString * startCode;
    NSString * endCode;
    NSString * oneStartCode;
    NSString * oneEndCode;
    
    SearchFlightData * searchDate;
    
    Date* leaveDate;
}

//@property (retain, nonatomic) IBOutlet UILabel *oneStartAirPort;
//@property (retain, nonatomic) IBOutlet UILabel *oneEndAirPort;
//
//
//@property (retain, nonatomic) IBOutlet UILabel *startAirport;
//@property (retain, nonatomic) IBOutlet UILabel *endAirport;


@property (retain, nonatomic) NSString * oneStartName;
@property (retain, nonatomic) NSString * oneEndName;
@property (retain, nonatomic) NSString * oneStartCode;
@property (retain, nonatomic) NSString * oneEndCode;

@property (retain, nonatomic) NSString * startName;
@property (retain, nonatomic) NSString * endName;
@property (retain, nonatomic) NSString * startCode;
@property (retain, nonatomic) NSString * endCode;

@property (retain, nonatomic) NSString * flagType;

@property (retain, nonatomic) HistroyCheckViewController * history;


@property (retain, nonatomic) IBOutlet UIView *selectOne;
@property (retain, nonatomic) IBOutlet UIView *selectTwoWay;


@property (retain, nonatomic) NSMutableArray * startNameArr;
@property (retain, nonatomic) NSMutableArray * endNameArr;
@property (retain, nonatomic) NSMutableArray * flyFlagArr;
@property (retain, nonatomic) NSMutableArray * startThreeArr;
@property (retain, nonatomic) NSMutableArray * endThreeArr;

- (IBAction)getStartPort:(id)sender;

- (IBAction)getStartDate:(id)sender;
- (IBAction)getBackData:(id)sender;

- (IBAction)getEndPort:(id)sender;

- (IBAction)select:(id)sender;

- (IBAction)changeAirPort:(id)sender;
- (IBAction)oneChangeAirPort:(id)sender;

@end
