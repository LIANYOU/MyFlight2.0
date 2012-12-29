//
//  flightBookingUility.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_flightBookingUility_h
#define MyFlight2_0_flightBookingUility_h





#define Flight_DebugFlag true




#define FlightBook_URL_Index @"/web/phone/order/flight/flightBooking.jsp"

//机票预订请求的url 
#define FlightBook_URL  GET_RIGHT_URL_WITH_Index(FlightBook_URL_Index)

#define FlightBooking_Type_Go @"Go" //去程

#define FlightBooking_Type_Return @"Return" //返程




//机票预订 杂项 
#define KEY_FlightBook_prodType @"prodType"  //类型 0：单程航班；1：往返航班 2:机+酒

#define KEY_FlightBook_rmk @"rmk"  //0备注


#define KEY_FlightBook_source @"source" //订单来源（iphone或android）

#define KEY_FlightBook_timeSign @"timeSign" //时间戳 

#define KEY_FlightBook_consumptionType @"consumptionType" //消费类型:P私事 B公事


#define KEY_FlightBook_assistBook @"assistBook" //预定类型，取值1或0,表示代客或自助

#define KEY_FlightBook_passengerNum @"passengerNum" //乘客信息条数

//#define KEY_FlightBook_goInsuranceNum @"goInsuranceNum" //去程保险数
//
//#define KEY_FlightBook_returnInsuranceNum @"returnInsuranceNum" //返程保险数



#define FlightBook_TarvelType_Go @"Go"

#define FlightBook_TarvelType_Return @"Return"

//机票信息

#define KEY_FlightBook_FlightVo__aircraftType_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.aircraftType",type]   //机型

#define KEY_FlightBook_FlightVo_airlineCompanyCode_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.airlineCompanyCode",type]  //航空公司code


#define KEY_FlightBook_FlightVo_arrivalAirportCode_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.arrivalAirportCode",type]  //到达机场code



#define KEY_FlightBook_FlightVo_arrivalDateStr_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.arrivalDateStr",type]  //到达日期（2010-12-20）

#define KEY_FlightBook_FlightVo_arrivalTerminal_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.arrivalTerminal",type]  // 到达机场航站 可不填 


#define KEY_FlightBook_FlightVo_arrivalTimeStr_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.arrivalTimeStr",type]  //到达时间（11:35）



#define KEY_FlightBook_FlightVo_cabinCode_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.cabinCode",type]  //舱位编码


#define KEY_FlightBook_FlightVo_departureAirportCode_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.departureAirportCode",type]  //出发机场code


#define KEY_FlightBook_FlightVo_departureDateStr_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.departureDateStr",type]  //起飞日期（2010-12-20）



#define KEY_FlightBook_FlightVo_departureTimeStr_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.departureTimeStr",type]  //起飞时间（08：10）

#define KEY_FlightBook_FlightVo_flightNo_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.flightNo",type]  //航班号




#define KEY_FlightBook_FlightVo_flightType_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.flightType",type]  //1 单程 2 返程 3 联程

#define KEY_FlightBook_FlightVo_orderType_WithType(type)[NSString stringWithFormat:@"booking%@FlightVo.orderType",type]  //订单类型0：订单 1：改签单 2议价单

#define KEY_FlightBook_FlightVo_prodType_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.prodType",type]  //航班类型 0,普通，1议价 2团购7三折申请4公务机5官网6超值

#define KEY_FlightBook_FlightVo_rmk_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.rmk",type]  //备注




#define KEY_FlightBook_FlightVo_ticketType_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.ticketType",type]  //机票类型 0：普通票；1：团购票2:议价票 目前填0即可

#define KEY_FlightBook_FlightVo_flightOrgin_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.flightOrgin",type]  //返程航班政策来源

//机票联系人信息

#define KEY_FlightBook_flightContactVo_email @"flightContactVo.email"


#define KEY_FlightBook_flightContactVo_mobile @"flightContactVo.mobile"


#define KEY_FlightBook_flightContactVo_name @"flightContactVo.name"




//行程单信息
#define KEY_FlightBook_flightItineraryVo_deliveryType @"flightItineraryVo.deliveryType" //配送方式 0:无需配送(低碳出行) 1：快递2:挂号信  3:机场自取


#define KEY_FlightBook_flightItineraryVo_address @"flightItineraryVo.address" //收信地址


#define KEY_FlightBook_flightItineraryVo_city @"flightItineraryVo.city" //城市

#define KEY_FlightBook_flightItineraryVo_mobile @"flightItineraryVo.mobile" //电话

#define KEY_FlightBook_flightItineraryVo_postCode @"flightItineraryVo.postCode" //邮政编码

#define KEY_FlightBook_flightItineraryVo_catchUser @"flightItineraryVo.catchUser" //收信人


#define KEY_FlightBook_flightItineraryVo_isPromptMailCost @"flightItineraryVo.isPromptMailCost" //预订成功后，是否提示邮递费用	默认为空（指的是旧版本）,以后开发的版本必须设置为0


//乘客信息

//乘客id  登录用户选择成人时有值
#define KEY_FlightBook_flightPassengerVo_flightPassengerId(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.flightPassengerId",index];

//乘客姓名
#define KEY_FlightBook_flightPassengerVo_name(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.name",index];

//证件号码
#define KEY_FlightBook_flightPassengerVo_certNo(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.certNo",index];


//证件类型
#define KEY_FlightBook_flightPassengerVo_certType(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.certType",index];


//乘客类型 ：02儿童 01成人
#define KEY_FlightBook_flightPassengerVo_type(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.type",index];

//去程保险数
#define KEY_FlightBook_goInsuranceNum(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.goInsuranceNum",index];

//返程保险数
#define KEY_FlightBook_returnInsuranceNum(index) [NSString stringWithFormat:@"flightPassengerVoList[%d].flightPassengerVo.returnInsuranceNum",index];



//payNo isNeedPayPwd

 
#define KEY_FlightBook_payVo_isNeedPayPwd @"payVo.isNeedPayPwd"  // 是否需要密码 yes/no


#define KEY_FlightBook_payVo_isNeedAccount @"payVo.isNeedAccount" // 是否使用资金账户 金币支付 

#define KEY_FlightBook_payVo_payPassword @"payVo.payPassword" //  支付密码

#define KEY_FlightBook_payVo_captcha @"payVo.captcha" //优惠券id


#define KEY_FlightBook_payVo_needNotSilver @"payVo.needNotSilver"  //不需要使用银币



#endif
