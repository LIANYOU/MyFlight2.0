//
//  AirPortDataBase.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortDataBase : NSObject


//初始化数据库 
+(void) initDataBase;


//查找所有的热门机场 
+ (NSMutableDictionary *) findAllHotAirPorts;
+(NSMutableDictionary *) findAllCitiesAndAirPorts;

@end
