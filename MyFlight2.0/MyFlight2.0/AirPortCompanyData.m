//
//  AirPortCompanyData.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "AirPortCompanyData.h"

@implementation AirPortCompanyData


- (id) initWithCode:(NSString *)code shortName:(NSString *)shortName longName:(NSString *)longName tel:(NSString *)tel{
    
    
    if (self=[super init]) {
        
        self.code =code;
        self.shortName =shortName;
        self.longName =longName;
        self.tel =tel;
    }
    
    
    return self;
}

@end
