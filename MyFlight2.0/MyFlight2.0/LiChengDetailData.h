//
//  LiChengDetailData.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiChengDetailData : NSObject

@property(nonatomic,retain)NSString *cardNo;
@property(nonatomic,retain)NSString *grade;
@property(nonatomic,retain)NSString *balance;
@property(nonatomic,retain)NSString *expireDate;  //积分过期日
@property(nonatomic,retain)NSString *airlinePoints; //航空里程
@property(nonatomic,retain)NSString *notAirlinePoints; //非航空里程
@property(nonatomic,retain)NSString *upgradePoints; //升级里程
@property(nonatomic,retain)NSString *upgradeSegments; //升级航段
@property(nonatomic,retain)NSString *expirePoints; // 过期积分
@property(nonatomic,retain)NSString *otherPoints;//其它积分
@end
