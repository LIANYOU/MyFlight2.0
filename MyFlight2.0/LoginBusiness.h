//
//  LoginBusiness.h
//  MyFirstApp
//
//  Created by Davidsph on 12/18/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface LoginBusiness : NSObject

@property(nonatomic,assign)id<ServiceDelegate> delegate;

//登录
- (void) loginWithName:(NSString *) name password:(NSString *) passwd andDelegate:(id<ServiceDelegate>) delegate;


//注册 
- (void) registerWithAccount:(NSString *) name password:(NSArray *) passwd andDelegate:(id<ServiceDelegate>) delegate;

//查询账号信息
- (void) getAccountInfo:(NSString *) info andDelegate:(id<ServiceDelegate>) delegate;



@end
