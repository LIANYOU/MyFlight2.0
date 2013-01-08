//
//  CancelOrdre.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-7.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface CancelOrdre : NSObject

@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSString * orderCode;
@property (nonatomic, retain) NSString * memberId; 
@property (nonatomic, retain) NSString * checkCode;  //订单校验code 联系人手机号
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * hwId;
@property (nonatomic, retain) NSString * edition;  // v1.0
@property (nonatomic, assign) id<ServiceDelegate> delegate;

-(id) initWithOrderId:(NSString *)orderId
         andOrderCode:(NSString *)orderCode
          andMemberId:(NSString *)memberId
         andCheckCode:(NSString *)checkCode
              andSign:(NSString *)sign
            andSource:(NSString *)source
              andHwId:(NSString *)hwId
           andEdition:(NSString *)edition
          andDelegate:(id<ServiceDelegate>)delegate;

-(void)delOrder;

@end
