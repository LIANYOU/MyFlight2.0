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
               captcha:(NSString *)captcha
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
        self.captcha = captcha;
        self.delegate = delegate;
    }
    return self;
    
}

-(void) getBackInfo
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    [messageDic setObject:@"fsfs" forKey:KEY_Request_Type];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/member/yzPayPassword.jsp"]]];
    
    [request setPostValue:self.prodType forKey:@"prodType"];
    [request setPostValue:self.payType forKey:@"payType"];
    [request setPostValue:self.orderCode forKey:@"orderCode"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.actualPay forKey:@"actualPay"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.serviceCode forKey:@"serviceCode"];
    [request setPostValue:self.captcha forKey:@"captcha"];
    
    
    CCLog(@"*************************  验证支付信息 ******************");
    CCLog(@"memberId  =  %@",self.memberId);
    CCLog(@"source  =  %@",self.source);
    CCLog(@"hwId  =  %@",self.hwId);

    
    
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
            
            NSString * batchNo = [dic objectForKey:@"batchNo"];
            NSString * actualPay = [dic objectForKey:@"actualPay"];
            NSArray * arr = [NSArray arrayWithObjects:batchNo,actualPay, nil];
            
            NSDictionary * dictionary = [NSDictionary dictionaryWithObject:arr forKey:@"dic"];
            
            CCLog(@"message length = %d",[message length]);
            if ([message length]==0) {
                
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:dictionary];
                    
                }
                
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
