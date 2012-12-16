//
//  TransitionString.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-10.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TransitionString.h"

@implementation TransitionString

+(NSString *)transitionPalntType:(NSString *)str
{
    return [NSString stringWithFormat:@"%@机型",str];
}
+(NSString *)transitionTime:(NSString *)str
{
    if (str && [str length] > 0) {
		NSString *hourStr = [str substringToIndex:2];
		NSString *minuteStr = [str substringFromIndex:2];
		return [NSString stringWithFormat:@"%@:%@",hourStr,minuteStr];
	}
	return @"";
}
+(NSString *)transitionPay:(NSString *)str
{
    return [NSString stringWithFormat:@"Y %@",str];
}
+(NSString *)transitionSeatNum:(NSString *)str
{
    if ([str isEqualToString:@"A"]) {
        return @"大于9张";
    }
    else
        return [NSString stringWithFormat:@"剩余%@张",str];
}
+(NSString *)transitionDiscount:(NSString *)str
{
    if ([str isEqualToString:@"10.0"]) {
        return @"全价";
    }
    else{
        return [NSString stringWithFormat:@"%@折/Y",str];
    }
}
+(NSString *)transitionDiscount:(NSString *)str andCanbinCode:(NSString *)code
{
   
    float number = [str floatValue];
    
    if (number>=10.0) {
        return @"全价";
    }
    else{
        return [NSString stringWithFormat:@"%@折/%@",str,code];
    }

}
@end
