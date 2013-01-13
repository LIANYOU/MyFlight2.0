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
- (void) loginWithName:(NSString *)name password:(NSString *)passwd andDelegate:(id<ServiceDelegate>)delegate{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    [dic setObject:name forKey:KEY_Login_Account];
    [dic setObject:passwd forKey:KEY_Login_Pwd];
    
    [LoginInNetworkHelper requestWithUrl:dic delegate:delegate];
    
    [dic release];
    
   
    
}

//新浪微博登陆
-(void) loginWithOAuth:(NSMutableDictionary *) userInfo andDelegate:(id<ServiceDelegate>)delegate{
    [LoginInNetworkHelper submitOAuthDateToServer:userInfo delegate:delegate];
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
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    
   
    
    [dic setObject:memberId forKey:@"memberId"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:sex forKey:@"sex"];
    [dic setObject:address forKey:@"address"];
    
    [LoginInNetworkHelper editAccountInfo:dic delegate:delegate];
    [dic release];
    
    
    
}




//获取验证码

- (void) getSecretCode:(NSString *) receivedMobile requestType:(NSString *) type andDelegate:(id<ServiceDelegate>) delegate{
    

//    NSString *mobileNumber = [bodyDic objectForKey:KEY_Account_Mobile];
//    NSString *type = [bodyDic objectForKey:KEY_GETCode_RequestType];

    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    [dic setObject:receivedMobile forKey:KEY_Account_Mobile];
    [dic setObject:type forKey:KEY_GETCode_RequestType];
    
    NSLog(@"在处理业务层 获取用户输入：%@",receivedMobile);
    [LoginInNetworkHelper getSecretCode:dic andDelegat:delegate];
    
    [dic release];
     
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



//编辑常用联系人 新方法
- (void) editCommonPassengerWithPassengerData:(CommonContact *) passengerData  andDelegate:(id<ServiceDelegate>)delegate{
    
   
    

    [LoginInNetworkHelper editCommonPassengerWithPassengerData:passengerData andDelegate:delegate];
    
    
    
}




//删除常用联系人
- (void) deleteCommonPassengerWithPassengerId:(NSString *) passengerId userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate{
    
    
   
    
    [LoginInNetworkHelper deleteCommonPassengerWithPassengerId:passengerId userDic:passengerInfo andDelegate:delegate];
    
}



//增加常用联系人
- (void) addCommonPassengerWithPassengerName:(NSString *) name type:(NSString *) type certType:(NSString *) certType certNo:(NSString *)certNo userDic:(NSDictionary *)passengerInfo andDelegate:(id<ServiceDelegate>) delegate{
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
//    封装数据
    [dic setObject:name forKey:KEY_Passenger_Name];
    [dic setObject:type forKey:KEY_Passenger_Type];
    [dic setObject:certType forKey:KEY_Passenger_CertType];
    [dic setObject:certNo forKey:KEY_Passenger_CertNo];
    
    
        
    [LoginInNetworkHelper addCommonPassenger:dic delegate:delegate];
    
    
}



//增加联系人新方法
- (void) addCommonPassengerWithPassengerData:(CommonContact *) passengerData  andDelegate:(id<ServiceDelegate>)delegate{
    
    
    [LoginInNetworkHelper addCommonPassengerWithPassengerData:passengerData andDelegate:delegate];
    
    
}






//找回密码操作

- (void) findPasswd_getSecrectCode:(NSString *) mobile andDelegate:(id<ServiceDelegate>) delegate{
    
   
    
    [LoginInNetworkHelper findPasswd_getSecrectCode:mobile andDelegate:delegate];
    
    
    
}


- (void) findPasswd_VerCodeIsRight:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate{
    
    
    [LoginInNetworkHelper findPasswd_VerCodeIsRight:mobile code:code andDelegate:delegate];
    
      
}

- (void) findPassWd_ResetPassWdWithNewPwd:(NSString *) newPwd mobile:(NSString *) mobile code:(NSString *) code andDelegate:(id<ServiceDelegate>) delegate{
    
    [LoginInNetworkHelper findPassWd_ResetPassWdWithNewPwd:newPwd mobile:mobile code:code andDelegate:delegate];
    
}


//心愿旅行卡 充值
- (void) makeAccountFullWithRechargeCardNo:(NSString *) cardNo cardPasswd:(NSString *) pwd andDelegate:(id<ServiceDelegate>) delegate{
    
    [LoginInNetworkHelper makeAccountFullWithRechargeCardNo:cardNo cardPasswd:pwd andDelegate:delegate];
 
}



- (void) updatePassWdWithOldPasswd:(NSString *) oldPasswd newPasswd:(NSString *) newPasswd andDelegate:(id<ServiceDelegate>) delegate{
    
    
    [LoginInNetworkHelper updatePassWdWithOldPasswd:oldPasswd newPasswd:newPasswd andDelegate:delegate];
}

//个人中心优惠券查询
- (void) getCouponListWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate{
    
    
    [LoginInNetworkHelper getCouponListWithMemberId:memberId andDelegate:delegate];
    
    
}



//获取订单列表

- (void) getOrderListWithCurrentPage:(NSString *) currentPage rowsOfPage:(NSString *) page  andDelegate:(id<ServiceDelegate>) delegate{
    
    
    
    [LoginInNetworkHelper getOrderListWithCurrentPage:currentPage rowsOfPage:page andDelegate:delegate];
    
    
}


@end
