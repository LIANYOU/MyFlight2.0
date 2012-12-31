//
//  AirPortDataBaseSingleton.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortDataBaseSingleton : NSObject

//所有的原始热门机场数据
@property(nonatomic,retain)NSMutableDictionary *originHotAirPorts;

//所有机场数据
@property(nonatomic,retain)NSMutableDictionary *originAllAirPorts;


//正确的机场数据 按照顺序排列
@property(nonatomic,retain)NSMutableDictionary *correctAirPortsDic;



//根据用户输入的条件查询 机场信息 
+(NSMutableArray *) findAirPortByCondition:(NSString *) condition;


+ (id) shareAirPortBaseData;



@end
