//
//  ProBooKResultData.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProBookListData.h"
@interface ProBooKResultData : NSObject

@property(nonatomic,retain)ProBookListData *allData;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,retain) NSMutableArray *listArray;

@end
