//
//  flightContactVo.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/28/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

//机票订单联系人信息
@interface flightContactVo : NSObject

@property(nonatomic,retain)NSString  *name; //姓名 姓名格式 为 全中文 或Yuhu/wu 格式

@property(nonatomic,retain)NSString *mobile; //手机

@property(nonatomic,retain)NSString *email;//email


- (id) initWithName:(NSString *)newName Mobile:(NSString *) mobile email:(NSString *)email;


@end
