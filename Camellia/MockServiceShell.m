//
//  MockServiceShell.m
//  Camellia
//
//  Created by sss on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MockServiceShell.h"
#import "AppContext.h"
#import "ServiceShellDelegate.h"

@implementation MockServiceShell

-(void) loginWithUserName:(NSString *)userName andPassword:(NSString *)password {
    
    //
    for (id <ServiceShellDelegate> delegate in [AppContext delegates]) {
        [delegate loginDidComplete:YES];
    }
}

@end
