//
//  FrequentFlyNetWorkHelper.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "FrequentFlyNetWorkHelper.h"
#import "AppConfigure.h"
#import "AppConfigure.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "FrequentPassengerData.h"
#import "isFrequentPassengerLogin.h"
#import "isFrequentPassengerLogin.h"
#import "LiChengDetailData.h"
@implementation FrequentFlyNetWorkHelper
//登录
+ (BOOL) loginWithName:(NSString *) name password:(NSString *) passwd andDelegate:(id<ServiceDelegate>) delegate{
    
    
    
    //    NSString *urlString = [NSString stringWithFormat:@"?mobile=%@&type=%@&%@",mobileNumber,KEY_GETCode_ForRegist,publicParm];
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:FrequentFly_URL]];
    
    [formRequst setPostValue:name forKey:@"cardNo"];
    [formRequst setPostValue:passwd forKey:@"psw"];
    [formRequst setPostValue:@"01" forKey:@"serviceCode"];
    [formRequst setPostValue:SOURCE_VALUE forKey:@"source"];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    
    [formRequst setTimeOutSeconds:10];
    
    [formRequst setRequestMethod:@"POST"];
    
    
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的请求码为：%d", [formRequst responseStatusCode]);
        
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                //NSLog(@"成功登陆后返回的数据：%@",data);
                CCLog(@"成功");
                
                isFrequentPassengerLogin *single = [isFrequentPassengerLogin shareFrequentPassLogin];
                
                NSDictionary *right = [[dic objectForKey:@"frequentFlyer"] retain];
                NSString *cardNo = [right objectForKey:@"cardNo"];
                CCLog(@"cardNo =%@",cardNo);
                CCLog(@"right count =%d",[right count]);
                
                single.frequentPassData.cardNo = [right objectForKey:@"cardNo"];
                single.frequentPassData.name = [right objectForKey:@"name"];
                
                single.lichengData.cardNo = [right objectForKey:@"cardNo"];
                single.lichengData.grade = [right objectForKey:@"grade"];
                single.lichengData.balance =[right objectForKey:@"balance"];
                single.lichengData.expireDate = [right objectForKey:@"expireDate"];
                single.lichengData.airlinePoints = [right objectForKey:@"airlinePoints"];
                single.lichengData.notAirlinePoints = [right objectForKey:@"notAirlinePoints"];
                single.lichengData.upgradePoints = [right objectForKey:@"upgradePoints"];
                single.lichengData.upgradeSegments =[right objectForKey:@"upgradeSegments"];
                single.lichengData.expirePoints = [right objectForKey:@"expirePoints"];
                single.lichengData.otherPoints =[right objectForKey:@"otherPoints"];
                
               
                single.isLogin =YES;
                
                [right release];
                
                if(delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]){
                    
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
                
                
                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }
                
                
                
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
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]){
            [delegate requestDidFailed:messageDic];
            
        }
    }];
    
    [formRequst startAsynchronous];
    
    return true;
}


//查询 里程

+ (BOOL)getMemberPointInfoWithCardNo:(NSString *) cardNo passwd:(NSString *) pwd ndDelegate:(id<ServiceDelegate>) delegate{
    
    
    CCLog(@"查询里程详情界面*************************");
    
    //    NSString *publicParm = PUBLIC_Parameter;
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:FrequentFly_GetMemberPoint_URL]];
    
    [formRequst setPostValue:cardNo forKey:@"cardNo"];
    [formRequst setPostValue:pwd forKey:@"psw"];
    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    
    
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
                
                //  NSLog(@"成功登陆后返回的数据：%@",data);
                
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    //                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]){
                    //message 长度不为0 有错误信息
                    [messageDic setObject:message forKey:KEY_message];
                    
                    
                    //                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                
                
            }
            
        } else{
            NSLog(@"解析有错误");
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                //                [delegate requestDidFinishedWithFalseMessage:messageDic];
                
                
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
