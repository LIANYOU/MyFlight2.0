//
//  LoginInNetworkHelper.m
//  JOSNAndTableView
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import "LoginInNetworkHelper.h"
#import "ASIHTTPRequest.h"
#import "DNWrapper.h"
#import "NSData+base64.h"
#import "ASIFormDataRequest.h"
#import "AppConfigure.h"
#import "JSONKit.h"
#import "IsLoginInSingle.h"
#import "UserAccount.h"
@implementation LoginInNetworkHelper


//注册操作
+ (BOOL) registerWithUrl:(NSDictionary *) param delegate:(id<ServiceDelegate>) delegate{
    
    //    NSString *registerUrl = @"http://test.51you.com/web/phone/register.jsp";
    
    NSString *mobile =@"13161188685";
    NSString *pwd= @"abc123589";
    NSString *pwd2 =@"abc123589";
    NSString *publicPram = @"source=&hwId=A15A9904-056B-5557-A3A2-C0F92F6AC211&serviceCode=01&edition=v1.0";
    
    //    NSString *publicPram1 = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",KEY_source,SOURCE_VALUE,KEY_hwId,HWID_VALUE,KEY_serviceCode,SERVICECode_VALUE,KEY_edition,EDITION_VALUE];
    //
    
    NSString *edition =@"v1.0";
    NSString *source = @"xx";
    
    
    NSString *realUrl = [NSString stringWithFormat:@"account=%@&pwd=%@&pwd2=%@&%@",mobile,pwd,pwd2,publicPram];
    
    
    NSData *data = [realUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *plain = [data base64Encoding];
    NSString *sign = [DNWrapper md5:realUrl];
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:REGISTER_URL]];
    
    
    
    
    [formRequst setPostValue:plain forKey:KEY_PLAIN];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    [formRequst setPostValue:edition forKey:KEY_edition];
    [formRequst setPostValue:source forKey:KEY_source];
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSLog(@"注册成功");
        NSString *data = [formRequst responseString];
        
        NSLog(@"成功注册后返回的信息：%@",data);
        
        [delegate requestDidFinishedWithFalseMessage:nil];
        
        
        
    }];
    
    
    [formRequst setFailedBlock:^{
        
        [delegate requestDidFailed:nil];
        
        NSLog(@"失败");
        NSError *error = [formRequst error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    
    
    [formRequst startSynchronous];
    
    return YES;
    
}

//登录操作

+ (BOOL) requestWithUrl:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate
{
    
    
    
    NSString *name = [bodyDic objectForKey:KEY_Login_Account];
    
    NSString *pwd = [bodyDic objectForKey:KEY_Login_Pwd];
    
    
    CCLog(@"用户名为：%@",name);
    
    
    NSString *realUrl = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@",KEY_Login_Account,name,KEY_Login_Pwd,pwd,KEY_Login_Type,Login_Type_Value,PUBLIC_Parameter];
    
    CCLog(@"realUrl =%@",realUrl);
    
    //base64加密
    NSData *data =[realUrl dataUsingEncoding:NSUTF8StringEncoding];
    NSString *plain = [data base64Encoding];
    NSString *sign = [DNWrapper md5:realUrl];
    
    
   __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
   __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:LOGIN_URL]];
    
    
    [formRequst setPostValue:plain forKey:KEY_PLAIN];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
    
        NSString *data = [formRequst responseString];
        
//        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
       
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            CCLog(@"message 长度为%d",[message length]);
            
            CCLog(@"成功登陆后返回的数据：%@",dic);
        
            if ([message length]==0) {
                
                NSLog(@"成功登陆后返回的数据：%@",data);
               
              
                
                //执行保存用户信息
                
                IsLoginInSingle *single = [IsLoginInSingle shareLoginSingle];
                single.isLogin = YES;
                single.token = [dic objectForKey:KEY_Account_token];
                single.userAccount.memberId = [dic objectForKey:KEY_Account_MemberId];
                single.userAccount.email  =[dic objectForKey:KEY_Account_Email];
                single.userAccount.mobile = [dic objectForKey:KEY_Account_Mobile];
                
                
                
                
                NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
                
                [defaultUser setBool:YES forKey:KEY_Default_IsUserLogin];
                
                [defaultUser setObject:single.userAccount.memberId forKey:KEY_Default_MemberId];
                
                
                [defaultUser setObject:single.token forKey:KEY_Default_Token];
                
                [defaultUser setObject:[dic objectForKey:KEY_Default_UserMobile] forKey:KEY_Default_UserMobile];
            
                [defaultUser synchronize];
                   
                CCLog(@"用户的id为：%@",Default_UserMemberId_Value);
                
                
                
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
       
        CCLog(@"网络访问失败");
        
    }];
    
    
    [formRequst startSynchronous];
    
    

    return true;
    
}




//查看账户信息

+ (BOOL) getAccountInfo:(NSDictionary *) param delegate:(id<ServiceDelegate>) delegate{
    
    
    
    NSString *memberId = MEMBER_ID_VALUE;
    
    NSString *signTmp = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",KEY_Account_MemberId,MEMBER_ID_VALUE,KEY_source,SOURCE_VALUE,KEY_Account_token,Token_VALUE];
    
    
    //    NSLog(@"查询账号详细信息：加密后的为：%@",)
    
    NSString *realUrl = [NSString stringWithFormat:@"%@?%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",Account_SearchInfo_URL,KEY_Account_MemberId,MEMBER_ID_VALUE,KEY_SIGN,GET_SIGN(signTmp),KEY_source,SOURCE_VALUE,KEY_hwId,HWID_VALUE,KEY_edition,EDITION_VALUE];
    
    
    __block ASIHTTPRequest *formRequst  =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:realUrl]];
    
    [formRequst setCompletionBlock:^{
        
        NSLog(@"成功");
        NSString *data = [formRequst responseString];
        
        
        NSLog(@"成功查询后返回的数据：%@",data);
        
        [delegate requestDidFinishedWithFalseMessage:nil];
        
        
    }];
    
    
    [formRequst setFailedBlock:^{
        
        [delegate requestDidFailed:nil];
        
        NSLog(@"失败");
        NSError *error = [formRequst error];
        NSLog(@"错误信息： %@", error.localizedDescription);
        
        
    }];
    
    
    [formRequst startAsynchronous];
    
    
    
    
    return true;
    
}
@end
