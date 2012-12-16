//
//  AirPortDataBase.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPortDataBase : NSObject


+(void) initDataBase;
+ (NSMutableDictionary *) findAllHotAirPorts;
+(NSMutableDictionary *) findAllCitiesAndAirPorts;
@end
