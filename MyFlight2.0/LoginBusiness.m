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
- (void) getAccountInfoWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate{
    //此处拼接URL 
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];

    [dic setObject:memberId forKey:KEY_Account_MemberId];
    [LoginInNetworkHelper getAccountInfo:dic delegate:delegate];
    [dic release];
    
 }

//编辑账号信息
- (void) editAccountInfoWithMemberId:(NSString *) memberId userName:(NSString *) name userSex:(NSString *) sex userAddress:(NSString *) address  andDelegate:(id<ServiceDelegate>) delegate{
    
    
    
}




//获取验证码

- (void) getSecretCode:(NSString *) receivedMobile andDelegate:(id<ServiceDelegate>) delegate{
    
    
    NSLog(@"在处理业务层 获取用户输入的密码为：%@",receivedMobile);
    [LoginInNetworkHelper getSecretCode:receivedMobile andDelegat:delegate];
     
}

//查询常用联系人
- (void) getCommonPassengerWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate{
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    [dic setObject:memberId forKey:KEY_Account_MemberId];
    [LoginInNetworkHelper getCommonPassenger:dic delegate:delegate];
    [dic release];
}

//编辑常用联系人
- (void) editCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate{
    
    
    
    
    
    
}

//增加常用联系人
- (void) addCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate{
    
    
    
    
    
}


@end
