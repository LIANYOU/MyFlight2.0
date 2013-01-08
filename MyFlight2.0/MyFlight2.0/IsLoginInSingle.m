//
//  IsLoginInSingle.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "IsLoginInSingle.h"
#import "UserAccount.h"
#import "AppConfigure.h"
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
    
    self.isLogin =false;
    self.token = nil;
//    self.userAccount = nil;
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:KEY_Default_IsUserLogin];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_MemberId];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_Default_Token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id) shareLoginSingle{
    
    static IsLoginInSingle *single = nil;
    
    if (single==nil) {
        
        single = [[IsLoginInSingle alloc] init];
        
    }
    return single;
    
}



@end
