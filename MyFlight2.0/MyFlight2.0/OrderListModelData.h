//
//  OrderListModelData.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/6/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModelData : NSObject
@property(nonatomic,retain)NSString *orderId; //订单id
@property(nonatomic,retain)NSString *code; //订单号
@property(nonatomic,retain)NSString *totalMoney; //金额
@property(nonatomic,retain)NSString *createTime;
@property(nonatomic,retain)NSString *depAirportName; //出发机场
@property(nonatomic,retain)NSString *arrAirportName; //到达机场
@property(nonatomic,retain)NSString *orderState;
@property(nonatomic,retain)NSString *orderStateOfChinese;
@property(nonatomic,retain)NSString *paySts; //支付状态
@property(nonatomic,retain)NSString *payStsCH; //支付状态中文
@property(nonatomic,retain)NSString *type; //航班类型

@property(nonatomic,retain)NSString *checkCode; //非登陆用户手机号验证



@end
