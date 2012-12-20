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

#define KEY_Login_Account @"account" //登录账号
#define KEY_Login_Pwd @"pwd" //登陆密码
#define KEY_Login_Type @"type" //登录类型
#define Login_Type_Value @"01" //类型值 





//注册URL
#define REGISTER_URL_Index  @"/web/phone/register.jsp"
#define REGISTER_URL GET_RIGHT_URL_WITH_Index(REGISTER_URL_Index)











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








#endif
