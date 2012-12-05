//
//  AppContext.m
//  Camellia
//
//  Created by sss on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppContext.h"
#import "MockServiceShell.h"

static MockServiceShell* _serviceShell = nil;

static NSMutableArray* _delegates = nil;

@implementation AppContext



+(id <ServiceShell>) serviceShell {
    
    if (_serviceShell == nil) {
        _serviceShell = [[MockServiceShell alloc] init];
        [_serviceShell retain];
    }
    
    
    return _serviceShell;
}


//
+(void) addDelegate:(id <ServiceShellDelegate>) delegate {
    
    if (_delegates == nil) {
        
        _delegates = [[NSMutableArray alloc] init];
        
        
//        [_delegates retain];
        
    }
    
    
    [_delegates addObject:delegate];
}




+(NSArray*) delegates {
    return _delegates;
}

@end
