//
//  CheckPassword.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-4.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface CheckPassword : NSObject 

@property (nonatomic,retain) NSString * memberId;    
@property (nonatomic,retain) NSString * source;
@property (nonatomic,retain) NSString * hwId;
@property (nonatomic,retain) NSString * sign;
@property (nonatomic,retain) NSString * edition;
@property (nonatomic,retain) NSString * passWord;

@property (nonatomic, assign) id<ServiceDelegate> delegate;

-(id) initWithMemberId:(NSString *)memberId
             andSource:(NSString *)source
               andHwId:(NSString * )hwId
           andPassWord:(NSString *)passWord
               andSign:(NSString *)sign
            andEdition:(NSString *)edition
           andDelegate:(id<ServiceDelegate>)delegate;


-(void) getPassword;

@end
