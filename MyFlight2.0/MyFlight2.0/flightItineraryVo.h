//
//  flightItineraryVo.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface flightItineraryVo : NSObject

@property(nonatomic,retain)NSString *deliveryType; //配送方式 0:无需配送(低碳出行) 1：快递2:挂号信  3:机场自取

@property(nonatomic,retain)NSString *address; //收信地址 为邮寄配送，必填

@property(nonatomic,retain)NSString *city;  //城市 为邮寄配送，必填


@property(nonatomic,retain)NSString *mobile; //手机号码

@property(nonatomic,retain)NSString *postCode; //邮政编码 为邮寄配送，必填
@property(nonatomic,retain)NSString *catchUser; //收信人

@property(nonatomic,retain)NSString *isPromptMailCost; //预订成功后，是否提示邮递费用 默认为空（指的是旧版本）,以后开发的版本必须设置为0


- (id) initWithdeliveryType:(NSString *) deliveryType city:(NSString *)city address:(NSString *) address mobile:(NSString *) mobile postCode:(NSString *)postCode catchUser:(NSString *) catchUser;


@end
