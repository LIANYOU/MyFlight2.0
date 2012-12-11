//
//  searchFlightData.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-10.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFlightData : NSObject

@property (retain, nonatomic)  NSString *startPortName;
@property (retain, nonatomic)  NSString *endPortName;
@property (retain, nonatomic)  NSString *beginDate;
@property (retain, nonatomic)  NSString *endDate;


@property (retain, nonatomic)  NSString *temporaryLabel;
@property (retain, nonatomic)  NSString *airPort;
@property (retain, nonatomic)  NSString *palntType;
@property (retain, nonatomic)  NSString *beginTime;
@property (retain, nonatomic)  NSString *endTime;
@property (retain, nonatomic)  NSString *pay;
@property (retain, nonatomic)  NSString *discount;
@property (retain, nonatomic)  NSString *ticketCount;

@property (retain, nonatomic)  NSArray * cabinsArr;
@property (retain, nonatomic)  NSMutableArray * cabinNumberArr;
@property (retain, nonatomic) NSString * cabinNumber;

@end
