//
//  DetailsOrderViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
#import "OrderDetaile.h"
#import "WJOrderBasicCell.h"
#import "OrderBasicInfoWJ.h"
#import "FlightConditionWj.h"
#import "InFlightConditionWJ.h"
#import "PostInfo.h"
#import "LinkPersonInfo.h"
@class PassengerCell;
@class LinkmanCell;
@class JourneyCell;
@class FlightConditionCell;

@interface DetailsOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>

{
    
    
    
}

@property (retain, nonatomic) OrderBasicInfoWJ * order;
@property (retain, nonatomic) FlightConditionWj * flight;
@property (retain, nonatomic) InFlightConditionWJ * inFlight;
@property (retain, nonatomic) PostInfo * post;
@property (retain, nonatomic) LinkPersonInfo * person;

@property (retain, nonatomic) NSArray * personArray;  // 保存乘机人的信息

@property (retain, nonatomic) IBOutlet UIView *one;
@property (retain, nonatomic) IBOutlet UIView *two;
@property (retain, nonatomic) IBOutlet UIView *three;
@property (retain, nonatomic) IBOutlet UIView *four;
@property (retain, nonatomic) IBOutlet UIView *five;


@property (retain, nonatomic) NSString * searchType;


@property (retain, nonatomic) UIView * tempView;
@property (retain, nonatomic) OrderDetaile * detaile;

@property (retain, nonatomic) IBOutlet UIView *bigView;
@property (retain, nonatomic) IBOutlet UIView *smallView;

@property (retain, nonatomic) IBOutlet UITableView *showTableView;


@property (retain, nonatomic) IBOutlet WJOrderBasicCell *WjCell;

@property (retain, nonatomic) IBOutlet PassengerCell *passengerCell;
@property (retain, nonatomic) IBOutlet LinkmanCell *linkCell;
@property (retain, nonatomic) IBOutlet JourneyCell *journeyCell;
@property (retain, nonatomic) IBOutlet FlightConditionCell *flightCell;
@end
