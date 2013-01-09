//
//  OrderDetaile.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "OrderDetaile.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
#import "OrderBasicInfoWJ.h"
#import "FlightConditionWj.h"
#import "Passenger.h"
#import "PostInfo.h"
#import "LinkPersonInfo.h"
#import "InFlightConditionWJ.h"
#import "DiscountGoldInfo.h"
@implementation OrderDetaile

-(id) initWithOrderId:(NSString * )orderId
          andMemberId:(NSString *)memberId
         andCheckCode:(NSString *)checkCode
              sndSign:(NSString *)sign
            sndSource:(NSString *)source
              andHwId:(NSString *)hwId
           andEdition:(NSString *)edition
          andDelegate:(id<ServiceDelegate>) delegate
{
    if ([super init]) {
        self.orderId = orderId;
        self.memberId = memberId;
        self.checkCode = checkCode;
        self.sign = sign;
        self.source = source;
        self.hwId = hwId;
        self.edition = edition;
    }
    return self;
}

-(void) getOrderDetailInfo :(NSString *) searchType
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:GetDetailOrder_URL]];
    
    [request setPostValue:self.orderId forKey:@"orderId"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.checkCode forKey:@"checkCode"];
    [request setPostValue:self.sign forKey:@"sign"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.edition forKey:@"edition"];
    
    // **************************   订单详情查询参数  *************************
    
    
    [request setRequestMethod:@"POST"];

    [request setCompletionBlock:^{
        
        
        
        NSString *data = [request responseString];
        
        
        
        NSString *codeRequ =[NSString stringWithFormat:@"%d",[request responseStatusCode]];
        
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
                
                                      
                [self analysisData:dic andSearchType:searchType];   // 处理解析数据
                                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }

            }

        } else{
            NSLog(@"解析有错误");
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            
            if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                
                [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                
            }
              return ;
            
        }
      }];
    
    [request setFailedBlock:^{
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [self.delegate requestDidFailed:messageDic];
            
        }

    }];
    
    
    [request startAsynchronous];
    
}


-(void) analysisData:(NSDictionary *)dic andSearchType:(NSString *)type
{
    
    DiscountGoldInfo * discountInfo = [[DiscountGoldInfo alloc] init];
    
    discountInfo.xlbGold = [dic objectForKey:@"xlbGold"];
    discountInfo.xlbSilver = [dic objectForKey:@"xlbSilver"];
    discountInfo.netAmount = [dic objectForKey:@"netAmount"];
    discountInfo.payOnLine = [dic objectForKey:@"payOnLine"];
    
    
    

    OrderBasicInfoWJ * order = [[OrderBasicInfoWJ alloc] init];
    
    order.orderId = [dic objectForKey:@"orderId"];
    order.code = [dic objectForKey:@"code"];
    order.createDate = [dic objectForKey:@"createDate"];
    order.stsCh = [dic objectForKey:@"stsCh"];
    order.payStsCh = [dic objectForKey:@"payStsCh"];
    order.totalMoney = [dic objectForKey:@"totalMoney"];
    order.actualMoney = [dic objectForKey:@"actualMoney"];
    order.flyType = [dic objectForKey:@"flightType"];
    
    FlightConditionWj * flight = [[FlightConditionWj alloc] init];
    
    NSDictionary * outDic = [dic objectForKey:@"outBookingFlight"];
    
    flight.depAirPortCN = [outDic objectForKey:@"depAirportCN"];
    flight.arrAirportCN = [outDic objectForKey:@"arrAirportCN"];
    flight.airlineCompany = [outDic objectForKey:@"airlineCompany"];
    flight.airlineCompanyCode = [outDic objectForKey:@"airlineCompanyCode"];
    flight.aircraftType = [outDic objectForKey:@"aircraftType"];
    flight.flightNo = [outDic objectForKey:@"flightNo"];
    flight.cabinCode = [outDic objectForKey:@"cabinCode"];
    flight.cabinCN = [outDic objectForKey:@"cabinCN"];
    flight.departureDate = [outDic objectForKey:@"departureDate"];
    flight.departureTime = [outDic objectForKey:@"departureTime"];
    flight.arrivalTime = [outDic objectForKey:@"arrivalTime"];
    flight.cabinRule = [outDic objectForKey:@"cabinRule"];
    

 
    
    InFlightConditionWJ * inFlight = [[InFlightConditionWJ alloc] init];
    
    if ([type isEqualToString:@"1"]) {   //  返程判断条件
        
      
        NSDictionary * inDic = [dic objectForKey:@"inBookingFlight"];
        
        inFlight.depAirPortCN = [inDic objectForKey:@"depAirportCN"];
        inFlight.arrAirportCN = [inDic objectForKey:@"arrAirportCN"];
        inFlight.airlineCompany = [inDic objectForKey:@"airlineCompany"];
        inFlight.airlineCompanyCode = [inDic objectForKey:@"airlineCompanyCode"];
        inFlight.aircraftType = [inDic objectForKey:@"aircraftType"];
        inFlight.flightNo = [inDic objectForKey:@"flightNo"];
        inFlight.cabinCode = [inDic objectForKey:@"cabinCode"];
        inFlight.cabinCN = [inDic objectForKey:@"cabinCN"];
        inFlight.departureDate = [inDic objectForKey:@"departureDate"];
        inFlight.departureTime = [inDic objectForKey:@"departureTime"];
        inFlight.arrivalTime = [inDic objectForKey:@"arrivalTime"];
        inFlight.cabinRule = [inDic objectForKey:@"cabinRule"];

    }

    NSArray * arr = [dic objectForKey:@"flightPassenger"];
    NSMutableArray * passengerArr = [NSMutableArray array];
    
    for (NSDictionary * dici in arr) {
        
        Passenger * passenger = [[Passenger alloc] init];
        
        passenger.name = [dici objectForKey:@"name"];
        passenger.certType = [dici objectForKey:@"certType"];
        passenger.certNo = [dici objectForKey:@"certNo"];
        passenger.insuranceCode = [dici objectForKey:@"insuranceCode"];
        passenger.etNo = [dici objectForKey:@"etNo"];
        
        passenger.ticketPrice = [dici objectForKey:@"ticketPrice"];
        passenger.constructionPrice = [dici objectForKey:@"constructionPrice"];
        passenger.bafPrice = [dici objectForKey:@"bafPrice"];
        passenger.insurance = [dici objectForKey:@"insurance"];
        
        passenger.type = [dici objectForKey:@"type"];
        
        [passengerArr addObject:passenger];
        
        [passenger release];
    }

    PostInfo * post = [[PostInfo alloc] init];
    
    post.deliveryType = [[dic objectForKey:@"itinerary"] objectForKey:@"deliveryType"];
    post.catchUser = [[dic objectForKey:@"itinerary"] objectForKey:@"catchUser"];
    post.mobile = [[dic objectForKey:@"itinerary"] objectForKey:@"mobile"];
    post.address = [[dic objectForKey:@"itinerary"] objectForKey:@"address"];
    
    
    
    LinkPersonInfo * link = [[LinkPersonInfo alloc] init];
    
    link.name = [[dic objectForKey:@"contact"] objectForKey:@"name"];
    link.iphone = [[dic objectForKey:@"contact"] objectForKey:@"phone"];
    
    
    NSArray * newArr = [NSArray arrayWithObjects:order,flight,inFlight,passengerArr,post,link,discountInfo, nil];
    NSDictionary * newDic = [NSDictionary dictionaryWithObject:newArr forKey:@"newDic"];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
        
        [self.delegate requestDidFinishedWithRightMessage:newDic];
    
    }
    
    [order release];
    [flight release];
    [inFlight release];
    [post release];
    [link release];
    [discountInfo release];
    
}
@end
