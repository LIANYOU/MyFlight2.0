//
//  ShowFligthConditionController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-8.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFlightConditionCell.h"
#import "SearchFlightCondition.h"
#import "EGORefreshTableHeaderView.h"
#import "AirPortData.h"
@interface ShowFligthConditionController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    UIColor * _myBlueColor;
    UIColor * _myRedColor;
    UIColor * _myGreenColor;
    
    NSString * _deptAirPortCode;
    NSString * _arrAirPortCode;
    NSMutableArray * tempDataArray; //排序用
    
    UIButton * sortBtnByTime;
    UIButton * sortBtnByState;
    
}
@property (retain, nonatomic) IBOutlet UIView *HeadView;
@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet SearchFlightConditionCell *flightConditionCell;

@property (nonatomic,retain) NSMutableArray * dateArr;  // 存放搜索返回的所有数据;

@property (nonatomic,retain) SearchFlightCondition * searchCondition;


@property(nonatomic,retain) NSString * deptAirPortCode;
@property(nonatomic,retain) NSString * arrAirPortCode;

@property(nonatomic,retain)AirPortData * DetailArrAirPortData;
@property(nonatomic,retain)AirPortData * DetailDepAirPortData;
@end
