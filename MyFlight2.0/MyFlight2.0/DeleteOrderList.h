//
//  DeleteOrderList.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface DeleteOrderList : NSObject


@property(nonatomic,retain) NSString * code;
@property(nonatomic,retain) NSString * hwId;
@property (nonatomic, assign) id<ServiceDelegate> delegate;


-(id)initWithCode:(NSString *)code
            andHwId:(NSString *)hwId
        andDelegate:(id<ServiceDelegate>)delegate;

-(void)deleteOrderList;

@end
