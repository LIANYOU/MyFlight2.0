//
//  PostCityDatabase.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-8.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostCityDatabase : NSObject

//初始化数据库
+(void) initDataBase;


//查找所有的热门城市
+ (NSMutableDictionary *) findAllHotPostCity;
+(NSMutableDictionary *) findAllCities;



//根据用户输入的条件查询 机场信息
+(NSMutableArray *) findCityByCondition:(NSString *) condition;

@end
