//
//  ProBookListData.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProBookListData : NSObject


@property(nonatomic,retain)NSString *code;
@property(nonatomic,retain)NSString *dpt;
@property(nonatomic,retain)NSString *arr;
@property(nonatomic,retain)NSString *dptCN;
@property(nonatomic,retain)NSString *arrCN;
@property(nonatomic,retain)NSString *discount;
@property(nonatomic,retain)NSString *startDate;
@property(nonatomic,retain)NSString *endDate;

@end


@interface flightListTemp : NSObject

@property(nonatomic,retain)NSString *diccount;
@property(nonatomic,retain)NSString *startDate;
@property(nonatomic,retain)NSString *price;

@end