//
//  HistoryCheckDataBase.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryCheckDataBase : NSObject

//查找所有的历史记录
+ (NSArray *) findAllHistoryCheck;

//删除所有的历史记录
+ (BOOL) deleteAllHistory;

//添加历史记录
+ (BOOL) addHistoryFlightWithStartName:(NSString *) start endName:(NSString *) endName startApCode:(NSString *) startApcode endApCode:(NSString *) endApcode searchFlag:(NSString *) flag;

@end
