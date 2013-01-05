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


//查询 里程

+ (BOOL)getMemberPointInfoWithCardNo:(NSString *) cardNo passwd:(NSString *) pwd ndDelegate:(id<ServiceDelegate>) delegate;



//累积标准查询

//+ (BOOL) GetPointstoTicket

@end
