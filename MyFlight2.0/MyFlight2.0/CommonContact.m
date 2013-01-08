//
//  CommonContact.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/17/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "CommonContact.h"

@implementation CommonContact



- (id) initWithName:(NSString *) name type:(NSString *) type certType:(NSString *) certType certNo:(NSString *) certNO contactId:(NSString *) contactId{
    
    if (self=[super init]) {
        
        self.name = name;
        self.type = type;
        self.certType = certType;
        self.certNo = certNO;
        self.contactId = contactId;
    }
    
    return self;
    
}
@end
