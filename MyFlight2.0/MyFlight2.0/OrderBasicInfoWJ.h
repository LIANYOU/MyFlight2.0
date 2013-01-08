//
//  OrderBasicInfoWJ.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderBasicInfoWJ : NSObject

@property (nonatomic, retain) NSString * code;  // 订单号
@property (nonatomic, retain) NSString * createDate; // 创建日期
@property (nonatomic, retain) NSString * stsCh;   // 订单状态
@property (nonatomic, retain) NSString * payStsCh;// 支付状态
@property (nonatomic, retain) NSString * totalMoney;// 总额
@property (nonatomic, retain) NSString * orderId;// 订单ID

@property (nonatomic, retain) NSString * actualMoney;// 总额

@property (nonatomic, retain) NSString * flyType; // 单程，往返
@end
