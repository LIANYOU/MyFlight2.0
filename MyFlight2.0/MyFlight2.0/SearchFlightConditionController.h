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
#import "AppConfigure.h"
#import "AirPortData.h"

#pragma mark - 日历
#import "Date.h"
#import "ViewControllerDelegate.h"
#import "SelectCalendarController.h"
#import "MonthDayCell.h"
#import "AttentionFlight.h"
@class LookFlightConditionCell;

@interface SearchFlightConditionController : UIViewController<SVSegmentedControlDelegate,ChooseAirPortViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,ViewControllerDelegate,AttentionFlightDelegate>{
    SVSegmentedControl * mySegmentController;
    NSString * startAirPortCode;
    NSString * arrAirPortCode;
    UIView * selectView;      //查询view
    UIView * shade;         //遮罩
    UIView * myConditionListView;   //已关注view
    UITableView * myConditionListTableView;
    NSMutableData * myData;
    NSMutableData * myListData;
    
    UIImageView * btnImageView; //导航右键按钮图片
    UIView * rightsuperView; //导航右键view
    BOOL isAttention;   //是否关注
    
    NSMutableString * type;    //提醒类型
    NSMutableString * resultString; //查询结果
    
    AirPortData * myAirPortData;
    
    UIImageView * animationView;//查询无结果动画view
    
    
    Date * leaveDate;   //通过获取到的日期
    int todayCount;
    int selectDayCount;
    UIButton * animationBtn;//大按钮（有动画的按钮）
    
    UIScrollView * scrollview;  //关注列表的放在这个view上
    UILabel * remindLabel;
    UILabel * remindLabel1;
    
    
}


@property (retain, nonatomic) IBOutlet LookFlightConditionCell *lookCell;

@property (retain, nonatomic) NSMutableArray * lookFlightArr;


@property (nonatomic,retain)IBOutlet UILabel * flightTimeByNumber;

@property (retain, nonatomic) IBOutlet UILabel *startAirPort;
@property (retain, nonatomic) IBOutlet UILabel *endAirPort;
@property (retain, nonatomic) IBOutlet UILabel *time;

@property (retain, nonatomic) IBOutlet UITextField *flightNumber;

@property (retain, nonatomic) IBOutlet UIView *selectedByDate;

@property (retain, nonatomic) IBOutlet UIView *selectedByAirPort;

@property (retain,nonatomic)IBOutlet UILabel * whichDateLabel;  //今天、明天或者后天
@property (retain,nonatomic)IBOutlet UILabel * whichDataLabelAirPort;
@property (nonatomic,retain)IBOutlet UILabel * listCellState;   //关注列表的状态
@property(nonatomic,retain)AirPortData * DetailDepAirPortData;
@property(nonatomic,retain)AirPortData * DetailArrAirPortData;


- (IBAction)selectedInquireType:(UISegmentedControl *)sender;

-(void)attentionTapEvent;

- (IBAction)chooseDateBtnClick:(id)sender;

- (IBAction)searchFligth:(id)sender;


- (IBAction)chooseStartAirPort:(id)sender;

- (IBAction)chooseEndAirPort:(id)sender;

@end
