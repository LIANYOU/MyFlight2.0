//
//  CouponsInfo.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/17/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

//优惠券信息 
@interface CouponsInfo : NSObject

@property(nonatomic,retain)NSString  *code; //优惠券编码
@property(nonatomic,retain)NSString  *name; //优惠券名字
@property(nonatomic,retain)NSString *price; //优惠券票面价格
@property(nonatomic,retain)NSString *dateStart; //有效起止日期
@property(nonatomic,retain)NSString *dateEnd; //有效截止日期

@end
