//
//  LoginInNetworkHelper.h
//  JOSNAndTableView
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 david. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"

@interface LoginInNetworkHelper : NSObject

//登录操作 
+ (BOOL) requestWithUrl:(NSDictionary *) bodyDic delegate:(id<ServiceDelegate>) delegate;

//注册操作 
+ (BOOL) registerWithUrl:(NSDictionary *) param delegate:(id<ServiceDelegate>) delegate;

//查看账号信息 
+ (BOOL) getAccountInfo:(NSDictionary *) param delegate:(id<ServiceDelegate>) delegate;

@end
