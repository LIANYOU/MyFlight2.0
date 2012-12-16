//
//  AirPortsUility.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_AirPortsUility_h
#define MyFlight2_0_AirPortsUility_h


//有关数据的操作 网络解析机场和城市数据 返回的各个字段的宏定义

#define URLForAirPortsAndCities @"http://test.51you.com/web/phone/prod/flight/airPortCitySearch.jsp"

#define KEY_DataBaseVersion  @"version"

#define KEY_airPortCount @"airPortCount"
#define KEY_airports @"airports"

#define KEY_apCode @"apCode"
#define KEY_apName @"apName"
#define KEY_apEName @"apEName"
#define KEY_apLName @"apLName"
#define KEY_hotCity @"hotcity"
#define KEY_cityName @"name"


//数据库的字段名字

#define Column_apCode  @"apCode"
#define Column_apName  @"apName"
#define Column_apEName  @"apEName"
#define Column_apLName  @"apLName"
#define Column_hotcity  @"hotcity"
#define Column_cityName  @"cityName"
#define Column_air_x  @"air_x"
#define Column_air_y  @"air_y"





#endif
