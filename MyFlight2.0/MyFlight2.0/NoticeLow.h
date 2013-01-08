//
//  NoticeLow.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface NoticeLow : NSObject

@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) NSString * hwId;
@property (nonatomic, assign) id<ServiceDelegate> delegate;



-(id) initWithSource:(NSString *)source
         andMemberId:(NSString *)memberId
             andSign:(NSString *)sign
             andHwId:(NSString *)hwId
         andDelegate:(id<ServiceDelegate>)delegate;


-(void)getInfo;

@end
