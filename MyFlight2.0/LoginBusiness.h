//
//  LoginBusiness.h
//  MyFirstApp
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface LoginBusiness : NSObject

@property(nonatomic,assign)id<ServiceDelegate> delegate;

//登录
- (void) loginWithName:(NSString *) name password:(NSString *) passwd andDelegate:(id<ServiceDelegate>) delegate;


//注册 
- (void) registerWithAccount:(NSString *) name password:(NSString *) passwd yaCode:(NSString *)yzCode andDelegate:(id<ServiceDelegate>) delegate;

//查询账号信息
- (void) getAccountInfoWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;

//编辑账号信息
- (void) editAccountInfoWithMemberId:(NSString *) memberId userName:(NSString *) name userSex:(NSString *) sex userAddress:(NSString *) address  andDelegate:(id<ServiceDelegate>) delegate;


//获取验证码

- (void) getSecretCode:(NSString *) receivedMobile andDelegate:(id<ServiceDelegate>) delegate;



//查询常用联系人
- (void) getCommonPassengerWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;

//编辑常用联系人 
- (void) editCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate;

//增加常用联系人
- (void) addCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate;

//删除常用联系人
- (void) deleteCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate;





//- (void) makeAccountFullWith 


@end
