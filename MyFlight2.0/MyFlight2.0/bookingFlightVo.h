//
//  bookingFlightVo.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface bookingFlightVo : NSObject

@property(nonatomic,retain)NSString *aircraftType; //机型

@property(nonatomic,retain)NSString *airlineCompanyCode; //航空公司

@property(nonatomic,retain)NSString *arrivalAirportCode; //到达机场code

@property(nonatomic,retain)NSString *arrivalDateStr; //到达日期（2010-12-20）

@property(nonatomic,retain)NSString *arrivalTerminal; //到达机场航站   可不填

@property(nonatomic,retain)NSString *arrivalTimeStr; //到达时间（11:35）

@property(nonatomic,retain)NSString *cabinCode;  //舱位编码

@property(nonatomic,retain)NSString *departureAirportCode; //出发机场code

@property(nonatomic,retain)NSString *departureDateStr; //起飞日期（2010-12-20）

@property(nonatomic,retain)NSString *departureTerminal; //出发机场航站  可不填

@property(nonatomic,retain)NSString *departureTimeStr; //起飞时间

@property(nonatomic,retain)NSString *flightNo; //航班号

@property(nonatomic,retain)NSString *flightType; //1 单程 2 返程 3 联程

@property(nonatomic,retain)NSString *orderType; //订单类型0：订单 1：改签单 2议价单

@property(nonatomic,retain)NSString *prodType; //航班类型 0,普通，1议价 2团购7三折申请4公务机5官网6超值

@property(nonatomic,retain)NSString *rmk; //备注      可不填

@property(nonatomic,retain)NSString *ticketType; //机票类型 0：普通票；1：团购票2:议价票  目前填0即可

@property(nonatomic,retain)NSString *flightOrgin; //返程航班政策来源 B2B 、B2C、 HU、 PGS


@end
