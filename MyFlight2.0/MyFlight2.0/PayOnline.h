//
//  PayOnline.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-5.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface PayOnline : NSObject

@property (nonatomic,retain) NSString * prodType ;  // 机票 01
@property (nonatomic,retain) NSString * payType ;  //02 umpay
@property (nonatomic,retain) NSString * orderCode ;//订单号
@property (nonatomic,retain) NSString * memberId ;//用户id(新华旅行网的用户id)
@property (nonatomic,retain) NSString * actualPay ;//订单应付金额
@property (nonatomic,retain) NSString * source ;//android或iphone 可带小版本号
@property (nonatomic,retain) NSString * hwId ;//硬件id
@property (nonatomic,retain) NSString * serviceCode ;//MY机票客户端为01
@property (nonatomic,retain) NSString * captcha ;//优惠券
@property (nonatomic, assign) id<ServiceDelegate> delegate;

-(id) initWithProdType:(NSString *)prodType
               payType:(NSString *)payType
             orderCode:(NSString *)orderCode
              memberId:(NSString *)memberId
             actualPay:(NSString *)actualPay
                source:(NSString *)source
                  hwId:(NSString *)hwId
           serviceCode:(NSString *)serviceCode
               captcha:(NSString *)captcha
           andDelegate:(id<ServiceDelegate>)delegate;

-(void) getBackInfo;
@end
