//
//  flightContactVo.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "flightContactVo.h"

@implementation flightContactVo


- (id) initWithName:(NSString *)newName Mobile:(NSString *) mobile email:(NSString *)email{
    if (self = [super init]) {
        
        self.name = newName;
        self.mobile = mobile;
        self.email = email;
     }
     return self;
}
@end
