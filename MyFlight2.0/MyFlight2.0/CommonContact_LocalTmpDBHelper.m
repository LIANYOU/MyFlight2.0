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
    
    FMResultSet *resultSet = [db executeQuery:@"select * from UnLoginContactTableCeshi"];
    
    
    
    
    
    
    
    
    
    return  nil;
    
}


//删除 联系人
+ (BOOL) deleteCommonContact_UnLogin:(CommonContact *) contactData{
    
    
}

//增加联系人
+ (BOOL) addCommonContact_UnLogin:(CommonContact *) contactData{
    
    
}

//更新联系人
+ (BOOL) updateCommonContact_UnLogin:(CommonContact *)contactData{
    
    
}



//查找所有的联系人
+ (NSMutableArray *) findAllCommonContact_Login{
    
    
}

//删除 联系人
+ (BOOL) deleteCommonContact_Login:(CommonContact *) contactData{
    
    
}

//增加联系人
+ (BOOL) addCommonContact_Login:(CommonContact *) contactData{
    
    
}

//更新联系人
+ (BOOL) updateCommonContact_Login:(CommonContact *)contactData{
    
    
    
}














@end
