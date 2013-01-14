//
//  OrderDatabase.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "OrderDatabase.h"
#import "FMDatabase.h"

@implementation OrderDatabase

#pragma mark -
#pragma mark 打开数据库

+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"orderListForNoLogin.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"orderListForNoLogin" ofType:@"sqlite"];
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


+ (NSMutableArray *) findAllOrderInfo{
    FMDatabase *db =[self openDatabase];
    
    
    FMResultSet *resultSet = [db executeQuery:@"SELECT  creatTime,startAirport,endAirport,totalMoney,payStation,orderID,checkCode,type FROM orderList "];
    
    
    NSMutableArray *resultArr =[[NSMutableArray alloc] init];
    
    
    while ([resultSet next]) {
        
        OrderListModelData * list = [[OrderListModelData alloc] init];
        
        list.createTime = [resultSet stringForColumn:@"creatTime"];
        list.depAirportName = [resultSet stringForColumn:@"startAirport"];
        list.arrAirportName = [resultSet stringForColumn:@"endAirport"];
        list.totalMoney = [resultSet stringForColumn:@"totalMoney"];
        list.payStsCH = [resultSet stringForColumn:@"payStation"];
        list.orderId = [resultSet stringForColumn:@"orderID"];
        list.checkCode = [resultSet stringForColumn:@"checkCode"];
        list.type = [resultSet stringForColumn:@"type"];
        
        [resultArr addObject:list];
        [list release];
    }
    

    CCLog(@"查询到的本地订单数量为:%d",[resultArr count]);
    
    return [resultArr autorelease];

}

+ (BOOL) addOrderInfo_UnLogin:(OrderListModelData *) contactData
{
    FMDatabase *db =[self openDatabase];
    
    
    BOOL flag =[db executeUpdate:@"insert into orderList(creatTime,startAirport,endAirport,totalMoney,payStation,orderID,checkCode,type) values(?,?,?,?,?,?,?,?)",contactData.createTime,contactData.depAirportName,contactData.arrAirportName,contactData.totalMoney,contactData.payStsCH,contactData.orderId,contactData.checkCode,contactData.type];
    
    NSLog(@"乘机人手机号码   %@",contactData.checkCode);
    NSLog(@"订单ID   %@",contactData.orderId);
    NSLog(@"订单code   %@",contactData.type);

    
    if (flag) {
        
        CCLog(@"增加订单成功");
        
    } else{
        
        CCLog(@"增加订单失败");
    }
    
    
    return flag;
}

@end
