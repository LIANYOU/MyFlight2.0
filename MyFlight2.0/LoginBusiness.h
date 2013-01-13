//
//  LoginBusiness.h
//  MyFirstApp
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
#import "CommonContact.h"

@interface LoginBusiness : NSObject

@property(nonatomic,assign)id<ServiceDelegate> delegate; 

//登录
- (void) loginWithName:(NSString *) name password:(NSString *) passwd andDelegate:(id<ServiceDelegate>) delegate;

//第三方登陆
-(void) loginWithOAuth:(NSMutableDictionary *) userInfo andDelegate:(id<ServiceDelegate>)delegate;

//注册 
- (void) registerWithAccount:(NSString *) name password:(NSString *) passwd yaCode:(NSString *)yzCode andDelegate:(id<ServiceDelegate>) delegate;

//查询账号信息
- (void) getAccountInfoWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;

//编辑账号信息
- (void) editAccountInfoWithMemberId:(NSString *) memberId userName:(NSString *) name userSex:(NSString *) sex userAddress:(NSString *) address  andDelegate:(id<ServiceDelegate>) delegate;


//获取验证码

- (void) getSecretCode:(NSString *) receivedMobile requestType:(NSString *) type andDelegate:(id<ServiceDelegate>) delegate;


//查询常用联系人
- (void) getCommonPassengerWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate;

//编辑常用联系人 
- (void) editCommonPassengerWithMemberId:(NSString *) memberId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate  NS_DEPRECATED_IOS(3_0, 4_0);

//编辑常用联系人 新方法
- (void) editCommonPassengerWithPassengerData:(CommonContact *) passengerData  andDelegate:(id<ServiceDelegate>)delegate ;


//增加常用联系人
- (void) addCommonPassengerWithPassengerName:(NSString *) name type:(NSString *) type certType:(NSString *) certType certNo:(NSString *)certNo userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate NS_DEPRECATED_IOS(2_0, 3_0);





//增加联系人新方法
- (void) addCommonPassengerWithPassengerData:(CommonContact *) passengerData  andDelegate:(id<ServiceDelegate>)delegate ; 


//删除常用联系人
- (void) deleteCommonPassengerWithPassengerId:(NSString *) passengerId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate;


//找回密码操作

- (void) findPasswd_getSecrectCode:(NSString *) mobile andDelegate:(id<ServiceDelegate>) delegate;
//验证验证码 
- (void) findPasswd_VerCodeIsRight:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate;


//重置密码

- (void) findPassWd_ResetPassWdWithNewPwd:(NSString *) newPwd mobile:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate;




//修改密码

- (void) updatePassWdWithOldPasswd:(NSString *) oldPasswd newPasswd:(NSString *) newPasswd andDelegate:(id<ServiceDelegate>) delegate;




//心愿旅行卡 充值

- (void) makeAccountFullWithRechargeCardNo:(NSString *) cardNo cardPasswd:(NSString *) pwd andDelegate:(id<ServiceDelegate>) delegate;

//个人中心优惠券查询  方法已废弃  使用一个独立的 代替


- (void) getCouponListWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate NS_DEPRECATED_IOS(2_0, 3_0);



//- (void) makeAccountFullWith 

//获取订单列表

- (void) getOrderListWithCurrentPage:(NSString *) currentPage rowsOfPage:(NSString *) page  andDelegate:(id<ServiceDelegate>) delegate;



@end
