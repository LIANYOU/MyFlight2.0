//
//  SearchFlightConditionCell.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-9.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SearchFlightConditionCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *flightCompany;    // 航空公司
@property (retain, nonatomic) IBOutlet UILabel *flightNum;        // 飞机编号
@property (retain, nonatomic) IBOutlet UILabel *deptAirport;      // 起飞机场
@property (retain, nonatomic) IBOutlet UILabel *arrAirport;       // 到达机场
@property (retain, nonatomic) IBOutlet UILabel *expectedDeptTime; // 预期起飞时间
@property (retain, nonatomic) IBOutlet UILabel *expectedArrTime;  // 预期到达时间
@property (retain, nonatomic) IBOutlet UILabel *deptTime;         // 实际起飞时间
@property (retain, nonatomic) IBOutlet UILabel *arrTime;          // 实际到达时间
@property (retain, nonatomic) IBOutlet UILabel *flightState;      // 航班状态

@end
