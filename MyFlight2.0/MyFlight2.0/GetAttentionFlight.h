//
//  GetAttentionFlight.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAttentionFlight : NSObject
 
@property (nonatomic,retain) NSString * memberId;  // 登陆用户
@property (nonatomic,retain) NSString * orgSource; // 会员来源
@property (nonatomic,retain) NSString * type;      // 定制类型（P，M）
@property (nonatomic,retain) NSString * token;     // 应用程序token
@property (nonatomic,retain) NSString * source;    // 来源  （0，1）
@property (nonatomic,retain) NSString * hwId;      // 硬件ID
@property (nonatomic,retain) NSString * serviceCode;//客户端来源  01My机票

-(id) initWithMemberId:(NSString *)memberId
          andOrgSource:(NSString *)orgSource
               andType:(NSString *)type
              andToken:(NSString *)token
             andSource:(NSString *)source
               andHwid:(NSString *)hwid
        andServiceCode:(NSString *)serviceCode;

-(void)getAttentionFlight;

@end
