//
//  ChooseSpaceViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseSpaceCell.h"
#import "SearchFlightData.h"
#import "searchCabin.h"
#import "MBProgressHUD.h"

@class BigCell;
@class NewChooseSpaceCell;
@interface ChooseSpaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
    SearchFlightData * data;
    NSDictionary * dic;
}


@property (retain, nonatomic) IBOutlet UIButton *lookButton;


@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet ChooseSpaceCell *spaceCell;

@property (retain, nonatomic) NSDictionary * lookFlightArr;  // 接收关注航班返回的数据
@property (retain, nonatomic) NSArray * lookReceive; // 获取用户已经关注的航班的数目

@property(nonatomic,retain) NSArray * spaceNameArr;  // 存放cell的仓明（超值经济舱，经济舱）
@property(nonatomic,assign) int indexFlag;
@property (retain, nonatomic) IBOutlet NewChooseSpaceCell *newCell;

@property(nonatomic,retain) SearchFlightData * searchFlight;
@property(nonatomic,retain) SearchFlightData * searchBackFlight;

@property(nonatomic,retain) searchCabin * searchCab;

@property(nonatomic,retain) NSMutableArray * changeInfoArr; // 存放每一行退改签的数据
@property(nonatomic,retain) NSMutableArray * payArr;  // 保存成人价格的数组
@property(nonatomic,retain) NSMutableArray * childPayArr;  // 保存儿童价格的数组

@property(nonatomic,retain) NSMutableArray * indexPath;    // 存放插入的退改签的cell 的数据

@property(nonatomic,assign) int flag ; // 记录单程还是往返

@property(nonatomic,retain) NSMutableArray * dateArr;

@property (retain, nonatomic) IBOutlet BigCell *bigCell;

@property(nonatomic,retain) NSString * goPay;  //成人去程价格
@property(nonatomic,retain) NSString * goCabin;
@property(nonatomic,retain) NSString * childGoPay;  // 儿童去成价格

@property(nonatomic,retain) NSMutableArray *tempArr;
@property(nonatomic,retain) NSString *firstCellText;
@property(nonatomic,retain) NSMutableArray *indexArr;

@property(nonatomic,retain) NSString * goBackDate;

@property (retain, nonatomic) IBOutlet UIView *headView;

@property (retain, nonatomic) IBOutlet UILabel *flightCode;
@property (retain, nonatomic) IBOutlet UILabel *airPort;
@property (retain, nonatomic) IBOutlet UILabel *palntType;
@property (retain, nonatomic) IBOutlet UILabel *beginTime;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *scheduleDate;
@property (retain, nonatomic) IBOutlet UILabel *beginAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *endAirPortName;

- (void)changeFlightInfo:(UIButton *)sender;


@property (retain, nonatomic) IBOutlet UIButton *lookFlightBtn;

- (IBAction)lookFlight:(UIButton *)sender;

@end
