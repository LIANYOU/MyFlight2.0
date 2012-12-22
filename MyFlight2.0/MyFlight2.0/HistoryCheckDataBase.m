//
//  HistoryCheckDataBase.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/22/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "HistoryCheckDataBase.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "HistoryCheckInfoData.h"
@implementation HistoryCheckDataBase



+ (FMDatabase *) openDatabase
{
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"HistoryFlightQuery.sqlite"];
    NSLog(@"%@",sqlPath);
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"HistoryFlightQuery" ofType:@"sqlite"];
    
    
    
    
    NSLog(@"原始地址:%@",orignFilePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        
        
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            NSLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }
        
        NSLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    
    //这个方法一定要执行
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        return db;
    }
    
    
    NSLog(@"打开成功");
    NSLog(@"db=%@",db);
    return  db;
}








+ (NSArray *) findAllHistoryCheck{
    
    FMDatabase *db = [self openDatabase];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    if ([db tableExists:@"HistoryFlight"]) {
        
        CCLog(@"存在HistoryFlight表格");
        
        
        
        FMResultSet *resultSet=[db executeQuery:@"select * from HistoryFlight"];
        
        
        
        NSLog(@"查询到的结果集%@",resultSet);
        NSLog(@"几列=%d",[resultSet columnCount]);
        NSLog(@"错误信息：%@ 行数%d",[db lastErrorMessage], [db lastErrorCode]);
        
        
        
        while ([resultSet next])
        {
            
            HistoryCheckInfoData *data =[[HistoryCheckInfoData alloc] init];
            
            
            [data  setStartAirPortName:[resultSet stringForColumnIndex:1] EndAirPortName:[resultSet stringForColumnIndex:2] startApCode:[resultSet stringForColumnIndex:3] endApCode:[resultSet stringForColumnIndex:4] searchFlag:[resultSet stringForColumnIndex:5]];
            
            
            CCLog(@"添加的出发机场名字为%@",data.startAirPortName);
            
            [resultArray addObject:data];
            [data release];
            
            
        }
        
        
        
    }
    
    NSLog(@"查找成功");
    [db close];
    
    return  [resultArray autorelease];
    
}

//添加历史记录
+ (BOOL) addHistoryFlightWithStartName:(NSString *) start endName:(NSString *) endName startApCode:(NSString *) startApcode endApCode:(NSString *) endApcode searchFlag:(NSString *) flag{
    
    BOOL success = NO;
    
    FMDatabase *db =[self openDatabase];
    
    
    if ([db tableExists:@"HistoryFlight"]) {
        
        CCLog(@"存在HistoryFlight表格");
        
        
        success =  [db executeUpdate:@"insert into HistoryFlight(startAirportName,endAirportName,startApCode,endApCode,flag) values(?,?,?,?,?)",start,endName,startApcode,endApcode,flag];
        if (success) {
            
            
            
            CCLog(@"添加历史成功");
        }
        
        
        
    }
    
    
    return success;
    
    
}

+ (BOOL) deleteAllHistory{
    
    FMDatabase *db =[self openDatabase];
    
    BOOL success = NO;
    
    if ([db tableExists:@"HistoryFlight"]) {
        
        CCLog(@"存在HistoryFlight表格");
        
        success =  [db executeUpdate:@"delete from HistoryFlight"];
        
        if (success) {
            CCLog(@"删除全部历史");
        }
        
        
    }
    
    return success;
    
}

@end
