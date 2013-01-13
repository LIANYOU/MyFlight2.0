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


//获取本地数据库版本号
+ (NSString *) getLocalDataBaseVersion{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithContentsOfFile:[self getLocalDataBasePath]];
    
    CCLog(@"本地版本号为：%@",[dict objectForKey:@"DataBaseVersion"]);
    //
    //      [dict setValue:@"2" forKey:@"DataBaseVersion"];
    //      [dict writeToFile:[self getLocalDataBasePath] atomically:YES];
    //
    //    NSLog(@"更新后本地版本号为：%@",[dict objectForKey:@"DataBaseVersion"]);
    return [dict objectForKey:@"DataBaseVersion"];
}


//取得本地数据库的路径
+ (NSString *) getLocalDataBasePath{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //配置文件
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"AirPortCode.plist"];
    
    CCLog(@"数据库版本控制文件地址：%@",sqlPath);
    
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"AirPortCode" ofType:@"plist"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if([fm fileExistsAtPath:sqlPath] == NO)
    {
        
        
        NSError *err = nil;
        if([fm copyItemAtPath:plistPath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            CCLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }
        
        CCLog(@"document 下没有数据库版本文件，执行拷贝工作");
    }
    
    
    return sqlPath;
}




//添加数据库新方法

+ (void) insertIntoTableWithAirPortCompanyArray:(NSMutableArray *) dataArray{
    
    CCLog(@"传入的待插入数据为 %d",[dataArray count]);
    
    
    FMDatabase *db =[self openDatabase];
    
    static BOOL isDataBaseNew =false;
    
    if (isDataBaseNew==false) {
        
        
        [db executeUpdate:@"drop table AirPortCompany"];
        NSString *sql =@"CREATE TABLE AirPortCompany (code TEXT, shortName TEXT, longName TEXT,tel text, id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) ";
        [db executeUpdate:sql];
        
        
        isDataBaseNew =true;
    }
    
    for (AirPortCompanyData *data in dataArray) {
        
        
       BOOL flag=  [db executeUpdate:@"insert into AirPortCompany(code,shortName,longName,tel) values(?,?,?,?)",data.code,data.shortName,data.longName,data.tel];
        if (flag) {
            CCLog(@"插入成功");
        } else{
            
            CCLog(@"插入失败");
        }
    }
    
    
    [db close];

     
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
    NSMutableArray *array =[[NSMutableArray alloc] init];
    
    for (NSDictionary *dic  in resultArray) {
        
        
        NSString *code = [dic objectForKey:@"code"];
        NSString *shortName =[dic objectForKey:@"shortName"];
        NSString *longName = [dic objectForKey:@"longName"];
        NSString *tel =[dic objectForKey:@"tel"];
        CCLog(@"code = %@ shortName =%@",code,shortName);
        AirPortCompanyData *data =[[AirPortCompanyData alloc] initWithCode:code shortName:shortName longName:longName tel:tel];
        
        [array addObject:data];
        [data release];
        
                
      
//        [self insertIntoTableWithCode:code shortName:shortName longName:longName];
        
     }
    
    CCLog(@"待插入的航空公司数据%d",[array count]);
    [self insertIntoTableWithAirPortCompanyArray:array];

      [array release];
    
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
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    
    while ([resultSet next]) {
        
        AirPortCompanyData *data =[[AirPortCompanyData alloc] init];
        data.code =[resultSet stringForColumnIndex:0];
        data.shortName = [resultSet stringForColumnIndex:1];
        data.longName = [resultSet stringForColumnIndex:2];
        data.tel = [resultSet stringForColumn:@"tel"];
    
        [dic setObject:data.shortName forKey:data.code];
  
        [resultArray addObject:data];
        [data release];
        
    }
    
    
    CCLog(@"查询到的航空公司数目为：%d",[resultArray count]);
    
   BOOL flag= [dic writeToFile:[self getLocalDataBasePath] atomically:YES];
    
    if (flag) {
        CCLog(@"写入文件 成功");
    } else{
        
        CCLog(@"写入文件失败");
    }
    
    
    return  [resultArray autorelease];
 }

@end
