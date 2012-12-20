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

@property(nonatomic,retain)NSMutableDictionary *correctAirPortsDic;

+ (id) shareAirPortBaseData;



@end
