//
//  isFrequentPassengerLogin.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrequentPassengerData.h"
#import "LiChengDetailData.h"
@interface isFrequentPassengerLogin : NSObject

@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,retain)FrequentPassengerData *frequentPassData;
@property(nonatomic,retain)LiChengDetailData *lichengData;
@property(nonatomic,retain)NSMutableArray *lichengResultArray;
+(id) shareFrequentPassLogin;


@end
