//
//  SpecialAppointmentData.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/17/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialAppointmentData : NSObject

@property(nonatomic,retain)NSString *DepartureAirport; //出发机场
@property(nonatomic,retain)NSString *arriveAirport; //到达机场
@property(nonatomic,retain)NSString *dateStart; //出发时间
@property(nonatomic,retain)NSString *dateEnd; //最晚时间
@property(nonatomic,retain)NSString *discount; //最高折扣
@property(nonatomic,retain)NSString *mobile; //手机号 用户接收特价预约通知



@end
