//
//  MyCenterUility.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_MyCenterUility_h
#define MyFlight2_0_MyCenterUility_h

#import "DNWrapper.h"





#define KEY_PLAIN @"plain"
#define KEY_SIGN @"sign"

#define GET_SIGN(string)  [DNWrapper md5:(string)]



//登陆url
#define LOGIN_URL_Index  @"/web/phone/login.jsp"

//拼接完成可用
#define LOGIN_URL GET_RIGHT_URL_WITH_Index(LOGIN_URL_Index)

//第三方登陆后，提交信息url
#define OAUTHINFOCOMIT_URL_INDEX @"/web/phone/member/thirdPartyLogin.jsp"
#define OAUTHINFOCOMIT_URL GET_RIGHT_URL_WITH_Index(OAUTHINFOCOMIT_URL_INDEX)

#define KEY_Login_Account @"account" //登录账号
#define KEY_Login_Pwd @"pwd" //登陆密码
#define KEY_Login_Type @"type" //登录类型
#define Login_Type_Value @"01" //类型值 





//注册URL
#define REGISTER_URL_Index  @"/web/phone/register.jsp"
#define REGISTER_URL GET_RIGHT_URL_WITH_Index(REGISTER_URL_Index)

#define KEY_Register_Account @"account" 
#define KEY_Register_Pwd @"pwd"
#define KEY_Register_Pwd2 @"pwd2"
#define KEY_Register_YZCode @"yzCode"








//参看账号信息

#define Account_SearchInfo_URL_Index  @"/web/phone/member/member_info_search.jsp"

#define Account_SearchInfo_URL  GET_RIGHT_URL_WITH_Index(Account_SearchInfo_URL_Index)




//GET_RIGHT_URL_WITH_Index(Account_SearchInfo_URL_Index)



//http://test.51you.com/web/phone/member/member_info_update.jsp

//更新账号信息

#define UPDATE_AccountInfo_index @"/web/phone/member/member_info_update.jsp"

#define UPDATE_AccountInfo_URL  GET_RIGHT_URL_WITH_Index(UPDATE_AccountInfo_index)







//账号名字 13161188680
#define  MEMBER_ID_VALUE @"8bd77e59748843f38eba1df706db5303"
#define Token_VALUE @"BAAF850EB16691BB6CEA73C7C6A26FF6"

//用户信息相关的常量
#define KEY_Account_Name @"name"
#define  KEY_Account_MemberId @"memberId"
#define KEY_Account_Email @"email"
#define KEY_Account_token @"token"
#define KEY_Account_Mobile @"mobile"
#define KEY_Account_Password @"pwd"
#define KEY_Account_Code @"code"



//获取手机验证码

#define Get_SecretCode_index @"/web/phone/sendValidaMsg.jsp"

#define  URL_GetSecretCodeUrl  GET_RIGHT_URL_WITH_Index(Get_SecretCode_index)

#define KEY_GETCode_RequestType @"GetCodeRequestType"

//获取密码的类型
#define GETCode_ForRegist_Value @"regist" //注册用 获取验证码
#define GetCode_ForFindPassWd_Value @"findPwd" //找回密码
#define GetCode_forPayPwd_Value @"findPayPwd" //支付验证码

//获取请求的类型

#define KEY_Request_Type @"requestType"



//获取验证码的请求 
//#define KEY_GET_SecretCode_RequestType @"GetSecretCodeKey"

#define GET_SecretCode_RequestType_Value @"GetSecretCodeType"

//注册的请求
//#define KEY_Regist_RequestType @"RegistRequestKey"
#define Regist_RequestType_Value  @"RegistRequestType"






//登录的处理类型

#define Login_Success_ReturnMyCenterDefault_Type  @"MycenterType"

#define Login_Success_ReturnWhereItComes @"GotoWhereItComes"

enum  {
    isGoToMyCentertype,
    backToWhereItComes
    }LoginType;




//常用乘机人查询

#define SearchCommomPassenger_URL_index @"/web/phone/prod/flight/memberPassengerSearch.jsp"
#define SearchCommomPassenger_URL  GET_RIGHT_URL_WITH_Index(SearchCommomPassenger_URL_index)


//常用联系人增加
#define AddCommomPassenger_URL_index  @"/web/phone/prod/flight/memberPassengerAdd.jsp"

#define AddCommomPassenger_URL  GET_RIGHT_URL_WITH_Index(AddCommomPassenger_URL_index)




//常用联系人删除


#define DeleteCommomPassenger_URL_index @"/web/phone/prod/flight/memberPassengerDel.jsp"

#define DeleteCommomPassenger_URL GET_RIGHT_URL_WITH_Index(DeleteCommomPassenger_URL_index)

//常用联系人编辑
 
#define UpdateCommomPassenger_URL_index @"/web/phone/prod/flight/memberPassengerUpdate.jsp"


#define UpdateCommomPassenger_URL  GET_RIGHT_URL_WITH_Index(UpdateCommomPassenger_URL_index)













//找回密码操作

//找回密码的key 参数说明 key为新华旅行分配的唯一码

#define VER_CodeISRight_RequestType_Value @"codeIsRight"

#define FindPasswd_Key_Value @"xxx"

#define FindPasswd_URL_Index @"/web/phone/common/find_pwd.jsp"


#define FindPasswd_URL  GET_RIGHT_URL_WITH_Index(FindPasswd_URL_Index)


//验证码密码 url
#define Ver_CodeIsRight_URL_Index @"/web/phone/member/verCodeIsRight.jsp"

#define Ver_CodeIsRight_URL GET_RIGHT_URL_WITH_Index(Ver_CodeIsRight_URL_Index)


//重置密码 找回密码
#define FindPwd_ResetPwd_URL_Index @"/web/phone/member/get_password.jsp"

#define FindPwd_ResetPwd_URL  GET_RIGHT_URL_WITH_Index(FindPwd_ResetPwd_URL_Index)




//修改密码
#define Update_Passwd_URL_Index @"/web/phone/member/member_password_update.jsp"


#define Update_Passwd_URL GET_RIGHT_URL_WITH_Index(Update_Passwd_URL_Index)

//常用联系人 查询参数名称
#define KEY_Passenger_Name @"name"
#define KEY_Passenger_Type @"type"
#define KEY_Passenger_CertType @"certType"
#define KEY_Passenger_CertNo @"certNo"
#define KEY_Passenger_Id @"id"


//个人优惠券查询

#define Coupon_List_URL_Index  @"/web/phone/active/coupon/personList.jsp"

#define Coupon_List_URL GET_RIGHT_URL_WITH_Index(Coupon_List_URL_Index)

//优惠券激活接口
#define MakeCoupon_active_URL_Index @"/web/phone/active/coupon/activation.jsp"

#define MakeCoupon_active_URL GET_RIGHT_URL_WITH_Index(MakeCoupon_active_URL_Index)

//优惠券使用情况

#define KEY_CouponListOfUse @"use" //已使用

#define KEY_CouponListOfNoUse @"nouse" //未使用
#define KEY_CouponListOfOutOfDate @"outOfDate" //已过期









#endif
