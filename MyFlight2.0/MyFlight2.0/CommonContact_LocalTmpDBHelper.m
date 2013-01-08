//
//  CommonContact_LocalTmpDBHelper.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/7/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "CommonContact_LocalTmpDBHelper.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "CommonContact.h"




@implementation CommonContact_LocalTmpDBHelper



+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"CommonContactDataBase.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"CommonContactDataBase" ofType:@"sqlite"];
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





//查找所有的联系人
+ (NSMutableArray *) findAllCommonContact_UnLogin{
    
    FMDatabase *db =[self openDatabase];
    
    if ([db tableExists:@"UnLoginContactTableCeshi"]) {
        
        CCLog(@"存在本地表");
    } else{
        
        CCLog(@"不存在");
    }
    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    FMResultSet *resultSet = [db executeQuery:@"select * from UnLoginContactTableCeshi"];
    
    
    while ([resultSet next]) {
        
        CommonContact *data = [[CommonContact alloc] init];
        
        data.contactId = [resultSet stringForColumnIndex:6];
        data.name = [resultSet stringForColumnIndex:1];
        data.type =[resultSet stringForColumnIndex:2];
        data.certType = [resultSet stringForColumnIndex:3];
        data.certNo =[resultSet stringForColumnIndex:4];
        data.birtyhday =[resultSet stringForColumnIndex:5];
        
        [resultArray addObject:data];
        
        [data release];
    }
    
    CCLog(@"查询到的联系人为：%d",[resultArray count]);
    
    return  [resultArray autorelease];
    
}


//删除 联系人
+ (BOOL) deleteCommonContact_UnLogin:(CommonContact *) contactData{
    
    
    FMDatabase *db =[self openDatabase];
    
    
    
    BOOL flag = [db executeUpdate:@"delete from UnLoginContactTableCeshi where id = ?",contactData.contactId];
    
    if (flag) {
        
        CCLog(@"删除联系人成功");
        
    } else{
        
        CCLog(@"删除失败");
    }
    
    
    return flag;
}



//增加联系人
+ (BOOL) addCommonContact_UnLogin:(CommonContact *) contactData{
    
    CCLog(@"未登录添加乘机人");
    
    FMDatabase *db =[self openDatabase];
    
    
    BOOL flag =[db executeUpdate:@"insert into UnLoginContactTableCeshi(name,type,certType,certNo,birtyhday) values(?,?,?,?,?)",contactData.name,contactData.type,contactData.certType,contactData.certNo,contactData.birtyhday];
    
    
    if (flag) {
        
        CCLog(@"增加联系人成功");
        
    } else{
        
        CCLog(@"增加失败");
    }
    
    
    return flag;
    
}


//更新联系人
+ (BOOL) updateCommonContact_UnLogin:(CommonContact *)contactData{
    
    
    FMDatabase *db =[self openDatabase];
    
    BOOL flag = [db executeUpdate:@"update UnLoginContactTableCeshi set name=?,type=?,certType=?,certNo=?,birtyhday=? where id = ?",contactData.name,contactData.type,contactData.certType,contactData.certNo,contactData.birtyhday,contactData.contactId];
    if (flag) {
        
        CCLog(@"更新联系人成功");
        
    } else{
        
        CCLog(@"gengxin失败");
    }
    
    
    return flag;
}




//查找所有的联系人
+ (NSMutableArray *) findAllCommonContact_Login{
    
    FMDatabase *db =[self openDatabase];
    
    if ([db tableExists:@"LoginContactTableCeshi"]) {
        
        CCLog(@"存在本地表");
    } else{
        
        CCLog(@"不存在");
    }
    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    FMResultSet *resultSet = [db executeQuery:@"select * from LoginContactTableCeshi"];
    
    
    while ([resultSet next]) {
        
        CommonContact *data = [[CommonContact alloc] init];
        
        data.contactId = [resultSet stringForColumnIndex:0];
        data.name = [resultSet stringForColumnIndex:1];
        data.type =[resultSet stringForColumnIndex:2];
        data.certType = [resultSet stringForColumnIndex:3];
        data.certNo =[resultSet stringForColumnIndex:4];
        data.birtyhday =[resultSet stringForColumnIndex:5];
        
        [resultArray addObject:data];
        
        [data release];
    }
    
    CCLog(@"查询到的联系人为：%d",[resultArray count]);
    
    return  [resultArray autorelease];
    
}

//删除 联系人
+ (BOOL) deleteCommonContact_Login:(CommonContact *) contactData{
    
    FMDatabase *db =[self openDatabase];
    
    BOOL flag = [db executeUpdate:@"delete from LoginContactTableCeshi where contactId = ?",contactData.contactId];
    
    if (flag) {
        
        CCLog(@"删除联系人成功");
        
    } else{
        
        CCLog(@"删除失败");
    }
    
    
    return flag;
}



//增加联系人
+ (BOOL) addCommonContact_Login:(CommonContact *) contactData{
    
    CCLog(@"登录添加乘机人");
    
    FMDatabase *db =[self openDatabase];
    
    if ([db tableExists:@"LoginContactTableCeshi"]) {
        
        [db executeUpdate:@"delete from LoginContactTableCeshi"];
        
        CCLog(@"存在表格");
    } else{
        
        CCLog(@"表不存在");
    }
    
    
    
    BOOL flag =[db executeUpdate:@"insert into LoginContactTableCeshi(contactId,name,type,certType,certNo,birtyhday) values(?,?,?,?,?,?)",contactData.contactId,contactData.name,contactData.type,contactData.certType,contactData.certNo,contactData.birtyhday];
    
    if (flag) {
        
        CCLog(@"增加联系人成功");
        
    } else{
        
        CCLog(@"增加失败");
    }
    
    
    return flag;
    
}

//更新联系人
+ (BOOL) updateCommonContact_Login:(CommonContact *)contactData{
    
    FMDatabase *db =[self openDatabase];
    
    BOOL flag = [db executeUpdate:@"update LoginContactTableCeshi set name=?,type=?,certType=?,certNo=?,birtyhday=? where contactId = ?",contactData.name,contactData.type,contactData.certType,contactData.certNo,contactData.birtyhday,contactData.contactId];
    if (flag) {
        
        CCLog(@"更新联系人成功");
        
    } else{
        
        CCLog(@"gengxin失败");
    }
    
    
    return flag;
 
    
}




@end
