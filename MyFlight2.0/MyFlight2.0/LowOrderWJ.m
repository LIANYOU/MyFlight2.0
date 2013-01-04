//
//  LowOrderWJ.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-4.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "LowOrderWJ.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
@implementation LowOrderWJ

-(id)initWithSource:(NSString *)source
             andDpt:(NSString *)dpt
             andArr:(NSString *)arr
       andDateSatrt:(NSString *)dateSatrt
         andDateEnd:(NSString *)dateEnd
        andDiscount:(NSString *)discount
          andMobile:(NSString *)mobile
            andHwId:(NSString *)hwId
        andMemberId:(NSString *)memberId
            andSign:(NSString *)sign
        andDelegate:(id<ServiceDelegate>) delegate{
    
    
    if ([super init]) {
        self.source = source;
        self.dpt = dpt;
        self.arr = arr;
        self.dateStart = dateSatrt;
        self.dateEnd = dateEnd;
        self.discount = discount;
        self.mobile = mobile;
        self.hwId = hwId;
        self.memberId = memberId;
        self.sign = sign;
    }
    
    return self;
    
}


-(void) getLowOrderInfo{
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/prod/flight/preBook.jsp"]]];
    
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.dpt forKey:@"dpt"];
    [request setPostValue:self.arr forKey:@"arr"];
    [request setPostValue:self.dateStart forKey:@"startDate"];
    [request setPostValue:self.dateEnd forKey:@"endDate"];
    [request setPostValue:self.discount forKey:@"discount"];
    [request setPostValue:self.mobile forKey:@"mobile"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.sign forKey:@"sign"];
    
    
    CCLog(@"*************************  低价预约 ******************");
    CCLog(@"source  =  %@",self.source);
    CCLog(@"dpt  =  %@",self.dpt);
    CCLog(@"arr  =  %@",self.arr);
    CCLog(@"startDate  =  %@",self.dateStart);
    CCLog(@"dateEnd  =  %@",self.dateEnd);
    CCLog(@"discount  =  %@",self.discount);
    CCLog(@"mobile  =  %@",self.mobile);
    CCLog(@"hwId  =  %@",self.hwId);
    CCLog(@"memberId  =  %@",self.memberId);
    CCLog(@"sign  =  %@",self.sign);
    
    
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
//            NSLog(@"服务器返回的信息为：%@",message);
            
             CCLog(@"message length = %d",[message length]);
            if ([message length]==0) {
                
                 [messageDic setObject:message forKey:KEY_message];
               
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                CCLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^");
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
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

@end
