//
//  FlightBookingBusinessHelper.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "FlightBookingBusinessHelper.h"
#import "AppConfigure.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation FlightBookingBusinessHelper

+ (void) flightBookingWithGoflight:(NSDictionary *) infoDic bookingGoFlightVo:(bookingGoFlightVo *)  bookingGoFlightVo bookingReturnFlightVo:(bookingReturnFlightVo *) bookingReturnFlightVo flightContactVo:(flightContactVo *) flightContactVo flightItineraryVo:(flightItineraryVo *) flightItineraryVo flightPassengerVo:(flightPassengerVo *)flightPassengerVo payVo:(payVo *)payVo delegate:(id<ServiceDelegate>) delegate {
    
    
    NSString *memberId =nil;
    
    NSString *sign = nil;
    
    NSString *token = nil;

    
    
    NSString *prodType = [infoDic objectForKey:KEY_FlightBook_prodType];
    
    NSString *rmk =[infoDic objectForKey:KEY_FlightBook_rmk];
    
    NSString *source = SOURCE_VALUE;
    
    NSString *consumptionType =[infoDic objectForKey:KEY_FlightBook_consumptionType];
    
    NSString *assistBook = [infoDic objectForKey:KEY_FlightBook_assistBook];
    
    NSString *goInsuranceNum = [infoDic objectForKey:KEY_FlightBook_goInsuranceNum];
    
    NSString *returnInsuranceNum =[infoDic objectForKey:KEY_FlightBook_returnInsuranceNum];
    
    
    
    NSString *string = [NSString stringWithFormat:@"booking%@FlightVo.aircraftType",@"Go"];
    
    int i = 0;
    NSString *str = [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.name",i];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    NSString *goInsuranceNum =[]
    
    if (Default_IsUserLogin_Value) {
        
        CCLog(@"机票订票 用户是否登录%d",Default_IsUserLogin_Value);
        
        memberId = Default_UserMemberId_Value;
        token = Default_Token_Value;
        
        NSString *string =[[NSString alloc] initWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,token];
        sign = GET_SIGN(string);
        [string release];
    } 
    
    

NSString *publicParm = PUBLIC_Parameter;


__block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];

__block NSString *message = nil;





__block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:nil]];


[formRequst setCompletionBlock:^{
    
    NSString *data = [formRequst responseString];
    
    //        CCLog(@"网络返回的数据为：%@",data);
    
    NSError *error = nil;
    
    
    NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
    
    if (!error) {
        
        CCLog(@"json解析格式正确");
        
        message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
        NSLog(@"服务器返回的信息为：%@",message);
        
        if ([message length]==0) {
            
            //                NSLog(@"成功登陆后返回的数据：%@",data);
            
            
            
            
            
            [delegate requestDidFinishedWithRightMessage:messageDic];
            
        } else{
            
            //message 长度不为0 有错误信息
            [messageDic setObject:message forKey:KEY_message];
            
            
            [delegate requestDidFinishedWithFalseMessage:messageDic];
            
        }
        
        
        
    } else{
        NSLog(@"解析有错误");
        
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        [delegate requestDidFinishedWithFalseMessage:messageDic];
        
        return ;
        
    }
    
    
    
}];

[formRequst setFailedBlock:^{
    
    
    
    
    [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
    
    [delegate requestDidFailed:messageDic];
    
    
    
}];




[formRequst startAsynchronous];













}


@end
