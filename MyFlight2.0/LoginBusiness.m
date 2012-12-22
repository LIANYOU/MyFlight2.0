//
//  LoginBusiness.m
//  MyFirstApp
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "LoginBusiness.h"
#import "LoginInNetworkHelper.h"
#import "AppConfigure.h"
@implementation LoginBusiness

//登陆
- (void) loginWithName:(NSString *)name password:(NSString *)passwd andDelegate:(id)delegate{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    [dic setObject:name forKey:KEY_Login_Account];
    [dic setObject:passwd forKey:KEY_Login_Pwd];
    
    [LoginInNetworkHelper requestWithUrl:dic delegate:delegate];
    
    [dic release];
    
   
    
}

//注册 密码可能要求输入确认密码
- (void) registerWithAccount:(NSString *)name password:(NSString *)passwd yaCode:(NSString *)yzCode andDelegate:(id<ServiceDelegate>)delegate{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    [dic setObject:name forKey:KEY_Register_Account];
    
    [dic setObject:passwd forKey:KEY_Register_Pwd];
    
    [dic setObject:yzCode forKey:KEY_Register_YZCode];
    
    [LoginInNetworkHelper registerWithUrl:dic delegate:delegate];
    [dic release];
    
    
}


//查询账号信息
- (void) getAccountInfo:(NSString *) info andDelegate:(id<ServiceDelegate>) delegate{
    //此处拼接URL 
    
    
    [LoginInNetworkHelper getAccountInfo:nil delegate:delegate];
    
 }


//获取验证码

- (void) getSecretCode:(NSString *) receivedMobile andDelegate:(id<ServiceDelegate>) delegate{
    
    
    NSLog(@"在处理业务层 获取用户输入的密码为：%@",receivedMobile);
    [LoginInNetworkHelper getSecretCode:receivedMobile andDelegat:delegate];
    
    
    
    
    
}


@end
