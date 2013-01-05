//
//  FrequentPassengerData.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

//常旅客 信息 
@interface FrequentPassengerData : NSObject

@property(nonatomic,retain)NSString *cardNo;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *sex;
@property(nonatomic,retain)NSString *identifyType;
@property(nonatomic,retain)NSString *identifyNo;
@property(nonatomic,retain)NSString *email;


@end
