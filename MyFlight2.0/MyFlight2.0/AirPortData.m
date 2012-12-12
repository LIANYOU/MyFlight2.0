//
//  AirPortData.m
//  JOSNAndTableView
//
//  Created by Davidsph on 12/11/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import "AirPortData.h"

@implementation AirPortData


- (id) initWithapCode:(NSString *)apCode apName:(NSString *)apName hotCity:(NSString *)hotCity cityName:(NSString *)cityName air_x:(NSString *)air_x air_y:(NSString *)air_y{
    
    if (self=[super init]) {
        
        self.apCode = apCode;
        self.apName = apName;
        self.hotCity = hotCity;
        self.cityName = cityName;
        self.air_x = air_x;
        self.air_y = air_y;
        
    }
    
    
    
    return self;
    
}
@end
