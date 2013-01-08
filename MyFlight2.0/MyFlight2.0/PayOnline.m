//
//  PayOnline.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-5.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "PayOnline.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"

@implementation PayOnline

-(id) initWithProdType:(NSString *)prodType
               payType:(NSString *)payType
             orderCode:(NSString *)orderCode
              memberId:(NSString *)memberId
             actualPay:(NSString *)actualPay
                source:(NSString *)source
                  hwId:(NSString *)hwId
           serviceCode:(NSString *)serviceCode
           andDelegate:(id<ServiceDelegate>)delegate
{
    if ([super init]) {
        self.prodType = prodType;
        self.payType = payType;
        self.orderCode = orderCode;
        self.memberId = memberId;
        self.actualPay = actualPay;
        self.source = source;
        self.hwId = hwId;
        self.serviceCode = serviceCode;
        self.delegate = delegate;
    }
    return self;
    
}

-(void) getBackInfo
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    [messageDic setObject:@"fsfs" forKey:KEY_Request_Type];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/pay/fPhonePay.jsp"]]];
    
    [request setPostValue:self.prodType forKey:@"prodType"];
    [request setPostValue:self.payType forKey:@"payType"];
    [request setPostValue:self.orderCode forKey:@"orderCode"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.actualPay forKey:@"actualPay"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.serviceCode forKey:@"serviceCode"];
 
    
    
    CCLog(@"*************************  验证支付信息 ******************");
    CCLog(@"prodType  =  %@",self.prodType);
    CCLog(@"payType  =  %@",self.payType);
    CCLog(@"orderCode  =  %@",self.orderCode);
    CCLog(@"memberId  =  %@",self.memberId);
    CCLog(@"actualPay  =  %@",self.actualPay);
    CCLog(@"source  =  %@",self.source);
    CCLog(@"hwId  =  %@",self.hwId);
    CCLog(@"serviceCode  =  %@",self.serviceCode);
   
    
    
    [request setRequestMethod:@"POST"];
    
    [request setCompletionBlock:^{
        
        NSString *data = [request responseString];
        
        NSLog(@"====================================   %@",data);
        
       
        
    
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary * dic = [NSDictionary dictionaryWithObject:data forKey:@"pay"];
       
        
        
        NSLog(@"服务器返回的信息为：%@",message);
        
        if (!error) {
            
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:dic];
                    
                
                
            } else{
                
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                
            }
            
        } else{
            
            
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
@end
