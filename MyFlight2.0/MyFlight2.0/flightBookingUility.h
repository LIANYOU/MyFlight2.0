//
//  flightBookingUility.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_flightBookingUility_h
#define MyFlight2_0_flightBookingUility_h


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

#define KEY_FlightBook_goInsuranceNum @"goInsuranceNum" //去程保险数

#define KEY_FlightBook_returnInsuranceNum @"returnInsuranceNum" //返程保险数



//机票信息

#define KEY_FlightBook_FlightVo__aircraftType_WithType(type)  [NSString stringWithFormat:@"booking%@FlightVo.aircraftType",type]  //机型

#define KEY_FlightBook_FlightVo_airlineCompanyCode_WithType(type) [NSString stringWithFormat:@"booking%@FlightVo.airlineCompanyCode",type]  //航空公司code

#define KEY_FlightBook_FlightVo_arrivalAirportCode_WithType [NSString stringWithFormat:@"booking%@FlightVo.arrivalAirportCode",type]  //到达机场code



#define KEY_FlightBook_FlightVo_arrivalDateStr_WithType [NSString stringWithFormat:@"booking%@FlightVo.arrivalDateStr",type]  //到达日期（2010-12-20）


#define KEY_FlightBook_FlightVo_arrivalTimeStr_WithType [NSString stringWithFormat:@"booking%@FlightVo.arrivalTimeStr",type]  //到达时间（11:35）



#define KEY_FlightBook_FlightVo_cabinCode_WithType [NSString stringWithFormat:@"booking%@FlightVo.cabinCode",type]  //舱位编码


#define KEY_FlightBook_FlightVo_departureDateStr_WithType [NSString stringWithFormat:@"booking%@FlightVo.departureDateStr",type]  //出发机场code


#define KEY_FlightBook_FlightVo_departureTimeStr_WithType [NSString stringWithFormat:@"booking%@FlightVo.departureTimeStr",type]  //起飞日期（2010-12-20）

#define KEY_FlightBook_FlightVo_flightNo_WithType [NSString stringWithFormat:@"booking%@FlightVo.flightNo",type]  //航班号




#define KEY_FlightBook_FlightVo_flightType_WithType [NSString stringWithFormat:@"booking%@FlightVo.flightType",type]  //1 单程 2 返程 3 联程

#define KEY_FlightBook_FlightVo_orderType_WithType [NSString stringWithFormat:@"bookingGoFlightVo.orderType",type]  //订单类型0：订单 1：改签单 2议价单

#define KEY_FlightBook_FlightVo_prodType_WithType [NSString stringWithFormat:@"booking%@FlightVo.prodType",type]  //航班类型 0,普通，1议价 2团购7三折申请4公务机5官网6超值

#define KEY_FlightBook_FlightVo_rmk_WithType [NSString stringWithFormat:@"booking%@FlightVo.rmk",type]  //备注




#define KEY_FlightBook_FlightVo_ticketType_WithType [NSString stringWithFormat:@"booking%@FlightVo.ticketType",type]  //机票类型 0：普通票；1：团购票2:议价票 目前填0即可

#define KEY_FlightBook_FlightVo_flightOrgin_WithType [NSString stringWithFormat:@"booking%@FlightVo.flightOrgin",type]  //返程航班政策来源

//机票联系人信息

#define KEY_FlightBook_flightContactVo_email @"flightContactVo.email"


#define KEY_FlightBook_flightContactVo_mobile @"flightContactVo.mobile"


#define KEY_FlightBook_flightContactVo_name @"flightContactVo.name"





//乘客信息

#define KEY_FlightBook_flightPassengerVo













#define KEY_FlightBook_FlightVo_

#define KEY_FlightBook_FlightVo_




#endif
