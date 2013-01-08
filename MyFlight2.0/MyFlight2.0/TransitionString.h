//
//  TransitionString.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-10.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionString : NSObject

+(NSString *)transitionPalntType:(NSString *)str;  // 转换机型的字符串
+(NSString *)transitionTime:(NSString *)str;       // 转换时间格式
+(NSString *)transitionPay:(NSString *)str;        // 转换价格
+(NSString *)transitionSeatNum:(NSString *)str;
+(NSString *)transitionDiscount:(NSString *)str;
+(NSString *)transitionDiscount:(NSString *)str andCanbinCode:(NSString *)code andCabinName:(NSString *)name;



+(NSString *)getNextDay:(NSString *)todayStr;
@end
