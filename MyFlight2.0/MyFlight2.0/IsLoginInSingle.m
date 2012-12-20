//
//  IsLoginInSingle.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "IsLoginInSingle.h"
#import "UserAccount.h"
@implementation IsLoginInSingle


- (id) init{
    if (self=[super init]) {
        
        UserAccount *user = [[UserAccount alloc] init];
        self.userAccount  =user;
        _isLogin = false;
        [user release];
      }
    
    return self;
}

- (void) initUserDefault{
    
  
    
}

- (void) updateUserDefault{
    
    
    
}

+(id) shareLoginSingle{
    
    static IsLoginInSingle *single = nil;
    
    if (single==nil) {
        
        single = [[IsLoginInSingle alloc] init];
        
    }
    return single;
    
}



@end
