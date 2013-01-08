//
//  flightPassengerVo.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "flightPassengerVo.h"

@implementation flightPassengerVo

- (id) initWithType:(NSString *) type certType:(NSString *)certType name:(NSString *)name flightPassengerId:(NSString *) flightPassengerId certNo:(NSString *) certNo{
    
    if (self =[super init]) {
    
        self.type =type;
        self.certType = certType;
        self.name = name;
        self.flightPassengerId = flightPassengerId;
        self.certNo =certNo;
    }
     return self;
    
}


@end
