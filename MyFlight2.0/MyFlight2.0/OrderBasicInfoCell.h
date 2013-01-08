//
//  OrderBasicInfo.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderBasicInfoCell: NSObject

@property (nonatomic, retain) NSString * code;        // 订单号
@property (nonatomic, retain) NSString * createDate;  // 订单日期
@property (nonatomic, retain) NSString * sts; // 订单状态
@property (nonatomic, retain) NSString * paySts;// 支付状态
@property (nonatomic, retain) NSString * totalMoney;// 订单总额

@end
