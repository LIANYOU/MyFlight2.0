//
//  SearchAirPort.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchAirPort.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "ASIFormDataRequest.h"
@implementation SearchAirPort
-(id) initWithdpt:(NSString *)dpt
              arr:(NSString *)arr
             date:(NSString *)date
            ftype:(NSString *)ftype
            cabin:(int) cabin
          carrier:(NSString *)carrier
          dptTime:(int)dptTime
          qryFlag:(NSString *)qryFlag
{
    self = [super init];
    if (self) {
        self.dpt = dpt;
        self.arr = arr;
        self.date = date;
        self.ftype = ftype;
        self.cabin = cabin;
        self.carrier = carrier;
        self.dptTime = dptTime;
        self.qryFlag = qryFlag;
    }
    return self;
}

-(void)searchAirPort
{

    self.allData = [NSMutableData data];

    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/flightSearchPhone.jsp"]];
    [request setPostValue:[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"dpt"];
    [request setPostValue:[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"arr"];
    [request setPostValue:[self.date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"date"];
    [request setPostValue:@"v1.0" forKey:@"edition"];
    [request setPostValue:[self.qryFlag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"source"];
    
    NSLog(@"机场查询时候使用条件  %@, %@, %@",self.dpt,self.arr,self.date);
    
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];

        NSArray * dataArr =  [self analysisData:self.allData];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dataArr,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"接受数据" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
    }];
    [request setFailedBlock:^{
        
        NSError *error = [request error];
        
        NSMutableDictionary * diccc = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"网络不给力，请重新加载",@"arr", nil];

        NSNotification * not = [NSNotification notificationWithName:@"返回错误信息" object:self userInfo:diccc];
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
        NSLog(@"-----------Error downloading image: %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}

-(NSArray *)analysisData:(NSData *)data
{
    self.dictionary = [NSDictionary dictionary];
    NSData * da = (NSData *)data;
    self.dictionary = [da objectFromJSONData];
    
    NSArray * arr = [self.dictionary objectForKey:@"outBounds"];
   
    return arr;
}


@end
