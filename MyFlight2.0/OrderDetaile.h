//
//  OrderDetaile.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface OrderDetaile : NSObject<ServiceDelegate>

@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * checkCode; //订单校验code可为 手机号 或者票号.非登录用户，通过本地订单查询
@property (nonatomic, assign) id<ServiceDelegate> delegate;
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * hwId;
@property (nonatomic, retain) NSString * edition;



-(id) initWithOrderId:(NSString * )orderId
          andMemberId:(NSString *)memberId
         andCheckCode:(NSString *)checkCode
              sndSign:(NSString *)sign
            sndSource:(NSString *)source
              andHwId:(NSString *)hwId
           andEdition:(NSString *)edition
          andDelegate:(id<ServiceDelegate>) delegate;


-(void) getOrderDetailInfo;

-(void) analysisData:(NSDictionary *)dic;

@end
