//
//  Passenger.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Passenger : NSObject

@property (nonatomic, retain) NSString * name;   // 姓名
@property (nonatomic, retain) NSString * certType;  // 证件类型
@property (nonatomic, retain) NSString * certNo;   // 证件号码
@property (nonatomic, retain) NSString * insuranceCode; // 保单号
@property (nonatomic, retain) NSString * etNo;  // 票号

@property (nonatomic, retain) NSString * ticketPrice;  // 票面价
@property (nonatomic, retain) NSString * constructionPrice;  // 机建费
@property (nonatomic, retain) NSString * bafPrice;  // 燃油
@property (nonatomic, retain) NSString * insurance;  // 保险

@property (nonatomic, retain) NSString * type;// 儿童或成人

@end
