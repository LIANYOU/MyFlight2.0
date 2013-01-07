//
//  CommonContact_LocalTmpDBHelper.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/7/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonContact.h"

@interface CommonContact_LocalTmpDBHelper : NSObject




//查找所有的联系人 
+ (NSMutableArray *) findAllCommonContact_UnLogin;

//删除 联系人
+ (BOOL) deleteCommonContact_UnLogin:(CommonContact *) contactData;

//增加联系人
+ (BOOL) addCommonContact_UnLogin:(CommonContact *) contactData;

//更新联系人 
+ (BOOL) updateCommonContact_UnLogin:(CommonContact *)contactData;



//查找所有的联系人
+ (NSMutableArray *) findAllCommonContact_Login;

//删除 联系人
+ (BOOL) deleteCommonContact_Login:(CommonContact *) contactData;

//增加联系人
+ (BOOL) addCommonContact_Login:(CommonContact *) contactData;

//更新联系人
+ (BOOL) updateCommonContact_Login:(CommonContact *)contactData;









@end
