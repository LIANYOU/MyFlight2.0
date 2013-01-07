//
//  CommonContact.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/17/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonContact : NSObject

@property(nonatomic,retain)NSString *name; //姓名
@property(nonatomic,retain)NSString *type; //乘客类型
@property(nonatomic,retain)NSString *certType; //证件类型
@property(nonatomic,retain)NSString *certNo; //证件号码 儿童时为出生日期
@property(nonatomic,retain)NSString *contactId; //乘机人ID
@property(nonatomic,retain)NSString *birtyhday; //出生日期

- (id) initWithName:(NSString *) name type:(NSString *) type certType:(NSString *) certType certNo:(NSString *) certNO contactId:(NSString *) contactId;
@end
