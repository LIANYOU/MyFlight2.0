//
//  FlightConditionWj.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightConditionWj : NSObject

@property (nonatomic, retain) NSString * depAirPortCN; // 出发机场名称
@property (nonatomic, retain) NSString * arrAirportCN; // 到达机场名称
@property (nonatomic, retain) NSString * airlineCompany; // 航空公司名称
@property (nonatomic, retain) NSString * airlineCompanyCode; // 航空公司代码
@property (nonatomic, retain) NSString * aircraftType; // 机型
@property (nonatomic, retain) NSString * flightNo; // 航班号
@property (nonatomic, retain) NSString * cabinCode; // 舱位编码
@property (nonatomic, retain) NSString * cabinCN; // 舱位名称
@property (nonatomic, retain) NSString * departureDate; // 航班日期
@property (nonatomic, retain) NSString * departureTime; // 起飞时间
@property (nonatomic, retain) NSString * arrivalTime; // 到达时间
@property (nonatomic, retain) NSString * cabinRule; // 舱位规则
@end
