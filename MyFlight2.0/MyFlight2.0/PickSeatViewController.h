//
//  PickSeatViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-27.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SeatMapView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface PickSeatViewController : UIViewController
{
    UIScrollView *scroll;
    
    SeatMapView *map;
    
    UILabel *title;
    
    __block NSDictionary *responseDictionary;
}

@property (retain, nonatomic) NSString *tktno;
@property (retain, nonatomic) NSString *segIndex;
@property (retain, nonatomic) NSString *passName;
@property (retain, nonatomic) NSString *airline;
@property (retain, nonatomic) NSString *orgId;
@property (retain, nonatomic) NSString *org;
@property (retain, nonatomic) NSString *symbols;

- (void) requestForData;
- (void) updateTitle;
- (void) back;
- (void) checkIn;

@end
