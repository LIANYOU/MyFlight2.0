//
//  AirPortDataBase.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "AirPortDataBase.h"


#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"


@implementation AirPortDataBase


#pragma mark -
#pragma mark 打开数据库

+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"AirPortDataBase.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"AirPortDataBase" ofType:@"sqlite"];
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
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"DataBaseVersionConfigure.plist"];
    CCLog(@"数据库版本控制文件地址：%@",sqlPath);
    
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"DataBaseVersionConfigure" ofType:@"plist"];
    
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
    
    CCLog(@"本地版本号为：%@",[dict objectForKey:@"DataBaseVersion"]);
    
    ////
    //      [dict setValue:@"2" forKey:@"DataBaseVersion"];
    //      [dict writeToFile:[self getLocalDataBasePath] atomically:YES];
    //
    //    NSLog(@"更新后本地版本号为：%@",[dict objectForKey:@"DataBaseVersion"]);
    return [dict objectForKey:@"DataBaseVersion"];
}

//更新本地数据库版本号
+ (void) updateLocalDataBaseVersion:(NSString *) newVersion{
    
    
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithContentsOfFile:[self getLocalDataBasePath]];
    
    CCLog(@"本地版本号为：%@",[dict objectForKey:@"DataBaseVersion"]);
    
    [dict setValue:newVersion forKey:@"DataBaseVersion"];
    
    [dict writeToFile:[self getLocalDataBasePath] atomically:YES];
    
}



//创建表格新方法



+ (BOOL) createTableWithAirPortDataArray:(NSMutableArray *) dataArray{
    
    
    CCLog(@"待插入的数组的数量为：%d",[dataArray count]);
    
    FMDatabase *db = [self openDatabase];
    
    static BOOL isDataBaseNew =false;
    
    
    
    if ([db tableExists:@"AirPortDataBase"]) {
        
        CCLog(@"存在城市和机场表格 ");
        //删除旧表
        [db executeUpdate:@"drop table AirPortDataBase"];
        
        BOOL flag =  [db executeUpdate:@"CREATE TABLE AirPortDataBase (apCode TEXT, apName TEXT, apEName TEXT, apLName TEXT, hotcity TEXT, cityName TEXT,air_x text,air_y text, cityCode text,cityPinYin text,weatherCode text,city_x text,city_y text,id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) "];
        if (flag) {
            CCLog(@"创建一个表格  成功");
            
        } else{
            
            CCLog(@"创建新表格失败");
        }
        
        
        
        isDataBaseNew = true;
        
    }
    
    
    for (AirPortData *data in dataArray) {
        
        //插入数据
        [db  executeUpdate:@"insert into AirPortDataBase(apCode, apName, apEName, apLName, hotcity, cityName,air_x,air_y,cityCode,cityPinYin,weatherCode,city_x,city_y) values(?,?,?,?,?,?,?,?,?,?,?,?,?)",data.apCode,data.apName,data.apEname,data.apLName,data.hotCity,data.cityName,data.air_x,data.air_y,data.cityCode,data.cityPinYin,data.weatherCode,data.city_x,data.city_y];
    }
    
    
    [db close];
    
    
    return true;
    
    
}

//创建一个表格
+ (BOOL) createTableWithApCode:(NSString *) apCode apName:(NSString *) apName apEName:(NSString *)apEName apLName:(NSString *) apLName hotCity:(NSString *) hotCity cityName:(NSString *) city air_x:(NSString *) air_x air_y:(NSString *)air_y {
    
    
    FMDatabase *db = [self openDatabase];
    
    static BOOL isDataBaseNew =false;
    
    
    
    if (isDataBaseNew==false) {
        
        //删除旧表
        [db executeUpdate:@"drop table AirPortDataBase"];
        
        [db executeUpdate:@"CREATE TABLE AirPortDataBase (apCode TEXT, apName TEXT, apEName TEXT, apLName TEXT, hotcity TEXT, cityName TEXT,air_x text,air_y text, id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) "];
        CCLog(@"创建一个表格");
        
        isDataBaseNew = true;
        
    }
    
    //插入数据
    [db  executeUpdate:@"insert into AirPortDataBase(apCode, apName, apEName, apLName, hotcity, cityName,air_x,air_y) values(?,?,?,?,?,?,?,?)",apCode,apName,apEName,apLName,hotCity,city,air_x,air_y];
    [db close];
    
    
    return true;
    
    
}


//初始化数据库
+ (BOOL) initDataBaseTable:(NSData *) jsonData{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //解析json数据
    
    NSError *error =nil;
    
    NSDictionary *dict = [jsonData objectFromJSONDataWithParseOptions:JKSerializeOptionEscapeUnicode error:&error];
    
    
    if (!error) {
        
        NSString *version = [dict objectForKey:KEY_DataBaseVersion];
        
        NSString *resultCode = [[dict objectForKey:KEY_result] objectForKey:KEY_resultCode];
        NSString *message = [[dict objectForKey:KEY_result] objectForKey:KEY_message];
        NSString *airPortCount = [dict objectForKey:KEY_airPortCount];
        
        
        //    NSString * string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //    CCLog(@"服务器返回的数据为：%@",string);
        
        CCLog(@"数据库版本号为：%@",version);
        CCLog(@"服务器返回的结果码是：%@",resultCode);
        CCLog(@"机场的数目为：%@",airPortCount);
        CCLog(@"服务器处理返回的信息为：%@",message);
        NSArray *cityArray = [dict objectForKey:@"cities"];
        
        
        NSString *LocalDatabaseVersion = [self getLocalDataBaseVersion];
        
        if (![LocalDatabaseVersion isEqualToString:version]&&![version isEqualToString:@""]) {
            
            
            CCLog(@"服务器版本数据库有数据");
            [self updateLocalDataBaseVersion:version];
            
            
            CCLog(@"数据库版本不一致"); //更新数据库
            if([message isEqualToString:@""])
            {
                CCLog(@"成功取得数据");
                CCLog(@"取得的城市有%d个",[cityArray count]);
                
                
                //保存数据的数组
                NSMutableArray *resultArray = [[NSMutableArray alloc] init];
                
                
                for (NSDictionary * cityItem in cityArray)
                {
                    
                    NSString *cityName = [cityItem objectForKey:KEY_cityName];
                    NSString *hotCity = [cityItem objectForKey:KEY_hotCity];
                    NSString *apCode =nil;
                    NSString *apName = nil;
                    NSString *apEName = nil;
                    NSString *apLName = nil;
                    NSString *air_x =nil;
                    NSString *air_y = nil;
                    
                    
                    
                    //以下为增加字段
                    
                    NSString *cityCode = [cityItem objectForKey:KEY_cityCode];
                    NSString *pinyin =[cityItem objectForKey:KEY_cityPinYin];
                    NSString *weatherCode = [cityItem objectForKey:KEY_cityWeatherCode];
                    NSString *city_x =[cityItem objectForKey:KEY_city_X];
                    NSString *city_y = [cityItem objectForKey:KEY_city_Y];
                    
                    
                    CCLog(@"cityname = %@  weatherCode = %@ city_x =%@  city_y =%@",cityName,weatherCode,city_x,city_y);
                    
                    
                    //解析每个城市的机场信息
                    for (NSDictionary *airPort in [cityItem objectForKey:KEY_airports])
                    {
                        
                        apCode = [airPort objectForKey:KEY_apCode];
                        apName = [airPort objectForKey:KEY_apName];
                        apEName = [airPort objectForKey:KEY_apEName];
                        apLName = [airPort objectForKey:KEY_apLName];
                        air_x = [airPort objectForKey:@"x"];
                        air_y = [airPort objectForKey:@"y"];
                        
                        if ([apEName isEqualToString:@"@"]) {
                            
                            if ([apCode isEqualToString:@"NGQ"]) {
                                apEName = @"ali";
                            }
                            if ([apCode isEqualToString:@"BPL"]) {
                                apEName = @"bole";
                            }
                            
                            
                            if ([apCode isEqualToString:@"HIA"]) {
                                apEName =@"huaian";
                            }
                            if ([apCode isEqualToString:@"PIF"]) {
                                apEName = @"pingdong";
                            }
                            
                            if ([apCode isEqualToString:@"HCN"]) {
                                apEName = @"pingdong";
                            }
                            
                            if ([apCode isEqualToString:@"HCN"]) {
                                apEName = @"pingdong";
                            }
                            
                        }
                        
                        
                        AirPortData *data =[[AirPortData alloc] initWithapCode:apCode apName:apName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
                        
                        data.apEname = apEName;
                        data.apLName =apLName;
                        
                        
                        data.cityCode = cityCode;
                        data.cityPinYin =pinyin;
                        data.weatherCode = weatherCode;
                        data.city_x = city_x;
                        data.city_y =city_y;
                        
                        
                        [resultArray addObject:data];
                        [data release];
                        
                        
                        
                        //创建表格
                        //                        [self createTableWithApCode:apCode apName:apName apEName:apEName apLName:apLName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
                        
                    }
                    
                }
                
                //遍历完所有数据 插入数据库中
                
                
                [self createTableWithAirPortDataArray:resultArray];
                
                [resultArray release];
                
                
            } else{
                
                CCLog(@"服务器返回结果错误");
                
                //            UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"更新结果" message:@"服务器无响应" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            [alrt show];
                //            [alrt release];
                
                
            }
            
        } else{
            
            CCLog(@"数据库版本一致无需更新");
        }
        
    } else{
        
        CCLog(@"初始化机场数据时出错误了 不更新");
    }
    return true;
}


+ (void) initDataBase{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //    NSString *urlString = @"http://test.51you.com/web/phone/prod/flight/airPortCitySearch.jsp";
    
    
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URLForAirPortsAndCities]];
    [request setCompletionBlock:^{
        
        
        
        //        CCLog(@"网络返回的数据为：%@",[request responseString]);
        
        //初始化表格
        [self initDataBaseTable:[request responseData]];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    [request startAsynchronous];
}

//
+ (NSMutableDictionary *) findAllHotAirPorts{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    
    FMDatabase *db =[self openDatabase];
    
    FMResultSet *resultSet = [db executeQuery:@"SELECT  * FROM AirPortDataBase where hotcity=1"];
    //    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    
    while ([resultSet next]) {
        
        
        
        NSString *apCode = [resultSet stringForColumn:Column_apCode];
        NSString *apName = [resultSet stringForColumn:Column_apName];
        NSString *hotCity = [resultSet stringForColumn:Column_hotcity];
        NSString *cityName = [resultSet stringForColumn:Column_cityName];
        NSString *air_x = [resultSet stringForColumn:Column_air_x];
        NSString *air_y = [resultSet stringForColumn:Column_air_y];
        NSString *apEName =[resultSet stringForColumn:Column_apEName];
        
        AirPortData *airPort = [[AirPortData alloc] initWithapCode:apCode apName:apName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
        airPort.apEname=apEName;
        
        //新增
        airPort.cityCode = [resultSet stringForColumn:Column_cityCode];
        airPort.cityPinYin =[resultSet stringForColumn:Column_cityPinYin];
        airPort.weatherCode = [resultSet stringForColumn:Column_weatherCode];
        airPort.city_x =[resultSet stringForColumn:Column_city_x];
        airPort.city_y =[resultSet stringForColumn:Column_city_y];
        
        
        
        //        NSDictionary *dict = [NSDictionary dictionaryWithObject:airPort forKey:apCode];
        
        //        [resultArray addObject:dict];
        
        [resultDic setObject:airPort forKey:apCode];
        
        [airPort release];
    }
    
    NSLog(@"查询到的数目为：%d",[resultDic count]);
    
    return [resultDic autorelease];
}



+(NSMutableDictionary *) findAllCitiesAndAirPorts{
    
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    FMDatabase *db =[self openDatabase];
    
    
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM AirPortDataBase "];
    //    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    NSMutableDictionary *resultDic =[[NSMutableDictionary alloc] init];
    
    
    while ([resultSet next]) {
        
        NSString *apCode = [resultSet stringForColumn:Column_apCode];
        NSString *apName = [resultSet stringForColumn:Column_apName];
        NSString *hotCity = [resultSet stringForColumn:Column_hotcity];
        NSString *cityName = [resultSet stringForColumn:Column_cityName];
        NSString *air_x = [resultSet stringForColumn:Column_air_x];
        NSString *air_y = [resultSet stringForColumn:Column_air_y];
        NSString *apEName =[resultSet stringForColumn:Column_apEName];
        
        AirPortData *airPort = [[AirPortData alloc] initWithapCode:apCode apName:apName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
        airPort.apEname=apEName;
        
        
        
        //新增
        airPort.cityCode = [resultSet stringForColumn:Column_cityCode];
        airPort.cityPinYin =[resultSet stringForColumn:Column_cityPinYin];
        airPort.weatherCode = [resultSet stringForColumn:Column_weatherCode];
        airPort.city_x =[resultSet stringForColumn:Column_city_x];
        airPort.city_y =[resultSet stringForColumn:Column_city_y];
        
        
        
        [resultDic setObject:airPort forKey:apCode];
        [airPort release];
    }
    
    NSLog(@"查询到的所有的机场数目为：%d",[resultDic count]);
    
    return [resultDic autorelease];
    
    
}



//根据用户输入的条件查询 机场信息
+(NSMutableArray *) findAirPortByCondition:(NSString *) condition{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    FMDatabase *db =[self openDatabase];
    
    FMResultSet *resultSet = nil;
    
    NSMutableArray *resultDic =[[NSMutableArray alloc] init];
    
    if ([db tableExists:@"AirPortDataBase"]) {
        
        CCLog(@"存在表，可继续查询");
        
        NSString *sql=[NSString stringWithFormat:@"select DISTINCT * from AirPortDataBase where apName like '%@%%' or apEName like '%@%%'",condition,condition];
        
        CCLog(@"spl = %@",sql);
        
        CCLog(@"查询词为：%@",condition);
        
        
        resultSet = [db executeQuery:sql];
        
        
    }
    
    [resultDic removeAllObjects];
    
    while ([resultSet next]) {
        
        
        
        NSString *apCode = [resultSet stringForColumn:Column_apCode];
        NSString *apName = [resultSet stringForColumn:Column_apName];
        NSString *hotCity = [resultSet stringForColumn:Column_hotcity];
        NSString *cityName = [resultSet stringForColumn:Column_cityName];
        NSString *air_x = [resultSet stringForColumn:Column_air_x];
        NSString *air_y = [resultSet stringForColumn:Column_air_y];
        NSString *apEName =[resultSet stringForColumn:Column_apEName];
        
        AirPortData *airPort = [[AirPortData alloc] initWithapCode:apCode apName:apName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
        airPort.apEname=apEName;
        
        
        //新增
        airPort.cityCode = [resultSet stringForColumn:Column_cityCode];
        airPort.cityPinYin =[resultSet stringForColumn:Column_cityPinYin];
        airPort.weatherCode = [resultSet stringForColumn:Column_weatherCode];
        airPort.city_x =[resultSet stringForColumn:Column_city_x];
        airPort.city_y =[resultSet stringForColumn:Column_city_y];
        
        
        
        
        
        
        [resultDic addObject:airPort];
        [airPort release];
        
    }
    
    
    
    CCLog(@"根据查询条件 获取的机场数目为：%d",[resultDic count]);
    
    return [resultDic autorelease];
    
}



+(AirPortData *) findAirPortByApCode:(NSString *) apcode{
    
    
    
    FMDatabase *db =[self openDatabase];
    
    FMResultSet *resultSet = nil;
    
    
    if ([db tableExists:@"AirPortDataBase"]) {
        
        CCLog(@"存在表，可继续查询");
        
//        NSString *sql=[NSString stringWithFormat:@"select  * from AirPortDataBase where apCode = %@",apcode];
//        
        resultSet = [db executeQuery:@"select  * from AirPortDataBase where apCode = ?",apcode];
        
        
    }
    
    AirPortData *airPort =nil;
    
    
    while ([resultSet next]) {
        
        
        
        NSString *apCode = [resultSet stringForColumn:Column_apCode];
        NSString *apName = [resultSet stringForColumn:Column_apName];
        NSString *hotCity = [resultSet stringForColumn:Column_hotcity];
        NSString *cityName = [resultSet stringForColumn:Column_cityName];
        NSString *air_x = [resultSet stringForColumn:Column_air_x];
        NSString *air_y = [resultSet stringForColumn:Column_air_y];
        NSString *apEName =[resultSet stringForColumn:Column_apEName];
        
        airPort = [[AirPortData alloc] initWithapCode:apCode apName:apName hotCity:hotCity cityName:cityName air_x:air_x air_y:air_y];
        airPort.apEname=apEName;
        
        
        //新增
        airPort.cityCode = [resultSet stringForColumn:Column_cityCode];
        airPort.cityPinYin =[resultSet stringForColumn:Column_cityPinYin];
        airPort.weatherCode = [resultSet stringForColumn:Column_weatherCode];
        airPort.city_x =[resultSet stringForColumn:Column_city_x];
        airPort.city_y =[resultSet stringForColumn:Column_city_y];
        
    }
    
    
    
    CCLog(@"查询到的机场数据为：%@   %@",airPort.cityCode,airPort.cityName);
    
    return [airPort autorelease];
    
    
    
}


@end
