//
//  IsLoginInSingle.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserAccount;
@interface IsLoginInSingle : NSObject

@property(nonatomic,assign)BOOL isLogin; //记录用户是否已经登陆 
@property(nonatomic,retain)NSString *token; //令牌


//用户账号信息
@property(nonatomic,retain)UserAccount *userAccount;

+(id) shareLoginSingle;

- (void) initUserDefault;


//更新登录状态
- (void) updateUserDefault;
@end
