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

#pragma mark -
#pragma mark 注册操作
//注册操作
+ (BOOL) registerWithUrl:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    
    NSString *name = [bodyDic objectForKey:KEY_Register_Account];
    
    NSString *pwd = [bodyDic objectForKey:KEY_Register_Pwd];
    
    NSString *yzCode = [bodyDic objectForKey:KEY_Register_YZCode];
    
    
    CCLog(@"用户名为：%@",name);
    
    
    NSString *realUrl = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@",KEY_Register_Account,name,KEY_Register_Pwd,pwd,KEY_Register_YZCode,yzCode,PUBLIC_Parameter];
    
    CCLog(@"realUrl =%@",realUrl);
    
    //base64加密
    NSData *data =[realUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *plain = [data base64Encoding];
    NSString *sign = [DNWrapper md5:realUrl];
    
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    [messageDic setObject:Regist_RequestType_Value forKey:KEY_Request_Type];
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:REGISTER_URL]];
    
    [formRequst setPostValue:plain forKey:KEY_PLAIN];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        
        NSString *data = [formRequst responseString];
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            
            NSLog(@"服务器返回的信息为：%@",message);
            
            CCLog(@"message 长度为%d",[message length]);
            
            //            CCLog(@"成功注册后返回的数据：%@",dic);
            
            if ([message length]==0) {
                
                NSLog(@"成功注册后返回的数据：%@",data);
                
                
                
                //执行保存用户信息
                
                IsLoginInSingle *single = [IsLoginInSingle shareLoginSingle];
                
                //                single.isLogin = YES; //此时用户刚刚注册 尚未登录
                
                single.token = [dic objectForKey:KEY_Account_token];
                single.userAccount.memberId = [dic objectForKey:KEY_Account_MemberId];
                single.userAccount.email  =[dic objectForKey:KEY_Account_Email];
                single.userAccount.mobile = [dic objectForKey:KEY_Account_Mobile];
                
                
                
                
                NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
                
                //注册成功 保存用户注册时的用户名和密码  方便用户登陆操作
                
                [defaultUser setObject:name forKey:KEY_Default_AccountName];
                [defaultUser setObject:pwd forKey:KEY_Default_Password];
                
                
                
                [defaultUser setBool:NO forKey:KEY_Default_IsUserLogin]; //用户尚未登录
                
                [defaultUser setObject:single.userAccount.memberId forKey:KEY_Default_MemberId];
                
                
                [defaultUser setObject:single.token forKey:KEY_Default_Token];
                
                [defaultUser setObject:single.userAccount.mobile forKey:KEY_Default_UserMobile];
                
                [defaultUser synchronize];
                
                NSString *userName =[[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_AccountName];
                
                NSString *userPwd = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_Password];
                
                CCLog(@"成功注册后 用户的id为：%@",Default_UserMemberId_Value);
                
                CCLog(@"成功注册后，默认设置的用户名为:%@",userName);
                CCLog(@"成功注册后，默认设置的用户名为：%@",userPwd);
                
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
        
        //        [delegate requestDidFinishedWithFalseMessage:messageDic];
        
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

#pragma mark -
#pragma mark 登录操作
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
    
    
    //    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
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
    
    
    [formRequst startAsynchronous];
    
    [messageDic release];
    
    return true;
    
}



#pragma mark -
#pragma mark 查看账户信息
//查看账户信息

+ (BOOL) getAccountInfo:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
//    NSString *memberId = [bodyDic objectForKey:KEY_Account_MemberId];
    NSString *memberId =@"30f3e771eab046de830fb31ca3eb61dd";

        
//    NSString *token = Default_Token_Value;
    NSString *token = @"14A3C4E3D8DE0FBEA75E00013E4A0D33";
    
    CCLog(@"查询用户信息 memberId = %@",memberId);
    
    CCLog(@"查询用户信息 token =%@",token);
    
    
    
    
    NSString *signTmp = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@",KEY_Account_MemberId,memberId,KEY_source,@"iphone",KEY_Account_token,token,PUBLIC_Parameter];
    
    
       
    
    NSString *realUrl = [NSString stringWithFormat:@"%@?%@=%@&%@=%@&%@",Account_SearchInfo_URL,KEY_Account_MemberId,memberId,KEY_SIGN,GET_SIGN(signTmp),PUBLIC_Parameter];
    
    
    
    NSString *sign =GET_SIGN(signTmp);
    
    NSLog(@"查询账号详细信息：加密后的为：%@",sign);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:Account_SearchInfo_URL]];
    
    
    
    [formRequst setPostValue:memberId forKey:KEY_Account_MemberId];
    [formRequst setPostValue:@"iphone" forKey:KEY_source];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    
    
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
//    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setRequestMethod:@"POST"];
    
    
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
//        NSString *data =@"";
        
        CCLog(@"网络返回的数据为 这是什么情况啊：%@",data);
        
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                // NSLog(@"成功登陆后返回的数据：%@",data);
                
                
                              
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
    
    return true;
    
}

#pragma mark -
#pragma mark 编辑账号信息
//编辑账号
+ (BOOL) editAccountInfo:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    
    
    
    
}





#pragma mark -
#pragma mark 常用乘机人查询 
//常用乘机人查询 

+(BOOL) getCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    //    NSString *memberId = [bodyDic objectForKey:KEY_Account_MemberId];
    NSString *memberId =@"30f3e771eab046de830fb31ca3eb61dd";
    
    
    //    NSString *token = Default_Token_Value;
    NSString *token = @"14A3C4E3D8DE0FBEA75E00013E4A0D33";
    
    CCLog(@"查询常用联系人信息 memberId = %@",memberId);
    
    CCLog(@"查询常用联系人信息 token =%@",token);
    
    
    
    NSString *signTmp = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",KEY_Account_MemberId,memberId,KEY_source,@"iphone",KEY_Account_token,token];
    
    
    
    
    NSString *realUrl = [NSString stringWithFormat:@"%@?%@=%@&%@=%@&%@",Account_SearchInfo_URL,KEY_Account_MemberId,memberId,KEY_SIGN,GET_SIGN(signTmp),PUBLIC_Parameter];
    
    
    
    
    NSString *sign =GET_SIGN(signTmp);
    
    NSLog(@"查询详细信息：加密后的为：%@",sign);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:CommomPassenger_URL]];
    
    
    
    [formRequst setPostValue:memberId forKey:KEY_Account_MemberId];
    [formRequst setPostValue:@"iphone" forKey:KEY_source];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    
    
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    //    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setRequestMethod:@"POST"];
    
    
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为 这是什么情况啊：%@",data);
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                // NSLog(@"成功登陆后返回的数据：%@",data);
                
                
                
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
    
    return true;

    
    
}








#pragma mark -
#pragma mark 增加常用联系人
//增加常用联系人
+ (BOOL) addCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    
}


#pragma mark -
#pragma mark 编辑常用联系人
//编辑常用联系人
+ (BOOL) editCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate{
    
    
}

//获取验证码
+ (BOOL) getSecretCode:(NSString *) mobileNumber andDelegat:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    
    NSString *publicParm = PUBLIC_Parameter;
    
    NSLog(@"用户输入的手机号码为：%@",mobileNumber);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?mobile=%@&type=%@&%@",URL_GetSecretCodeUrl,mobileNumber,KEY_GETCode_ForRegist,publicParm];
    
    
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    [messageDic setObject:GET_SecretCode_RequestType_Value forKey:KEY_Request_Type];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                CCLog(@"发送手机验证码后，服务器的响应是：%@",data);
                
                
                
                
                
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
        
        CCLog(@"失败");
        
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        [delegate requestDidFailed:messageDic];
        
        
        
    }];
    
    [formRequst startAsynchronous];
    return  true;
}





@end
