//
//  PostCityDatabase.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-8.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "PostCityDatabase.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "PostCityData.h"
#import "FMDatabase.h"
@implementation PostCityDatabase


#pragma mark -
#pragma mark 打开数据库

+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"PostCity.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"PostCity" ofType:@"sqlite"];
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
    
    
    CCLog(@"打开成功");
    
    return  db;
}


//取得本地数据库的路径
+ (NSString *) getLocalDataBasePath{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //配置文件
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"postCityList.plist"];
    
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"postCityList" ofType:@"plist"];
    
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

//获取本地数据库版本号
+ (NSString *) getLocalDataBaseVersion{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithContentsOfFile:[self getLocalDataBasePath]];
    
    CCLog(@"本地版本号为：%@",[dict objectForKey:@"version"]);

    return [dict objectForKey:@"version"];
}


//更新本地数据库版本号
+ (void) updateLocalDataBaseVersion:(NSString *) newVersion{
    
    
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithContentsOfFile:[self getLocalDataBasePath]];
    
    CCLog(@"本地版本号为：%@",[dict objectForKey:@"version"]);
    
    [dict setValue:newVersion forKey:@"version"];
    
    [dict writeToFile:[self getLocalDataBasePath] atomically:YES];
    
}


// 插入数据库

+ (BOOL) createTableWithName:(NSString *)name  andCode:(NSString *)code andPinyin:(NSString *)pinyin andHotCity:(NSString *)hotCity
{

    FMDatabase *db = [self openDatabase];
//    static BOOL isDataBaseNew =false;
    
    
    
//    if (isDataBaseNew==false) {
//        
//        //删除旧表
//        [db executeUpdate:@"drop table AirPortDataBase"];
//        
//        [db executeUpdate:@"CREATE TABLE AirPortDataBase (apCode TEXT, apName TEXT, apEName TEXT, apLName TEXT, hotcity TEXT, cityName TEXT,air_x text,air_y text, id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) "];
//        CCLog(@"创建一个表格");
//        
//        isDataBaseNew = true;
//        
//    }
  
    
    //插入数据
    [db  executeUpdate:@"insert into postCity(name, code, pinyin, hotCity) values(?,?,?,?)",name,code,pinyin,hotCity];
    [db close];
    
    
    return true;
    
    
}

//初始化数据库
+ (BOOL) initDataBaseTable:(NSData *) jsonData{
    
    //解析json数据
    NSDictionary *dict = [jsonData objectFromJSONData];
    
    NSString *version = [dict objectForKey:@"version"];
    
    NSArray *cityArray = [dict objectForKey:@"cities"];
    
    NSString *message = [[dict objectForKey:@"result"] objectForKey:@"message"];
    
    
    NSString *LocalDatabaseVersion = [self getLocalDataBaseVersion];  // 获取本地数据库版本
    
    if (![LocalDatabaseVersion isEqualToString:version]&&![version isEqualToString:@""]) {
        
        
        CCLog(@"服务器版本数据库有数据");
        [self updateLocalDataBaseVersion:version];
        
        
        CCLog(@"数据库版本不一致"); //更新数据库
        if([message isEqualToString:@""])
        {
            CCLog(@"成功取得数据");
            CCLog(@"取得的城市有%d个",[cityArray count]);
            
            
            for (NSDictionary * cityItem in cityArray)
            {
                
                NSString *name = [cityItem objectForKey:@"name"];
                NSString *code = [cityItem objectForKey:@"code"];
                NSString *pinyin =[cityItem objectForKey:@"pinyin"];
                NSString *hotcity = [cityItem objectForKey:@"hotcity"];
                
                
                [self createTableWithName:name andCode:code andPinyin:pinyin andHotCity:hotcity ];
                
                
                
            }
            
            
        } else{
            
            CCLog(@"服务器返回结果错误");
            
            //            UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"更新结果" message:@"服务器无响应" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alrt show];
            //            [alrt release];
            
            
        }
        
        
        
        
    } else{
        
        CCLog(@"数据库版本一致无需更新");
    }
    
    return true;
}

+ (void) initDataBase{
    
    
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http:223.202.36.179:9580/web/phone/prod/flight/allCitySearch.jsp"]];
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




// 查找

+ (NSMutableDictionary *) findAllHotPostCity{
    
}
+(NSMutableDictionary *) findAllCities{
    
    FMDatabase *db =[self openDatabase];
    
    
    FMResultSet *resultSet = [db executeQuery:@"SELECT  name,code,pinyin,hotCity FROM postCity "];

    
    NSMutableDictionary *resultDic =[[NSMutableDictionary alloc] init];
    
    
    while ([resultSet next]) {
        
        
        
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *code = [resultSet stringForColumn:@"code"];
        NSString *pinyin = [resultSet stringForColumn:@"pinyin"];
        NSString *hotCity = [resultSet stringForColumn:@"hotCity"];
              
        PostCityData *airPort = [[PostCityData alloc] initWithName:name andCode:code andPinyin:pinyin andHotcity:hotCity];
              
        [resultDic setObject:airPort forKey:pinyin];
        [airPort release];
    }
    
    NSLog(@"查询到的所有的机场数目为：%d",[resultDic count]);
    
    return [resultDic autorelease];}

@end
