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
    if ([str isEqualToString:@"0"]) {
        return @"已售空";
    }
    if ([str isEqualToString:@"A"]) {
        return @">9张";
    }
    else
        return [NSString stringWithFormat:@"%@张",str];
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
+(NSString *)transitionDiscount:(NSString *)str andCanbinCode:(NSString *)code andCabinName:(NSString *)name
{
    
    if ([name isEqualToString:@"头等舱"]) {
        return @"头等";
    }
    if ([name isEqualToString:@"公务舱"]) {
        return @"公务";
    }
   
    float number = [str floatValue];
    
    if (number>=10.0) {
        return [NSString stringWithFormat:@"全价/%@",code];
    }
    else{
        return [NSString stringWithFormat:@"%@折/%@",str,code];
    }

}

+(NSString *)getNextDay:(NSString *)todayStr
{
    NSArray * timeArr = [todayStr componentsSeparatedByString:@"-"];
    
    NSString * month = nil;
    NSString * year = nil;
    NSString * day = nil;
    
    int month_ = 0;
    int year_ = 0;
    int day_ = 0;
    
    year = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:0]];
    month = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:1]];
    day = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:2]];
    
    month_ = [month intValue];
    year_ = [year intValue];
    day_ = [day intValue];
    
    
    if (month_ == 01 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d%d%d",year_,2,1];
    }
    if ((month_ == 02 && day_ == 28) || (month_ == 02 && day_ == 29)) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,3,1];
    }
    if (month_ == 03 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,4,1];
    }
    if (month_ == 04 && day_ == 30 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,5,1];
    }
    if (month_ == 05 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,6,1];
    }
    if (month_ == 06 && day_ == 30 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,7,1];
    }
    if (month_ == 07 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,8,1];
    }
    if (month_ == 8 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,9,1];
    }
    if (month_ == 9 && day_ == 30 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,10,1];
    }
    if (month_ == 10 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,11,1];
    }
    if (month_ == 11 && day_ == 30 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_,12,1];
    }
    if (month_ == 12 && day_ == 31 ) {
        todayStr = [NSString stringWithFormat:@"%d-%d-%d",year_+1,1,1];
    }
    
    else{
        
        todayStr = [NSString stringWithFormat:@"%@-%@-%02d",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1],[[timeArr objectAtIndex:2]intValue]+1];
    }
    
    return todayStr;
}


+(NSString *)weekYear:(NSString *)year moth:(NSString *)moth day:(NSString *)day
{
    int isleap(int);
    int ans=0;
    switch([moth intValue])
    {
        case 1:ans=0;break;
        case 2:ans=31;break;
        case 3:ans=59;break;
        case 4:ans=90;break;
        case 5:ans=120;break;
        case 6:ans=151;break;
        case 7:ans=181;break;
        case 8:ans=212;break;
        case 9:ans=243;break;
        case 10:ans=273;break;
        case 11:ans=304;break;
        case 12:ans=334;break;
    }
    ans+=[day intValue];
    if((([year intValue]%100!=0&&[year intValue]%4==0)||[year intValue]%400==0)&&[moth intValue]>2)
        ans++;
    
    NSString * str = nil;
    switch (ans%7+1) {
        case 1:
            str = @"星期一";
            break;
        case 2:
            str = @"星期二";
            break;

        case 3:
            str = @"星期三";
            break;

        case 4:
            str = @"星期四";
            break;

        case 5:
            str = @"星期五";
            break;

        case 6:
            str = @"星期六";
            break;

        case 7:
            str = @"星期七";
            break;

        default:
            break;
    }
    
    
   
    return str;

}
@end
