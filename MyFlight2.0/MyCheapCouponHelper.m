//
//  MyCheapCouponHelper.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/2/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "MyCheapCouponHelper.h"
#import "AppConfigure.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "CouponsInfo.h"
@implementation MyCheapCouponHelper



//获取优惠券信息
+ (BOOL) getCouponInfoListWithMemberId:(NSString *) memberId andDelegate:(id<ServiceDelegate>) delegate{
    
    NSString *token = Default_Token_Value;
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,token];
    NSString *sign = GET_SIGN(urlString);
    
    CCLog(@"memberID = %@",memberId);
    CCLog(@"sign = %@",sign);
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    //保存查询到的结果数组
    __block NSMutableDictionary *resultDic =[[NSMutableDictionary alloc] init];
    [messageDic setObject:@"getCouponInfo" forKey:KEY_Request_Type];
    __block NSString *message = nil;
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:Coupon_List_URL]];
    [formRequst setPostValue:memberId forKey:KEY_Account_MemberId];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
          NSString *data = [formRequst responseString];
//        NSString *data = @"{\"result\":{\"resultCode\":\"\",\"message\":\"\"},\"useList\":[{\"code\":\"123456\",\"name\":\"机票优惠券\",\"price\":\"50\",\"dateStart\":\"2012-12-01\",\"dateEnd\":\"2012-12-01\"},{\"code\":\"676868\",\"name\":\"机票优惠券\",\"price\":\"200\",\"dateStart\":\"2012-12-01\",\"dateEnd\":\"2012-12-01\"}],\"nouseList\":[{\"code\":\"123456\",\"name\":\"机票优惠券\",\"price\":\"100\",\"dateStart\":\"2012-12-01\",\"dateEnd\":\"2012-12-01\"}],\"exPiredList\":[{\"code\":\"123456\",\"name\":\"机票优惠券\",\"price\":\"60\",\"dateStart\":\"2012-12-01\",\"dateEnd\":\"2012-12-01\"},{\"code\":\"7891012\",\"name\":\"机票优惠券\",\"price\":\"150\",\"dateStart\":\"2013-02-12\",\"dateEnd\":\"2013-02-14\"}]}";
        
        CCLog(@"网络返回的数据为：%@",data);
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        if (!error) {
            CCLog(@"json解析格式正确");
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                NSMutableArray *useList =[[NSMutableArray alloc] init];
                NSMutableArray *noUseList =[[NSMutableArray alloc] init];
                NSMutableArray *outOfDateList = [[NSMutableArray alloc] init];
                
                NSArray *useTmpList = [dic objectForKey:@"useList"];
                for (NSDictionary *tmpDic in useTmpList) {
                    
                    CouponsInfo *info = [[CouponsInfo alloc] init];
                    info.code = [tmpDic objectForKey:@"code"];
                    info.name = [tmpDic objectForKey:@"name"];
                    info.price = [tmpDic objectForKey:@"price"];
                    info.dateStart = [tmpDic objectForKey:@"dateStart"];
                    info.dateEnd = [tmpDic objectForKey:@"dateEnd"];
                    [useList addObject:info];
                    [info release];
                    
                }
                
                NSArray *noUseTmpist = [dic objectForKey:@"nouseList"];
                
                for (NSDictionary *tmpDic in noUseTmpist) {
                    
                    CouponsInfo *info = [[CouponsInfo alloc] init];
                    info.code = [tmpDic objectForKey:@"code"];
                    info.name = [tmpDic objectForKey:@"name"];
                    info.price = [tmpDic objectForKey:@"price"];
                    info.dateStart = [tmpDic objectForKey:@"dateStart"];
                    info.dateEnd = [tmpDic objectForKey:@"dateEnd"];
                    
                    
                    [noUseList addObject:info];
                    [info release];
                }
                
                NSArray *outOfList = [dic objectForKey:@"exPiredList"];
                
                for (NSDictionary *tmpDic in outOfList) {
                    
                    CouponsInfo *info = [[CouponsInfo alloc] init];
                    info.code = [tmpDic objectForKey:@"code"];
                    info.name = [tmpDic objectForKey:@"name"];
                    info.price = [tmpDic objectForKey:@"price"];
                    info.dateStart = [tmpDic objectForKey:@"dateStart"];
                    info.dateEnd = [tmpDic objectForKey:@"dateEnd"];
                    [outOfDateList addObject:info];
                    [info release];
                    
                }
                
                [resultDic setObject:useList forKey:KEY_CouponListOfUse];
                [resultDic setObject:noUseList forKey:KEY_CouponListOfNoUse];
                [resultDic setObject:outOfDateList forKey:KEY_CouponListOfOutOfDate];
                
                [useList release];
                [noUseList release];
                [outOfDateList release];
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [messageDic setObject:resultDic forKey:@"resultDic"];
                    [resultDic release];
                    
                    
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                
                
                [delegate requestDidFinishedWithFalseMessage:messageDic];
                
                //                return [resultDic autorelease];
                
            }
            
            
            
        } else{
            NSLog(@"解析有错误");
            
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
            
        }
        
        
        
    }];
    
    [formRequst setFailedBlock:^{
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
            [delegate requestDidFailed:messageDic];
        }
        
        
    }];
    
    [formRequst startAsynchronous];
    
    
    
    return  true;
    
    
}


//激活优惠券接口

+ (BOOL) makeCouponActiveWithMemberId:(NSString *) memberId captcha:(NSString *) captcha andDlegate:(id<ServiceDelegate>) delegate{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,Default_Token_Value];
    
    NSString *sign = GET_SIGN(urlString);
    
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    [messageDic setObject:@"active" forKey:KEY_Request_Type];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:MakeCoupon_active_URL]];
    
    
    [formRequst setPostValue:memberId forKey:KEY_Account_MemberId];
    [formRequst setPostValue:captcha forKey:@"captcha"];
    [formRequst setPostValue:sign forKey:KEY_SIGN];
    [formRequst setPostValue:SOURCE_VALUE forKey:KEY_source];
    [formRequst setPostValue:HWID_VALUE forKey:KEY_hwId];
    [formRequst setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [formRequst setPostValue:EDITION_VALUE forKey:KEY_edition];
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        //        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            NSLog(@"服务器返回的信息为：%@",message);
            
            if ([message length]==0) {
                
                NSLog(@"成功激活");
                
                
                [self getCouponInfoListWithMemberId:Default_UserMemberId_Value andDelegate:delegate];
                
                [delegate requestDidFinishedWithRightMessage:messageDic];
                
                
                
                
            } else{
                
                //message 长度不为0 有错误信息
                [messageDic setObject:message forKey:KEY_message];
                
                
                [delegate requestDidFinishedWithFalseMessage:messageDic];
                
            }
        } else{
            NSLog(@"解析有错误");
            
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            [delegate requestDidFinishedWithFalseMessage:messageDic];
            
            return ;
            
        }
    }];
    
    [formRequst setFailedBlock:^{
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        [delegate requestDidFailed:messageDic];
    }];
    
    
    [formRequst startAsynchronous];
    
    return  true;
    
    
}



@end
