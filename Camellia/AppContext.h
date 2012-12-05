//
//  AppContext.h
//  Camellia
//
//  Created by sss on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppContextHandler.h"
#import "ServiceShell.h"

@interface AppContext : NSObject

+(id <ServiceShell>) serviceShell;

//添加代理
+(void) addDelegate:(id <ServiceShellDelegate>) delegate;

//返回协议
+(NSArray*) delegates;

@end
