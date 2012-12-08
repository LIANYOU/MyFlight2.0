//
//  SearchFlightCondition.h
//  MyFlight2.0
//
//  Created by sss on 12-12-8.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFlightCondition : NSObject

@property(nonatomic,retain) NSString * fno;    //航班号
@property(nonatomic,retain) NSString * fdate;  //航班时间
@property(nonatomic,retain) NSString * dpt;    //出发机场
@property(nonatomic,retain) NSString * arr;    //到达机场
@property(nonatomic,retain) NSString * hwld;   //硬件id(选填)
@property(nonatomic,retain) NSData * allData;   // 存放返回的所有机场信息
@property(nonatomic,retain) NSDictionary * dictionary; // JSON 转换的时候使用

-(id)initWithfno:(NSString *)fno
           fdate:(NSString *)fdate
             dpt:(NSString *)dpt
             arr:(NSString *)arr
            hwld:(NSString *)hwld;   // 初始化SearchFlightCondition

-(void)searchFlightCondition;        // 查询航班动态

-(NSMutableArray *)analysisData:(NSData *)data;  // 返回数据分析
@end
