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

//根据用户输入的条件查询 机场信息
+(NSMutableArray *) findAirPortByCondition:(NSString *) condition{
    
    NSMutableArray * resultDic = [[AirPortDataBase findAirPortByCondition:condition] retain];
    
    
   
    return  [resultDic autorelease];
}





//以分区的形式 来封装数据
- (NSMutableDictionary *) getCorrectGroupedAirportsInfo{
    
    //保存结果的 字典
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *resultHotDic = self.originHotAirPorts; //所有热门机场
    
    NSMutableDictionary *resultAllDic = self.originAllAirPorts; //所有的机场数据
    
    for(NSString *key in [resultAllDic allKeys]) {
        
        
        AirPortData *tmpData = [resultAllDic objectForKey:key];
        
        NSString *apName =tmpData.apEname;
        //        NSLog(@"apCode = %@",tmpData.apCode);
        
        //        NSLog(@"apName =%@",apName);
        
        NSString* letter = [[NSString stringWithFormat:@"%c", [apName characterAtIndex:0]] uppercaseString];
        
        
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
