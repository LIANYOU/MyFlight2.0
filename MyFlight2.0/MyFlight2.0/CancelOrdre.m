//
//  CancelOrdre.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-7.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "CancelOrdre.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
@implementation CancelOrdre

-(id) initWithOrderId:(NSString *)orderId
         andOrderCode:(NSString *)orderCode
          andMemberId:(NSString *)memberId
         andCheckCode:(NSString *)checkCode
              andSign:(NSString *)sign
            andSource:(NSString *)source
              andHwId:(NSString *)hwId
           andEdition:(NSString *)edition
          andDelegate:(id<ServiceDelegate>)delegate
{
    if ([super init]) {
        self.orderCode = orderCode;
        self.orderId = orderId;
        self.memberId = memberId;
        self.checkCode = checkCode;
        self.sign = sign;
        self.source = source;
        self.hwId = hwId;
        self.edition = edition;
        self.delegate = delegate;
    }
    
    return self;
}


-(void)delOrder
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    //取消订单信息
    
    [messageDic setObject:@"cancel" forKey:KEY_Request_Type];
    
    
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/order/flight/fOrderCancel.jsp?"]]];
    
    [request setPostValue:self.orderId forKey:@"orderId"];
    [request setPostValue:self.orderCode forKey:@"orderCode"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.checkCode forKey:@"checkCode"];
    [request setPostValue:self.sign forKey:@"sign"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.edition forKey:@"edition"];
    
    
    
    
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
            
            
            CCLog(@"message length = %d",[message length]);
            if ([message length]==0) {
                
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:messageDic];
                    
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
