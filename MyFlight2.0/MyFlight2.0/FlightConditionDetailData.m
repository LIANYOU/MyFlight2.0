//
//  FlightConditionDetailData.m
//  MyFlight2.0
//
//  Created by apple on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightConditionDetailData.h"

@implementation FlightConditionDetailData
-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.arrAirport = [dic valueForKey:@"arrAirport"];
        self.arrTime = [dic valueForKey:@"arrTime"];
        self.deptAirport = [dic valueForKey:@"deptAirport"];
        self.deptTime = [dic valueForKey:@"deptTime"];
        self.expectedArrTime = [dic valueForKey:@"expectedArrTime"];
        self.expectedDeptTime = [dic valueForKey:@"expectedDeptTime"];
        self.flightArrcode = [dic valueForKey:@"flightArrcode"];
        self.flightCompany = [dic valueForKey:@"flightCompany"];
        self.flightDepcode = [dic valueForKey:@"flightDepcode"];
        self.flightHTerminal = [dic valueForKey:@"flightHTerminal"];
        self.flightNum = [dic valueForKey:@"flightNum"];
        self.flightState = [dic valueForKey:@"flightState"];
        self.flightTerminal = [dic valueForKey:@"flightTerminal"];
        self.realArrTime = [dic valueForKey:@"realArrTime"];
        self.realDeptTime = [dic valueForKey:@"realDeptTime"];
        self.deptDate = [dic valueForKey:@"deptDate"];
    }
    return self;
}



-(void)dealloc{
    self.arrAirport = nil;
    self.arrTime = nil;
    self.deptAirport = nil;
    self.deptTime = nil;
    self.expectedArrTime = nil;
    self.expectedDeptTime = nil;
    self.flightArrcode = nil;
    self.flightCompany = nil;
    self.flightDepcode = nil;
    self.flightHTerminal = nil;
    self.flightNum = nil;
    self.flightState = nil;
    self.flightTerminal = nil;
    self.realArrTime = nil;
    self.realDeptTime = nil;
    self.deptDate = nil;
    [super dealloc];
}
@end
