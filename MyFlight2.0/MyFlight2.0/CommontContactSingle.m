//
//  CommontContactSingle.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/25/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "CommontContactSingle.h"
#import "CommonContact.h"
@implementation CommontContactSingle



- (id) init{
    
    if (self=[super init]) {
        
        
        _commonPassengerData = [[CommonContact alloc] init];
        _passengerArray = [[NSMutableArray alloc] init];
        
        
    }
    
    
    return self;
    
}


+ (id) shareCommonContact{
    
    static CommontContactSingle *single = nil;
    if (single==nil) {
        
        
        single = [[CommontContactSingle alloc] init];
        
    }
    
    return single;
    
    
}
@end
