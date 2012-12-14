//
//  AirPortDataBaseSingleton.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "AirPortDataBaseSingleton.h"
#import "AirPortDataBase.h"
#import "AirPortData.h"

@implementation AirPortDataBaseSingleton


- (NSMutableDictionary *) getCorrectGroupedAirportsInfo{
    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *resultHotDic = self.originHotAirPorts;
    NSMutableDictionary *resultAllDic = self.originAllAirPorts;
    
    
    
    for (NSString *key in [resultAllDic allKeys]) {
        NSString* letter = [[NSString stringWithFormat:@"%c", [key characterAtIndex:0]] uppercaseString];
        NSMutableArray* section = [resultDic objectForKey:letter];
        
        if (!section) {
            section = [NSMutableArray array];
            [resultDic setObject:section forKey:letter];
        }
        
        AirPortData *data = [resultAllDic objectForKey:key];
        
        
        
        [section addObject:data];
        
    }
    
    for (NSString *key in [resultHotDic allKeys]) {
        
        NSString *keyValue =@"热门";
        
        NSMutableArray* section = [resultDic objectForKey:keyValue];
        
        if (!section) {
            section = [NSMutableArray array];
            [resultDic setObject:section forKey:keyValue];
        }
        
        AirPortData *data = [resultHotDic objectForKey:key];
        [section addObject:data];
        
    }


    return [resultDic autorelease];


}
- (id) init{
    
    if (self=[super init]) {
        
        _originAllAirPorts = [[NSMutableDictionary alloc] init];
        _originHotAirPorts = [[NSMutableDictionary alloc] init];
        _correctAirPortsDic = [[NSMutableDictionary alloc] init];
        
        
        self.originAllAirPorts = [AirPortDataBase findAllCitiesAndAirPorts];
        self.originHotAirPorts = [AirPortDataBase findAllHotAirPorts];
        
        self.correctAirPortsDic = [self getCorrectGroupedAirportsInfo];
               
        
    }
    
    return self;
}





+ (id) shareAirPortBaseData{
    static AirPortDataBaseSingleton *single = nil;
    
    if (single ==nil) {
        
        
        single = [[AirPortDataBaseSingleton alloc] init];
        
    }
    return single;
}

@end
