//
//  UserAccount.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/17/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户账号信息 
@interface UserAccount : NSObject



@property(nonatomic,retain)NSString *memberId; //用户ID
@property(nonatomic,retain)NSString *code; //会员编号
@property(nonatomic,retain)NSString *name; //联系人
@property(nonatomic,retain)NSString *birthday; //出生日期
@property(nonatomic,retain)NSString *email; //账户名
@property(nonatomic,retain)NSString *sex; //性别
@property(nonatomic,retain)NSString *account; // 资金账户
@property(nonatomic,retain)NSString *xinlvGoldMoeny; //新旅金币
@property(nonatomic,retain)NSString *xinlvSilverMoney; //新旅银币
@property(nonatomic,retain)NSString *mobile; //手机号
@property(nonatomic,retain)NSString *addr; //详细地址
@property(nonatomic,retain)NSString  *cardNo; //会员卡号
@property(nonatomic,retain)NSString  *cardType; //会员卡类型
@property(nonatomic,retain)NSString *serviceCode; //注册客户端 01my机票 02 西部航空 03 海航汇
@property(nonatomic,retain)NSString *source; //注册来源 标识用户是在哪家客户端注册的 
@property(nonatomic,retain)NSString *orgSource; //会员所属于 具体会员来源 51YOU PGS HU FFP 金鹏会员










@end
