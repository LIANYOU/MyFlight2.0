//
//  CommontContactSingle.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/25/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommonContact;


@interface CommontContactSingle : NSObject

@property(nonatomic,retain)CommonContact *commonPassengerData;
@property(nonatomic,retain)NSMutableArray *passengerArray;

+ (id) shareCommonContact;

@end
