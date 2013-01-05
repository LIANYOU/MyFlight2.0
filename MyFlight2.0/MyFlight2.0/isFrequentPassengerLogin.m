//
//  isFrequentPassengerLogin.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "isFrequentPassengerLogin.h"

@implementation isFrequentPassengerLogin


- (id) init{
    
    
    if (self=[super init]) {
        
        _frequentPassData = [[FrequentPassengerData alloc] init];
        _lichengData = [[LiChengDetailData alloc] init];
        
    }
    return self;
}

+(id) shareFrequentPassLogin{
    
    static isFrequentPassengerLogin *single = nil;
    
    if (single==nil) {
        
        single = [[isFrequentPassengerLogin alloc] init];
        
    }
    
    
    return  single;
}
@end
