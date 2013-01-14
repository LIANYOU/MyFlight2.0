//
//  MyOrderListSingleDataSave.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/14/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderListSingleDataSave : NSObject



@property(nonatomic,retain)NSMutableArray *allPayList; //所有的
@property(nonatomic,retain)NSMutableArray *noPayList; //未支付
@property(nonatomic,retain)NSMutableArray *alradyPayList; //已支付





+ (id) shareMyOrderListSingleDataSave;





@end
