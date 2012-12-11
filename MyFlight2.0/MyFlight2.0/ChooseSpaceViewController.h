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

@interface ChooseSpaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *showTableView;

@property (retain, nonatomic) IBOutlet ChooseSpaceCell *spaceCell;

@property(nonatomic,retain) NSArray * spaceNameArr;  // 存放cell的仓明（超值经济舱，经济舱）

@property(nonatomic,retain) SearchFlightData * searchFlight;

@property(nonatomic,retain) NSMutableArray * changeInfoArr; // 存放每一行退改签的数据

@property(nonatomic,retain) NSMutableArray * indexPath;    // 存放插入的退改签的cell 的数据

@property (retain, nonatomic) IBOutlet UILabel *flightCode;
@property (retain, nonatomic) IBOutlet UILabel *airPort;
@property (retain, nonatomic) IBOutlet UILabel *palntType;
@property (retain, nonatomic) IBOutlet UILabel *beginTime;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *scheduleDate;
- (void)changeFlightInfo:(UIButton *)sender;

@end
