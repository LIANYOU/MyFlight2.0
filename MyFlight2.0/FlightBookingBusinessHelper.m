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
#import "flightPassengerVo.h"



@implementation FlightBookingBusinessHelper

+ (void) flightBookingWithGoflight:(NSDictionary *) infoDic
                 bookingGoFlightVo:(bookingGoFlightVo *)bookingGoFlightVo
             bookingReturnFlightVo:(bookingReturnFlightVo *)bookingReturnFlightVo
                   flightContactVo:(flightContactVo *)flightContactVo
                 flightItineraryVo:(flightItineraryVo *) flightItineraryVo
                 flightPassengerVo:(NSMutableArray *)flightPassengerVoArray
                             payVo:(payVo *)payVo
                          delegate:(id<ServiceDelegate>) delegate  {
    
    
    NSString *memberId =nil;
    
    NSString *sign = nil;
    
    NSString *token = nil;
    
    
    
    
    if (Default_IsUserLogin_Value) {
        
        CCLog(@"机票订票 用户是否登录%d",Default_IsUserLogin_Value);
        
        memberId = Default_UserMemberId_Value;
        token = Default_Token_Value;
        
        NSString *string =[[NSString alloc] initWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,token];
        sign = GET_SIGN(string);
        [string release];
    }
    
    
    
    //    NSString *publicParm = PUBLIC_Parameter;
    
    //航班类型
    
    NSString *prodType = [infoDic objectForKey:KEY_FlightBook_prodType];
    
    NSString *rmk =[infoDic objectForKey:KEY_FlightBook_rmk];
    
    NSString *source = SOURCE_VALUE;
    
    NSDate * datad=[NSDate date];
    
    NSLog(@"%f",datad.timeIntervalSince1970);
    
    
    NSString *timeSign = [NSString stringWithFormat:@"%f",datad.timeIntervalSince1970];
    
    //    NSString *consumptionType =[infoDic objectForKey:KEY_FlightBook_consumptionType];
    
    //    NSString *assistBook = [infoDic objectForKey:KEY_FlightBook_assistBook];
    
    
    
    
    //测试的时候为1
    NSString *passengerNum =[NSString stringWithFormat:@"%d",[flightPassengerVoArray count]];
    
    
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    
        
    if (Flight_DebugFlag) {
        
        
        
        
        
        CCLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^杂项打印参数");
        
        CCLog(@"预订机票界面 用户是否已经登陆 %d",Default_IsUserLogin_Value);
        
        CCLog(@"prodType = %@",prodType);
        
        CCLog(@"rmk =%@",rmk);
        CCLog(@"HWid = %@",HWID_VALUE);
        CCLog(@"sign = %@",sign);
        CCLog(@"memnerId = %@",memberId);
        CCLog(@"时间戳 %@",timeSign);
        
        
        
        
        
        CCLog(@"*******************去程机票信息**********************");
        
        CCLog(@"aircraftType = %@",bookingGoFlightVo.aircraftType);
        CCLog(@"airlineCompanyCode =%@",bookingGoFlightVo.airlineCompanyCode);
        CCLog(@"arrivalAirportCode = %@",bookingGoFlightVo.arrivalAirportCode);
        CCLog(@"arrivalDateStr = %@",bookingGoFlightVo.arrivalDateStr);
        CCLog(@"arrivalTerminal = %@",bookingGoFlightVo.arrivalTerminal);
        CCLog(@"arrivalTimeStr =%@",bookingGoFlightVo.arrivalTimeStr);
        CCLog(@"cabinCode =%@",bookingGoFlightVo.cabinCode);
        CCLog(@"departureAirportCode =%@",bookingGoFlightVo.departureAirportCode);
        CCLog(@"departureDateStr = %@",bookingGoFlightVo.departureDateStr);
        CCLog(@"departureTerminal =%@",bookingGoFlightVo.departureTerminal);
        CCLog(@"departureTimeStr =%@",bookingGoFlightVo.departureTimeStr);
        CCLog(@"flightNo = %@",bookingGoFlightVo.flightNo);
        CCLog(@"flightType = %@",bookingGoFlightVo.flightType);
        CCLog(@"orderType = %@",bookingGoFlightVo.orderType);
        CCLog(@"prodType = %@",bookingGoFlightVo.prodType);
        CCLog(@"rmk = %@",bookingGoFlightVo.rmk);
        CCLog(@"ticketType = %@",bookingGoFlightVo.ticketType);
        CCLog(@"flightOrgin = %@",bookingGoFlightVo.flightOrgin);
        
        
        
        CCLog(@"********************返程机票信息***************************");
        
        
        
        
        
        
        
        CCLog(@"**********************订单联系人信息**********************************");
        
        CCLog(@"name = %@",flightContactVo.name);
        CCLog(@"mobile = %@",flightContactVo.mobile);
        CCLog(@"email = %@",flightContactVo.email);
        
        
        CCLog(@"**********************行程单信息**********************************");
        
        
        CCLog(@"配送方式deliveryType = %@",flightItineraryVo.deliveryType);
        CCLog(@"address = %@",flightItineraryVo.address);
        CCLog(@"city = %@",flightItineraryVo.city);
        
        CCLog(@"mobile  =%@",flightItineraryVo.mobile);
        CCLog(@"postCode =%@",flightItineraryVo.postCode);
        CCLog(@"catchUser = %@",flightItineraryVo.catchUser);
        
        
        CCLog(@"isPromptMailCost = %@",flightItineraryVo.isPromptMailCost);
        
        
        
        
    }
    
    
    
    
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:FlightBook_URL]];
    
    
    [formRequst setPostValue:memberId forKey:KEY_Account_MemberId];
    [formRequst setPostValue:prodType forKey:KEY_FlightBook_prodType];
    [formRequst setPostValue:rmk forKey:KEY_FlightBook_rmk];
    [formRequst setPostValue:source forKey:KEY_source];
    [formRequst setPostValue:timeSign forKey:KEY_FlightBook_timeSign];
    
    //    [formRequst setPostValue:consumptionType forKey:KEY_FlightBook_consumptionType];
    //    [formRequst setPostValue:assistBook forKey:KEY_FlightBook_assistBook];
    
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    
    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    
    
    
    
    
    
    
    //乘客信息数目
    
    [formRequst setPostValue:passengerNum forKey:KEY_FlightBook_passengerNum];
    
    
    
    
    
    //去程信息
    [formRequst setPostValue:bookingGoFlightVo.aircraftType forKey:KEY_FlightBook_FlightVo__aircraftType_WithType(FlightBook_TarvelType_Go)];
    
    
    [formRequst setPostValue:bookingGoFlightVo.airlineCompanyCode forKey:KEY_FlightBook_FlightVo_airlineCompanyCode_WithType(FlightBook_TarvelType_Go)];
    [formRequst setPostValue:bookingGoFlightVo.arrivalAirportCode forKey:KEY_FlightBook_FlightVo_arrivalAirportCode_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue: bookingGoFlightVo.arrivalDateStr forKey:KEY_FlightBook_FlightVo_arrivalDateStr_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.arrivalTerminal forKey:KEY_FlightBook_FlightVo_arrivalTerminal_WithType(FlightBook_TarvelType_Go)];
    [formRequst setPostValue:bookingGoFlightVo.arrivalTimeStr forKey:KEY_FlightBook_FlightVo_arrivalTimeStr_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.cabinCode forKey:KEY_FlightBook_FlightVo_cabinCode_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.departureAirportCode forKey:KEY_FlightBook_FlightVo_departureAirportCode_WithType(FlightBook_TarvelType_Go)];
    [formRequst setPostValue:bookingGoFlightVo.departureDateStr forKey:KEY_FlightBook_FlightVo_departureDateStr_WithType(FlightBook_TarvelType_Go)];
    [formRequst setPostValue:bookingGoFlightVo.departureTimeStr forKey:KEY_FlightBook_FlightVo_departureTimeStr_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.flightNo forKey:KEY_FlightBook_FlightVo_flightNo_WithType(FlightBook_TarvelType_Go)];
    [formRequst setPostValue:bookingGoFlightVo.flightType forKey:KEY_FlightBook_FlightVo_flightType_WithType(FlightBook_TarvelType_Go)];
    
    
    [formRequst setPostValue:bookingGoFlightVo.orderType forKey: KEY_FlightBook_FlightVo_orderType_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.prodType forKey:KEY_FlightBook_FlightVo_prodType_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.rmk forKey:KEY_FlightBook_FlightVo_rmk_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.ticketType forKey:KEY_FlightBook_FlightVo_ticketType_WithType(FlightBook_TarvelType_Go)];
    
    [formRequst setPostValue:bookingGoFlightVo.flightOrgin forKey:KEY_FlightBook_FlightVo_flightOrgin_WithType(FlightBook_TarvelType_Go)];
    
    
    //返程信息
    
    [formRequst setPostValue:bookingReturnFlightVo.aircraftType forKey:KEY_FlightBook_FlightVo__aircraftType_WithType(FlightBook_TarvelType_Return)];
    
    
    [formRequst setPostValue:bookingReturnFlightVo.airlineCompanyCode forKey:KEY_FlightBook_FlightVo_airlineCompanyCode_WithType(FlightBook_TarvelType_Return)];
    [formRequst setPostValue:bookingReturnFlightVo.arrivalAirportCode forKey:KEY_FlightBook_FlightVo_arrivalAirportCode_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue: bookingReturnFlightVo.arrivalDateStr forKey:KEY_FlightBook_FlightVo_arrivalDateStr_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.arrivalTerminal forKey:KEY_FlightBook_FlightVo_arrivalTerminal_WithType(FlightBook_TarvelType_Return)];
    [formRequst setPostValue:bookingReturnFlightVo.arrivalTimeStr forKey:KEY_FlightBook_FlightVo_arrivalTimeStr_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.cabinCode forKey:KEY_FlightBook_FlightVo_cabinCode_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.departureAirportCode forKey:KEY_FlightBook_FlightVo_departureAirportCode_WithType(FlightBook_TarvelType_Return)];
    [formRequst setPostValue:bookingReturnFlightVo.departureDateStr forKey:KEY_FlightBook_FlightVo_departureDateStr_WithType(FlightBook_TarvelType_Return)];
    [formRequst setPostValue:bookingReturnFlightVo.departureTimeStr forKey:KEY_FlightBook_FlightVo_departureTimeStr_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.flightNo forKey:KEY_FlightBook_FlightVo_flightNo_WithType(FlightBook_TarvelType_Return)];
    [formRequst setPostValue:bookingReturnFlightVo.flightType forKey:KEY_FlightBook_FlightVo_flightType_WithType(FlightBook_TarvelType_Return)];
    
    
    [formRequst setPostValue:bookingReturnFlightVo.orderType forKey: KEY_FlightBook_FlightVo_orderType_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.prodType forKey:KEY_FlightBook_FlightVo_prodType_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.rmk forKey:KEY_FlightBook_FlightVo_rmk_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.ticketType forKey:KEY_FlightBook_FlightVo_ticketType_WithType(FlightBook_TarvelType_Return)];
    
    [formRequst setPostValue:bookingReturnFlightVo.flightOrgin forKey:KEY_FlightBook_FlightVo_flightOrgin_WithType(FlightBook_TarvelType_Return)];
    
    //机票联系人信息
    
    [formRequst setPostValue:flightContactVo.email forKey:KEY_FlightBook_flightContactVo_email];
    
    [formRequst setPostValue:flightContactVo.mobile forKey:KEY_FlightBook_flightContactVo_mobile];
    [formRequst setPostValue:flightContactVo.name forKey:KEY_FlightBook_flightContactVo_name];
    
    
    //行程单信息
    
    
    //关键信息  配送方式
    
    
    [formRequst setPostValue:flightItineraryVo.deliveryType forKey:KEY_FlightBook_flightItineraryVo_deliveryType];
    
    [formRequst setPostValue:flightItineraryVo.address forKey:KEY_FlightBook_flightItineraryVo_address];
    
    [formRequst setPostValue:flightItineraryVo.city forKey:KEY_FlightBook_flightItineraryVo_city];
    
    [formRequst setPostValue:flightItineraryVo.mobile forKey:KEY_FlightBook_flightItineraryVo_mobile];
    [formRequst setPostValue:flightItineraryVo.postCode forKey:KEY_FlightBook_flightItineraryVo_postCode];
    [formRequst setPostValue:flightItineraryVo.catchUser forKey:KEY_FlightBook_flightItineraryVo_catchUser];
    
    [formRequst setPostValue:flightItineraryVo.isPromptMailCost forKey:KEY_FlightBook_flightItineraryVo_isPromptMailCost];
    
    //机票订单乘客信息
    
    for (int i = 0 ; i<[passengerNum intValue]; i++) {
        
        
        
        
        flightPassengerVo *flightPassengerVo = [flightPassengerVoArray objectAtIndex:i];
        
        
        NSString *passengerId = KEY_FlightBook_flightPassengerVo_flightPassengerId(i);
        NSString *passName = KEY_FlightBook_flightPassengerVo_name(i);
        NSString *certtype = KEY_FlightBook_flightPassengerVo_certType(i);
        
        NSString *certNo = KEY_FlightBook_flightPassengerVo_certNo(i);
        NSString *passType = KEY_FlightBook_flightPassengerVo_type(i);
        
        NSString *goInsuranceNum = KEY_FlightBook_goInsuranceNum(i);
        NSString *returnInsuranceNum = KEY_FlightBook_returnInsuranceNum(i);
        
        
        if (Flight_DebugFlag) {
            
            CCLog(@"******************乘客信息************************");
            CCLog(@"乘机人id passengerId =%@",passengerId);
            
            CCLog(@"乘机人passName = %@",passName);
            CCLog(@"证件类型 certtype =%@",certtype);
            CCLog(@"证件号码 certNo =%@",certNo);
            CCLog(@"乘客类型 passType = %@",passType);
            
            CCLog(@"去程保险数目 goInsuranceNum  =%@",goInsuranceNum);
            CCLog(@"返程保险数目 returnInsuranceNum =%@",returnInsuranceNum);
            
            
            
            CCLog(@"******************其他支付************************");
            
            CCLog(@"是否需要密码 = %@",payVo.isNeedPayPwd);
            
            CCLog(@"是否使用资金账户 金币支付 = %@",payVo.isNeedAccount);
            CCLog(@"不需要使用银币 =%@",payVo.needNotSilver);
            CCLog(@"支付密码 =%@",payVo.payPassword);
            
            CCLog(@"优惠券id =%@",payVo.captcha);
            
            
            
            
        }
        
        
        
        
        [formRequst setPostValue:flightPassengerVo.flightPassengerId forKey:passengerId];
        
        [formRequst setPostValue:flightPassengerVo.certType forKey:certtype];
        
        [formRequst setPostValue:flightPassengerVo.certNo forKey:certNo];
        
        [formRequst setPostValue:flightPassengerVo.name forKey:passName];
        
        [formRequst setPostValue:flightPassengerVo.type forKey:passType];
        
        [formRequst setPostValue:flightPassengerVo.goInsuranceNum forKey:goInsuranceNum];
        [formRequst setPostValue:flightPassengerVo.returnInsuranceNum forKey:returnInsuranceNum];
        
        
    }
    
    
    //支付方式其他的 信息
    
    
    [formRequst setPostValue:payVo.isNeedAccount forKey:KEY_FlightBook_payVo_isNeedAccount];
    
    
    [formRequst setPostValue:payVo.isNeedPayPwd forKey:KEY_FlightBook_payVo_isNeedPayPwd];
    
    [formRequst setPostValue:payVo.needNotSilver forKey:KEY_FlightBook_payVo_needNotSilver];
    
    [formRequst setPostValue:payVo.payPassword forKey:KEY_FlightBook_payVo_payPassword];
    [formRequst setPostValue:payVo.captcha forKey:KEY_FlightBook_payVo_captcha];
    
    
    
    
    
    
    
    
    //    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setRequestMethod:@"POST"];
    
    
    
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        NSString *codeRequ =[NSString stringWithFormat:@"%d",[formRequst responseStatusCode]];
        
        CCLog(@"网络返回的请求码是 %@",codeRequ);
        
        
        
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
        
        NSLog(@"服务器返回的信息为：%@",message);
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                //NSLog(@"成功登陆后返回的数据：%@",data);
                
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
                
                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                    
                }
                
                
                
            }
            
            
            
        } else{
            NSLog(@"解析有错误");
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                
                [delegate requestDidFinishedWithFalseMessage:messageDic];
                
            }
            
            
            
            return ;
            
        }
        
        
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:messageDic];
            
        }
        
        
        
        
    }];
    
    
    [formRequst startAsynchronous];
    
    
}


@end
