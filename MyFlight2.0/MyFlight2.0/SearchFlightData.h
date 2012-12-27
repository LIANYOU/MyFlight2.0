//
//  searchFlightData.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-10.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFlightData : NSObject

@property (retain, nonatomic)  NSString *startPortName;      // 出发机场  北京首都
@property (retain, nonatomic)  NSString *endPortName;        // 到达机场  上海虹桥
@property (retain, nonatomic)  NSString *backStartPortName;  // 返程出发机场  上海虹桥
@property (retain, nonatomic)  NSString *backendPortName;    // 返程到达机场 北京首都
@property (retain, nonatomic)  NSString *beginDate;          // 出发日期 2012-12-12
@property (retain, nonatomic)  NSString *backDate;           // 返程日期 2012-12-13

@property (retain, nonatomic)  NSString * startPortThreeCode; // 出发机场三字码
@property (retain, nonatomic)  NSString * endPortThreeCode;   // 到达机场三字码
@property (retain, nonatomic)  NSString * backStartPortThreeCode; // 返程出发机场三字码
@property (retain, nonatomic)  NSString * backEndPortThreeCode;   // 返程到达机场三字码

@property (retain, nonatomic)  NSString *temporaryLabel;  // code参数    如:5137
@property (retain, nonatomic)  NSString *airPort;         // 机场二字码   如:HU  (海航)
@property (retain, nonatomic)  NSString *palntType;       // 机型         如:747机型
@property (retain, nonatomic)  NSString *beginTime;       // 飞机起飞的时间 08:00 
@property (retain, nonatomic)  NSString *endTime;         // 飞机到达的时间 12:00
@property (assign, nonatomic)  int pay;             // 需支付的金额
@property (retain, nonatomic)  NSString *discount;        // 机票折扣
@property (retain, nonatomic)  NSString *ticketCount;     // 机票剩余数

@property (retain, nonatomic)  NSArray * cabinsArr;       // 存放某航班所有舱位的信息
@property (retain, nonatomic)  NSMutableArray * cabinNumberArr;   // 存放某一航班的所有cabinNumber舱位的信息
@property (retain, nonatomic)  NSString * cabinNumber;   // (格式 “经济舱 Z” );

@property (retain, nonatomic)  NSString * adultBaf;      // 成人燃油费
@property (retain, nonatomic)  NSString * childBaf;      // 儿童燃油费
@property (retain, nonatomic)  NSString * constructionFee;// 成人机建费
@property (retain, nonatomic)  NSString * childConstructionFee; // 儿童机建费
@property (retain, nonatomic)  NSString * personPrice;      // 成人票面价（最低价）
@property (retain, nonatomic)  NSString * childPrice;      // 儿童票面价（儿童最低价）
@property (retain, nonatomic)  NSString * standerPrice;      // 票面价

@property (retain, nonatomic)  NSString * goOrBackFlag;   // 去成或返程的时间标记
+(SearchFlightData *)defaultSearchFlightData;
@end
