//
//  SearchAirPort.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchAirPort : NSObject

@property(nonatomic,retain)NSDictionary * dictionary;  // 请求返回的数据转换成字典进行解析
@property(nonatomic,retain)NSData * allData;           // 保存请求返回的数据

@property(nonatomic,retain) NSString * dpt;            // 出发机场三字码
@property(nonatomic,retain) NSString * arr;            // 到达机场三字码
@property(nonatomic,retain) NSString * date;           //去程日期，格式为：yyyy-MM-dd
@property(nonatomic,assign) NSString * ftype;                 //查询类型为1（1单程；2往返）
@property(nonatomic,assign) int cabin;                 //航位0不限，1经济舱，2商务舱，3头等舱
@property(nonatomic,retain) NSString * carrier;        //航空公司（CA,8L,HU… …）
@property(nonatomic,assign) int dptTime;        //起飞时间0(0不限；1为12点之前；2为12点-18点；3为18点以后)
@property(nonatomic,retain) NSString * qryFlag;        //查询标记 price查询票价 flight查询航班 modify 改签(同航空公司 平舱或升舱 ) byCity 按城市查询

-(id) initWithdpt:(NSString *)dpt
              arr:(NSString *)arr
             date:(NSString *)date
            ftype:(NSString *)ftype
            cabin:(int) cabin
          carrier:(NSString *)carrier
          dptTime:(int)dptTime
          qryFlag:(NSString *)qryFlag;    // 查询借口初始化

-(void)searchAirPort;   // 机场搜索
-(NSArray *)analysisData:(NSData *)data;  // 返回数据分析



@end
