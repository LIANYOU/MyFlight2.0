//
//  FrequentFlyNetWorkHelper.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface FrequentFlyNetWorkHelper : NSObject

//登录
+ (BOOL) loginWithName:(NSString *) name password:(NSString *) passwd andDelegate:(id<ServiceDelegate>) delegate;


@end
