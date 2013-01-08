//
//  ProBooKResultData.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "ProBooKResultData.h"

@implementation ProBooKResultData

- (id) init{
    
    if (self=[super init]) {
        _allData =[[ProBookListData alloc] init];
        _listArray =[[NSMutableArray alloc] init];
        
        
        
    }
    return self;
}

@end
