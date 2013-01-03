//
//  PostInfo.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostInfo : NSObject

@property (nonatomic, retain) NSString *  deliveryType;  // 配送方式
@property (nonatomic, retain) NSString *  catchUser;  // 收件人
@property (nonatomic, retain) NSString *  mobile;// 电话
@property (nonatomic, retain) NSString *  address;// 地址

@end
