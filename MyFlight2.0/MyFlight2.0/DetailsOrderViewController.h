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
#import "DiscountGoldInfo.h"
@class PassengerCell;
@class LinkmanCell;
@class JourneyCell;
@class FlightConditionCell;

@interface DetailsOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>

{
    
    
    
}

@property (nonatomic, retain) NSMutableArray * fristArr;
@property (nonatomic, retain) NSMutableArray * secArr;


@property (retain, nonatomic) NSArray * discountArr;  // 接受传递过来的优惠信息

@property (retain, nonatomic) OrderBasicInfoWJ * order;
@property (retain, nonatomic) FlightConditionWj * flight;
@property (retain, nonatomic) InFlightConditionWJ * inFlight;
@property (retain, nonatomic) PostInfo * post;
@property (retain, nonatomic) LinkPersonInfo * person;
@property (retain, nonatomic) DiscountGoldInfo * discountInfo;

@property (retain, nonatomic) NSArray * personArray;  // 保存乘机人的信息

@property (retain, nonatomic) IBOutlet UIView *one;
@property (retain, nonatomic) IBOutlet UIView *two;
@property (retain, nonatomic) IBOutlet UIView *three;
@property (retain, nonatomic) IBOutlet UIView *four;
@property (retain, nonatomic) IBOutlet UIView *five;


@property (retain, nonatomic) IBOutlet UIView *cellView;

// ********  展示成人和儿童的价格

@property (retain, nonatomic) IBOutlet UILabel *PerStanderPrice;
@property (retain, nonatomic) IBOutlet UILabel *PersonConstructionFee;
@property (retain, nonatomic) IBOutlet UILabel *personAdultBaf;
@property (retain, nonatomic) IBOutlet UILabel *personMuber;
@property (retain, nonatomic) IBOutlet UILabel *Personinsure;


@property (retain, nonatomic) IBOutlet UILabel *smallPerStanderPrice;
@property (retain, nonatomic) IBOutlet UILabel *smallPersonConstructionFee;
@property (retain, nonatomic) IBOutlet UILabel *smallpersonAdultBaf;
@property (retain, nonatomic) IBOutlet UILabel *smallpersonMuber;
@property (retain, nonatomic) IBOutlet UILabel *smallPersoninsure;

@property (retain, nonatomic) IBOutlet UILabel *childStanderPrice;
@property (retain, nonatomic) IBOutlet UILabel *childConstructionFee;
@property (retain, nonatomic) IBOutlet UILabel *childBaf;
@property (retain, nonatomic) IBOutlet UILabel *childMunber;
@property (retain, nonatomic) IBOutlet UILabel *childInsure;

@property (retain, nonatomic) NSString * controllerFlag;  // 判断是哪一个controller推进的

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

- (IBAction)goPay:(id)sender;
- (IBAction)cancelOrder:(id)sender;
@end
