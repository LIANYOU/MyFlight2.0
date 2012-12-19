//
//  PublicConstUrls.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_PublicConstUrls_h
#define MyFlight2_0_PublicConstUrls_h

//公共返回结果字段标志

#define KEY_result  @"result"
#define KEY_resultCode  @"resultCode"
#define KEY_message @"message"


//公共参数字段 
#define KEY_source @"source"  //来源字段
#define KEY_hwId  @"hwId" //硬件字段
#define KEY_serviceCode @"serviceCode" //服务代号字段
#define KEY_edition @"edition"  //接口版本号字段 




//公共参数字段 默认参数

#define SOURCE @"xx"
//#define HWID  @""

//当前硬件的唯一标识 
#define CURRENT_DEVICEID [UIDevice currentDevice].uniqueIdentifier

#define SERVICECode @"01"
#define EDITION @"v1.0"



//当前系统版本
#define CURRENT_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion integerValue]


#endif
