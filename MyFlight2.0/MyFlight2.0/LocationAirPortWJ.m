//
//  LocationAirPortWJ.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-14.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "LocationAirPortWJ.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
@implementation LocationAirPortWJ
-(id)initWithX:(NSString * )x
          andY:(NSString * )y
    andMapType:(NSString *)mapType
       andCode:(NSString *)code
   andCodeType:(NSString *)codeType
   andDelegate:(id<ServiceDelegate>)delegate{
    
    if ([super init]) {
        self.x = x;
        self.y = y;
        self.mapType = mapType;
        self.code = code;
        self.codeType = codeType;
    }
    return self;
    
}


-(void)getLocationName
{
    
    
    
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
//    //取消订单信息
//    
//    [messageDic setObject:@"cancel" forKey:KEY_Request_Type];
//    
//    
    NSString * url =GET_RIGHT_URL_WITH_Index(@"/web/phone/service/getLocation.jsp");
    
    
    __block NSString *message = nil;
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString: url] ];
    
    [request setPostValue:self.x forKey:@"x"];
    [request setPostValue:self.y forKey:@"y"];
    [request setPostValue:self.mapType forKey:@"mapType"];
    [request setPostValue:self.code forKey:@"code"];
    [request setPostValue:self.codeType forKey:@"codeType"];

    
    
    
    
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
            
            message = [[dic objectForKey:KEY_result] objectForKey:KEY_message];
            
                    
            if ([message length]==0) {
                
//                [messageDic setObject:message forKey:KEY_message];
                
                               
                
                NSString * apName = [dic objectForKey:@"apName"];
                NSString * apCode = [dic objectForKey:@"apCode"];
                
                NSArray * arr = [NSArray arrayWithObjects:apName,apCode, nil];
                
                CCLog(@"网络请求到的数据 %@ ",apName);
                
                if (apName != nil) {
                    [messageDic setObject:arr forKey:@"name"];
                    
                }
                else{
                    [messageDic setObject:@"noInfo" forKey:@"name"];
                    
                }
                

                
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
                [messageDic release];
                
            } else{
                
                [messageDic setObject:message forKey:KEY_message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                
                  [messageDic release];              
            }
            
        } else{
            
            
            [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
            
            if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                
                [self.delegate requestDidFinishedWithFalseMessage:messageDic];
                
            }
          
            
             [messageDic release];
                       
        }
    }];
    
    [request setFailedBlock:^{
        
        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [self.delegate requestDidFailed:messageDic];
            
        }
        
         [messageDic release];
        
    }];
    
//    CCLog(@"执行销毁之前");
    [request startAsynchronous];
    
   
    
}
@end
