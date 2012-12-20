//
//  ShowSelectedResultViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "SearchAirPort.h"
#import "SelectResultCell.h"
#import "ChooseSpaceViewController.h"
#import "SearchFlightData.h"
#import "MBProgressHUD.h"
@class OneWayCheckViewController;


#import "SearchFlightData.h"
@interface ShowSelectedResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    
    NSString * navigationTitle;
    
    MBProgressHUD * HUD;
    IBOutlet UIButton *salesText;
    
    IBOutlet UIButton *nowDateBtn;
    IBOutlet UIButton *theDayAfterBtn;
    IBOutlet UIButton *theDayBeforeBtn;
    IBOutlet UIButton *cancelSalesText;
    
    IBOutlet UIButton *sortBtn;
    IBOutlet UILabel *backImagelabel;
    IBOutlet UIButton *siftBtn;
    
    NSDictionary * dicCode;  // 用来接收存在plist文件中的机场二字码
    
    SearchFlightData * data;
}
@property (retain, nonatomic) IBOutlet UITableView *showResultTableView;
@property (retain, nonatomic) SearchAirPort * airPort;
@property (retain, nonatomic) NSArray * dateArr;  // 接收返回的数据
@property (retain, nonatomic) NSMutableArray * searchFlightDateArr;      // 存放单程结果
@property (retain, nonatomic) NSMutableArray * searchBackFlightDateArr;  // 存放返程结果
 

@property (retain, nonatomic) OneWayCheckViewController * one;  // 次controller的前身是哪一个controller
@property (retain, nonatomic) ChooseSpaceViewController * write;
@property (nonatomic,assign) int netFlag;  // 判断是否需要联网的标记位
@property (nonatomic,assign) int indexFlag; // 

@property (nonatomic,retain) NSMutableArray * indexArr;
@property (nonatomic,retain) NSMutableArray * twoCodeArr;  // 存放查找到的机场列表里边的二字码，用于按照航空公司进行筛选
@property (nonatomic,retain) NSMutableArray * tempTwoCodeArr;

@property (retain, nonatomic) IBOutlet SelectResultCell *showCell;



@property (retain, nonatomic) NSString * startPort;  // 传值
@property (retain, nonatomic) NSString * endPort;
@property (retain, nonatomic) NSString * startThreeCode;
@property (retain, nonatomic) NSString * endThreeCode;
@property (retain, nonatomic) NSString * startTime;
@property (retain, nonatomic) NSString * endTime;
@property (retain, nonatomic) NSString * startDate;
@property (retain, nonatomic) NSString * endDate;


@property (assign, nonatomic) int flag; // 记录前边选择的是单程还是往返


@property (retain, nonatomic) NSString * payMoney;  // 保存去程时候的金额和舱位
@property (retain, nonatomic) NSString * cabin;

- (IBAction)enterSales:(id)sender;        // 进入促销活动
- (IBAction)enterTheDayBefore:(id)sender; // 进入前一天的查询结果
- (IBAction)showCalendar:(id)sender;      // 显示日历，选择日期
- (IBAction)enterTheDayAfter:(id)sender;  //进入下一天的查询结果
- (IBAction)siftByAirPort:(UIButton *)sender;     // 按照航空公司进行筛选查询结果
- (IBAction)sortByDate:(UIButton *)sender;        // 对查询结果按时间进行排序


@end
