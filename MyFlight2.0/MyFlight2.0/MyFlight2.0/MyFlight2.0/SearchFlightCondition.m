//
//  SearchFlightCondition.m
//  MyFlight2.0
//
//  Created by sss on 12-12-8.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchFlightCondition.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
@implementation SearchFlightCondition
-(id)initWithfno:(NSString *)fno
           fdate:(NSString *)fdate
             dpt:(NSString *)dpt
             arr:(NSString *)arr
            hwld:(NSString *)hwld
{
    self = [super init];
    if (self) {
        self.fno = fno;
        self.fdate = fdate;
        self.dpt = dpt;
        self.arr = arr;
        self.hwld = hwld;
    }
    return self;
}

-(void)searchFlightCondition
{
    NSString * str1;
    if (self.fno!=nil) {
        str1=[NSString stringWithFormat:@"fno=%@",[self.fno stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
   
    NSString *str2;
    if (self.fdate!=nil) {
        str2=[NSString stringWithFormat:@"&fdate=%@",[self.fdate stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    
    NSString *str3;
    if (self.dpt!=nil) {
        str3=[NSString stringWithFormat:@"&dpt=%@",[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str3=@"";
    }
    
    NSString *str4;
    if (self.arr!=0) {
        str4=[NSString stringWithFormat:@"&arr=%@",[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.hwld!=0) {
        str5=[NSString stringWithFormat:@"&hwld=%@",[self.hwld stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str5=@"";
    }
    
     NSString * search=[NSString stringWithFormat:@"http://test.51you.com/web/phone/prod/flight/flightMovement.jsp?%@%@%@%@%@",str1,str2,str3,str4,str5];
   
    self.allData = [NSMutableData data];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:search]];
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];
        NSMutableArray * dataArr =  [self analysisData:self.allData];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dataArr,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"接受数据" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    [request startAsynchronous];

}

-(NSMutableArray *)analysisData:(NSData *)data
{
    self.dictionary = [NSDictionary dictionary];
    NSData * da = (NSData *)data;
    self.dictionary = [da objectFromJSONData];
    
    return [self.dictionary objectForKey:@"flightList"];
}

@end
