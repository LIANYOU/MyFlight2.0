//
//  LoginInNetworkHelper.h
//  JOSNAndTableView
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
#import "CommonContact.h"
@interface LoginInNetworkHelper : NSObject

//登录操作 
+ (BOOL) requestWithUrl:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//第三方登陆成功后提交到服务器
//http://223.202.36.172:8380/web/phone/member/thirdPartyLogin.jsp
+(BOOL) submitOAuthDateToServer:(NSMutableDictionary *) userOAuthInfo delegate:(id<ServiceDelegate>) delegate;


//注册操作 
+ (BOOL) registerWithUrl:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//查看账号信息 
+ (BOOL) getAccountInfo:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//编辑账号 
+ (BOOL) editAccountInfo:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;


//获取手机验证码
+ (BOOL) getSecretCode:(NSDictionary *) bodyDic andDelegat:(id<ServiceDelegate>) delegate;

//查询常用联系人 
+(BOOL) getCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//增加常用联系人
+ (BOOL) addCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//编辑常用联系人
+ (BOOL) editCommonPassenger:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;



//编辑常用联系人 新方法
+ (BOOL) editCommonPassengerWithPassengerData:(CommonContact *) passengerData  andDelegate:(id<ServiceDelegate>)delegate;


//删除常用联系人

+ (BOOL) deleteCommonPassengerWithPassengerId:(NSString *) passengerId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate;



//找回密码操作
//找回密码操作

+ (BOOL) findPasswd_getSecrectCode:(NSString *) mobile andDelegate:(id<ServiceDelegate>) delegate;
+ (BOOL) findPasswd_VerCodeIsRight:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate;

+ (BOOL) findPassWd_ResetPassWdWithNewPwd:(NSString *) newPwd mobile:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate;




//用心愿旅行卡充值
+ (BOOL) makeAccountFullWithRechargeCardNo:(NSString *) cardNo cardPasswd:(NSString *) pwd andDelegate:(id<ServiceDelegate>) delegate;



//修改密码
+ (BOOL) updatePassWdWithOldPasswd:(NSString *) oldPasswd newPasswd:(NSString *) newPasswd andDelegate:(id<ServiceDelegate>) delegate;


//个人中心优惠券查询
+ (Boolean) getCouponListWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;



//获取订单列表

+ (BOOL) getOrderListWithCurrentPage:(NSString *) currentPage rowsOfPage:(NSString *) page  andDelegate:(id<ServiceDelegate>) delegate;


@end
