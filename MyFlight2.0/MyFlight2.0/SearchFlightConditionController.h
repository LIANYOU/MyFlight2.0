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
@interface SearchFlightConditionController : UIViewController<SVSegmentedControlDelegate,ChooseAirPortViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
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
}
@property (nonatomic,retain)IBOutlet UILabel * flightTimeByNumber;

@property (retain, nonatomic) IBOutlet UILabel *startAirPort;
@property (retain, nonatomic) IBOutlet UILabel *endAirPort;
@property (retain, nonatomic) IBOutlet UILabel *time;

@property (retain, nonatomic) IBOutlet UITextField *flightNumber;

@property (retain, nonatomic) IBOutlet UIView *selectedByDate;

@property (retain, nonatomic) IBOutlet UIView *selectedByAirPort;
- (IBAction)selectedInquireType:(UISegmentedControl *)sender;

- (IBAction)searchFligth:(id)sender;


- (IBAction)chooseStartAirPort:(id)sender;

- (IBAction)chooseEndAirPort:(id)sender;

@end
