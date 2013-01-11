//
//  MyCheapCouponHelper.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/2/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface MyCheapCouponHelper : NSObject<ServiceDelegate>

//获取优惠券信息 
+ (BOOL) getCouponInfoListWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;

//激活优惠券接口

+ (BOOL) makeCouponActiveWithMemberId:(NSString *) memberId captcha:(NSString *) captcha andDlegate:(id<ServiceDelegate>) delegate;



@end
