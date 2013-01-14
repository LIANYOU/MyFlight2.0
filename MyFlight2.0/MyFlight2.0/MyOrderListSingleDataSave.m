//
//  MyOrderListSingleDataSave.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/14/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "MyOrderListSingleDataSave.h"

@implementation MyOrderListSingleDataSave

- (id) init{
    
    if (self=[super init]) {
        
        _allPayList =[[NSMutableArray alloc] init];
        _alradyPayList =[[NSMutableArray alloc] init];
        
        _noPayList =[[NSMutableArray alloc] init];
        
        
    }
    return  self;
    
}



+ (id) shareMyOrderListSingleDataSave{
    
   static MyOrderListSingleDataSave *single =nil;
    
    
    if (single==nil) {
        
          single =[[MyOrderListSingleDataSave alloc] init];
        
    }
    
    return  single;
    
}
@end
