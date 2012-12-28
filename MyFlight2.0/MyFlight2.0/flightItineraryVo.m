//
//  flightItineraryVo.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "flightItineraryVo.h"

@implementation flightItineraryVo


- (id) initWithdeliveryType:(NSString *) deliveryType city:(NSString *)city address:(NSString *) address mobile:(NSString *) mobile postCode:(NSString *)postCode catchUser:(NSString *) catchUser{
    
    if (self = [super init]) {
        self.deliveryType = deliveryType;
        self.city = city;
        self.address = address;
        self.mobile = mobile;
        self.postCode = postCode;
        self.catchUser =catchUser;
        self.isPromptMailCost = @"0";
    
        
        
        
    }
    
    
    
    return self;
    
}
@end
