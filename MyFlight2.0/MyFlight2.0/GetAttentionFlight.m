//
//  GetAttentionFlight.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "GetAttentionFlight.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
@implementation GetAttentionFlight

-(id)initWithMemberId:(NSString *)memberId
         andOrgSource:(NSString *)orgSource
              andType:(NSString *)type
             andToken:(NSString *)token
            andSource:(NSString *)source
              andHwid:(NSString *)hwid
       andServiceCode:(NSString *)serviceCode
{
    self = [super init];
    if (self) {
        self.memberId = memberId;
        self.orgSource = orgSource;
        self.type = type;
        self.token = token;
        self.source = source;
        self.hwId = hwid;
        self.serviceCode = serviceCode;
    }
    return self;
}

-(void)getAttentionFlight
{

    NSLog(@"查询已经关注的航班时的条件 %@,%@,%@,%@,%@",self.memberId,self.orgSource,self.type,self.token,self.hwId);
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Flight/GetBookFlightMovement.json"];
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.orgSource forKey:@"orgSource"];
    [request setPostValue:self.type forKey:@"type"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.token forKey:@"token"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.serviceCode forKey:@"serviceCode"];
    
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSDictionary * getListDic = [temp objectFromJSONString];
        
        NSArray * secDic = [getListDic objectForKey:@"flightList"];
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:secDic,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"获得已经关注航班信息" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];

        NSLog(@"secDic : %@",temp);
        
//        for(NSDictionary * cid in secDic)
//        {
//            NSLog(@"%@,%@",[cid objectForKey:@"deptDate"],[cid objectForKey:@"flightNum"]);
//        }
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"getList Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}
@end
