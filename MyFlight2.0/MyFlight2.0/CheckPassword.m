//
//  CheckPassword.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-4.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "CheckPassword.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
@implementation CheckPassword
-(id) initWithMemberId:(NSString *)memberId
             andSource:(NSString *)source
               andHwId:(NSString * )hwId
           andPassWord:(NSString *)passWord
               andSign:(NSString *)sign
            andEdition:(NSString *)edition
           andDelegate:(id<ServiceDelegate>)delegate
{
    if ([super init]) {
        self.memberId = memberId;
        self.source = source;
        self.hwId = hwId;
        self.sign = sign;
        self.passWord = passWord;
        self.edition = edition;
        self.delegate = delegate;
    }
    return self;
}

-(void)getPassword
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/member/yzPayPassword.jsp"]]];
    
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.passWord forKey:@"payPassword"];
    [request setPostValue:self.sign forKey:@"sign"];
    [request setPostValue:self.edition forKey:@"edition"];
    
    
    CCLog(@"*************************  验证密码 ******************");
    CCLog(@"memberId  =  %@",self.memberId);
    CCLog(@"source  =  %@",self.source);
    CCLog(@"hwId  =  %@",self.hwId);
    CCLog(@"sign  =  %@",self.sign);
    CCLog(@"edition  =  %@",self.edition);

    
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
