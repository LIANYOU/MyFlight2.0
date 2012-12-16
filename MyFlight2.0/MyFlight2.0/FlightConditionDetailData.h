//
//  FlightConditionDetailData.h
//  MyFlight2.0
//
//  Created by apple on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightConditionDetailData : NSObject
{
   // NSDictionary * dic;
}
-(id)initWithDictionary:(NSDictionary *)dic;
@property(nonatomic,retain)NSString * arrAirport;       //目的地城市名（汉字）	带航站楼楼
@property(nonatomic,retain)NSString * arrTime;      //航班预计到达时间，值为false代表空值
@property(nonatomic,retain)NSString * deptAirport;//出发地城市名（汉字）	带航站楼
@property(nonatomic,retain)NSString * deptDate;//航班预计起飞时间，值为false代表空值
@property(nonatomic,retain)NSString * deptTime;//航班预计起飞时间，值为false代表空值
@property(nonatomic,retain)NSString * expectedArrTime;//航班预计到达时间，值为false代表空值
@property(nonatomic,retain)NSString * expectedDeptTime;//航班预计起飞时间，值为false代表空值
@property(nonatomic,retain)NSString * flightArrcode;//目的机场三字码
@property(nonatomic,retain)NSString * flightCompany;//航空公司
@property(nonatomic,retain)NSString * flightDepcode;//出发机场三字码
@property(nonatomic,retain)NSString * flightHTerminal;//登机楼，值为false代表空值
@property(nonatomic,retain)NSString * flightNum;//航班号
@property(nonatomic,retain)NSString * flightState;//航班当前状态
@property(nonatomic,retain)NSString * flightTerminal;//接机楼，值为false代表空值
@property(nonatomic,retain)NSString * realArrTime;//航班到达时间
@property(nonatomic,retain)NSString * realDeptTime;//航班起飞时间



@end
