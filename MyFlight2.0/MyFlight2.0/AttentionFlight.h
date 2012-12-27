//
//  AttentionFlight.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-25.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionFlight : NSObject

@property(nonatomic,retain)NSDictionary * dictionary;  // 请求返回的数据转换成字典进行解析
@property(nonatomic,retain)NSData * allData;           // 保存请求返回的数据


@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * orgSource;
@property (nonatomic, retain) NSString * fno;
@property (nonatomic, retain) NSString * fdate;
@property (nonatomic, retain) NSString * dpt;
@property (nonatomic, retain) NSString * arr;
@property (nonatomic, retain) NSString * dptTime;
@property (nonatomic, retain) NSString * arrTime;
@property (nonatomic, retain) NSString * dptName;
@property (nonatomic, retain) NSString * arrName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * sendTo;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * hwId;
@property (nonatomic, retain) NSString * serviceCode;

-(id) initWithMemberId:(NSString *)memberId
          andorgSource:(NSString *)orgSource
                andFno:(NSString *)fno
              andFdate:(NSString *)fdate
                andDpt:(NSString *)dpt
                andArr:(NSString *)arr
            andDptTime:(NSString *)dptTime
            andArrTime:(NSString *)arrTime
            andDptName:(NSString *)dptName
            andArrName:(NSString *)arrName
               andType:(NSString *)type
             andSendTo:(NSString *)sendTo
            andMessage:(NSString *)message
              andToken:(NSString *)token
             andSource:(NSString *)source
               andHwId:(NSString *)hwId
        andServiceCode:(NSString *)serviceCode;

-(void)lookFlightAttention;

@end
