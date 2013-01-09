//
//  OrderDatabase.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderListModelData.h"
@interface OrderDatabase : NSObject


+ (BOOL) addOrderInfo_UnLogin:(OrderListModelData *) contactData;

+ (NSMutableArray *) findAllOrderInfo;

@end
