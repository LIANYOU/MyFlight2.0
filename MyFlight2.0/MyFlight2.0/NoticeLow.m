//
//  NoticeLow.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "NoticeLow.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
#import "ProBookListData.h"
#import "ProBooKResultData.h"
@implementation NoticeLow
-(id) initWithSource:(NSString *)source
         andMemberId:(NSString *)memberId
             andSign:(NSString *)sign
             andHwId:(NSString *)hwId
         andDelegate:(id<ServiceDelegate>)delegate
{
    if ([super init]) {
        self.source = source;
        self.memberId = memberId;
        self.sign = sign;
        self.hwId = hwId;
        self.delegate = delegate;
    }
    return self;
}

-(void)getInfo
{
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
        
    //[messageDic setObject:@"fsfs" forKey:KEY_Request_Type];
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://223.202.36.179:9580/web/phone/prod/flight/preBookList.jsp"]]];
    
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.sign forKey:@"sign"];
    [request setPostValue:self.hwId forKey:@"hwId"];

    
    
    CCLog(@"*************************  验证低价预约信息 ******************");
    CCLog(@"memberId  =  %@",self.memberId);
    CCLog(@"sign = %@",self.sign);
    CCLog(@"source  =  %@",self.source);
    CCLog(@"hwId  =  %@",self.hwId);
    
    
    
    [request setRequestMethod:@"POST"];
    
    [request setCompletionBlock:^{
        
        NSString *data = [request responseString];
        
        NSString *codeRequ =[NSString stringWithFormat:@"%d",[request responseStatusCode]];
        
        CCLog(@"网络返回的请求码是 %@",codeRequ);
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        
        
        message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
        
        
        NSLog(@"服务器返回的信息为：%@",message);
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            
           
            NSArray * arr = [dic objectForKey:@"preBookList"];
 
           
            
//            NSDictionary * dictionary = [NSDictionary dictionaryWithObject:arr forKey:@"dic"];
            
            CCLog(@"message length = %d",[message length]);
            if ([message length]==0) {
                
                
                NSMutableArray *resultArry =[[NSMutableArray alloc] init];
  
                for (NSDictionary *tmpDic in arr) {
                    
                    ProBooKResultData *resultData =[[ProBooKResultData alloc] init];
                    ProBookListData *allData =[[ProBookListData alloc] init];
                    
                   
                    
                    allData.code =[tmpDic objectForKey:@"code"];
                    allData.dpt =[tmpDic objectForKey:@"dpt"];
                    allData.dptCN = [tmpDic objectForKey:@"dptCN"];
                    allData.arr = [tmpDic objectForKey:@"arr"];
                    allData.arrCN =[tmpDic objectForKey:@"arrCN"];
                    allData.discount =[tmpDic objectForKey:@"discount"];
                    allData.startDate =[tmpDic objectForKey:@"startDate"];
                    allData.endDate = [tmpDic objectForKey:@"endDate"];
                    
                    NSArray *thisArray =[tmpDic objectForKey:@"flightList"];
                    BOOL isHaveData = false;
                
                    NSMutableArray *tmpArr =[[NSMutableArray alloc] init];
                    
                    for (NSDictionary *dic in thisArray) {
                        flightListTemp *tmpData = [[flightListTemp alloc] init];
                        isHaveData =true;
                        tmpData.diccount = [dic objectForKey:@"discount"];
                        tmpData.startDate =[dic objectForKey:@"startDate"];
                        [tmpArr addObject:tmpData];
                        [tmpData release];
                        
                    }
                    
                    resultData.allData = allData;
                    resultData.flag = isHaveData;
                    resultData.listArray = tmpArr;
//                    resultData.listArray
                    CCLog(@"此行有数据：%d ********************",isHaveData);
                    
                    
                    [resultArry addObject:resultData];
                    [resultData release];
                    [allData release];

                    
                    
                }
                
                
                CCLog(@"有数据 count= %d",[resultArry count]);
                            
                
                
                [messageDic setObject:resultArry forKey:@"findOrderlist"];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                
            }
            
        } else{
            
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            
            if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                
                [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                
            }
            return ;
            
        }
    }];
    
    [request setFailedBlock:^{
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [self.delegate requestDidFailed:messageDic];
            
        }
        
    }];
    
    
    [request startAsynchronous];
}
@end
