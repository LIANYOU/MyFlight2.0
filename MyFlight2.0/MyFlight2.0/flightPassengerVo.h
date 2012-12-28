//
//  flightPassengerVo.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
//乘客信息
@interface flightPassengerVo : NSObject

@property(nonatomic,retain)NSString *flightPassengerId; //常用乘机人Id
@property(nonatomic,retain)NSString *certNo; //证件号码 
@property(nonatomic,retain)NSString *certType; //证件类型:0身份证/1护照/2军人证/3港澳通行证/4回乡证/5台胞证/6 国际海员证 /7外国人永久居留证/9 其他
@property(nonatomic,retain)NSString *name; //乘客姓名

@property(nonatomic,retain)NSString *type; //乘客类型 ：02儿童 01成人

- (id) initWithType:(NSString *) type certType:(NSString *)certType name:(NSString *)name flightPassengerId:(NSString *) flightPassengerId certNo:(NSString *) certNo;


@end
