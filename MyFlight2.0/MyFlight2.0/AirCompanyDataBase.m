//
//  AirCompanyDataBase.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "AirCompanyDataBase.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "AirPortCompanyData.h"


@implementation AirCompanyDataBase


+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"AirCompanyDataBase.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"AirCompanyDataBase" ofType:@"sqlite"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            CCLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }
        
        CCLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    
    //这个方法一定要执行
    if (![db open]) {
        
        CCLog(@"数据库打开失败！");
        return db;
    }
    
    
   
    
    return  db;
}


+ (void) insertIntoTableWithCode:(NSString *) code shortName:(NSString *) shortName longName:(NSString *) longName{
    
    FMDatabase *db =[self openDatabase];
    
    static BOOL isDataBaseNew =false;
    
    if (isDataBaseNew==false) {
        
        
        [db executeUpdate:@"drop table AirPortCompany"];
        NSString *sql =@"CREATE TABLE AirPortCompany (code TEXT, shortName TEXT, longName TEXT, id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) ";
        [db executeUpdate:sql];

        
        isDataBaseNew =true;
    }

    
    [db executeUpdate:@"insert into AirPortCompany(code,shortName,longName) values(?,?,?)",code,shortName,longName];
    [db close];
        
}


//初始化数据库
+(BOOL) initDataBaseTable:(NSData *) jsonData{


    NSArray *resultArray = [[jsonData objectFromJSONData] objectForKey:@"company"];
    
    for (NSDictionary *dic  in resultArray) {
        
        
        NSString *code = [dic objectForKey:@"code"];
        NSString *shortName =[dic objectForKey:@"shortName"];
        NSString *longName = [dic objectForKey:@"longName"];
        
        
        [self insertIntoTableWithCode:code shortName:shortName longName:longName];
        
     }
    
    
    return true;
}


+ (void) initDataBase{
    
    
    NSString *urlString= @"http://223.202.36.179:9580/web/phone/prod/flight/flightCompany.jsp";
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        
        //初始化表格
        [self initDataBaseTable:[request responseData]];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    [request startAsynchronous];

    
}


+ (NSMutableArray *) findAllAirCompany{
    
    
    FMDatabase *db =[self openDatabase];
    
    FMResultSet *resultSet = [db executeQuery:@"select * from AirPortCompany"];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    while ([resultSet next]) {
        
        AirPortCompanyData *data =[[AirPortCompanyData alloc] init];
        data.code =[resultSet stringForColumnIndex:0];
        data.shortName = [resultSet stringForColumnIndex:1];
        data.longName = [resultSet stringForColumnIndex:2];
    
        [resultArray addObject:data];
        [data release];
    }
    
    return  [resultArray autorelease];
 }

@end
