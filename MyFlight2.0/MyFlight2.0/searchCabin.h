//
//  searchCabin.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchCabin : NSObject

@property(nonatomic,retain)NSDictionary * dictionary;  // 请求返回的数据转换成字典进行解析
@property(nonatomic,retain)NSData * allData;           // 保存请求返回的数据


@property(nonatomic,retain) NSString * dpt;            // 出发机场三字码
@property(nonatomic,retain) NSString * arr;            // 到达机场三字码
@property(nonatomic,retain) NSString * date;           //去程日期，格式为：yyyy-MM-dd
@property(nonatomic,retain) NSString * code;  // HO252  航班号
@property(nonatomic,retain) NSString * edition;  // 版本号
@property(nonatomic,retain) NSString * source;  // 来源

-(id) initWithdpt:(NSString *)dpt
              arr:(NSString *)arr
             date:(NSString *)date
             code:(NSString *)code
          edition:(NSString *) edition
           source:(NSString *)source;
          // 查询借口初始化

-(void)searchCabin;   // 机场搜索
-(NSArray *)analysisData:(NSData *)data;  // 返回数据分析
@end
