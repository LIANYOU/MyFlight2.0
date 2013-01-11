//
//  PublicConstUrls.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_PublicConstUrls_h
#define MyFlight2_0_PublicConstUrls_h


#define WRONG_Message_NetWork @"请求遇到了错误，请您再试一次"


//用户的一些默认设置 保存在NSUserDefault里面

#define KEY_Default_AccountName @"userName"  //账号名字  供显示用 用户输入什么 记录什么
#define KEY_Default_Password @"user_password"  //账号密码 用户输入的密码
#define KEY_Default_MemberId @"user_memberId" 
#define KEY_Default_IsUserLogin @"isUser_Login"  //用户是否已经登录

#define KEY_Default_IsRememberPwd @"isRememberPwd" //是否记住密码 
#define KEY_Default_UserMobile @"userMobile" //手机号
#define KEY_Default_Code @"user_code" //用户code 
#define KEY_Default_Token  @"userToken" //token 
//


//用户memberId

#define Default_UserMemberId_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_MemberId]

//用户是否已经登录 
#define Default_IsUserLogin_Value  [[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsUserLogin]

//用户token
#define Default_Token_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_Token]


//账号名称 
#define Default_AccountName_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_AccountName]

//memberCode
#define Default_UserMemberCode_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_Code]

//公共返回结果字段标志

#define KEY_result  @"result"
#define KEY_resultCode  @"resultCode"
#define KEY_message @"message"



//公共参数字段 每个接口 都要用到的 参数
#define KEY_source @"source"  //来源字段
#define KEY_hwId  @"hwId" //硬件字段
#define KEY_serviceCode @"serviceCode" //服务代号字段
#define KEY_edition @"edition"  //接口版本号字段


//公共参数字段 默认参数
#define SOURCE_VALUE  @"xx"
#define HWID_VALUE  CURRENT_DEVICEID_VALUE
//当前硬件的唯一标识
#define CURRENT_DEVICEID_VALUE [UIDevice currentDevice].uniqueIdentifier
#define SERVICECode_VALUE @"01" 
#define EDITION_VALUE @"v1.0" 





#define PUBLIC_Parameter  [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",KEY_source,SOURCE_VALUE,KEY_hwId,HWID_VALUE,KEY_serviceCode,SERVICECode_VALUE,KEY_edition,EDITION_VALUE]

#define PUBLIC_Parameter_WithoutSource NSString stringWithFormat:@"&%@=%@&%@=%@&%@=%@",KEY_hwId,HWID_VALUE,KEY_serviceCode,SERVICECode_VALUE,KEY_edition,EDITION_VALUE]




//当前系统版本
#define CURRENT_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion integerValue]




#endif
