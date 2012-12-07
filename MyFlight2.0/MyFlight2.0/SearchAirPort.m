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
@implementation SearchAirPort
-(id) initWithdpt:(NSString *)dpt
              arr:(NSString *)arr
             date:(NSString *)date
            ftype:(int)ftype
            cabin:(int) cabin
          carrier:(NSString *)carrier
          dptTime:(NSString *)dptTime
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
    NSString * str1;
    if (self.dpt!=nil) {
        str1=[NSString stringWithFormat:@"dpt=%@",[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
    NSString *str2;
    if (self.arr!=nil) {
        str2=[NSString stringWithFormat:@"&arr=%@",[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    NSString *str3;
    if (self.date!=nil) {
        str3=[NSString stringWithFormat:@"&date=%@",[self.date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    NSString *str4;
    if (self.ftype!=0) {
        str4=[NSString stringWithFormat:@"&ftype=%d",self.ftype];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.cabin!=0) {
        str5=[NSString stringWithFormat:@"&cabin=%d",self.cabin];
    }
    else
    {
        str5=@"";
    }
    NSString *str6;
    if (self.carrier!=nil) {
        str6=[NSString stringWithFormat:@"&carrier=%@",[self.carrier stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str6=@"";
    }
    NSString *str7;
    if (self.dptTime!=nil) {
        str7=[NSString stringWithFormat:@"&dptTime=%@",[self.dptTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str7=@"";
    }
    NSString *str8;
    if (self.qryFlag!=nil) {
        str8=[NSString stringWithFormat:@"&isource=%@",[self.qryFlag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str8=@"";
    }
    
    NSString * search=[NSString stringWithFormat:@"http://test.51you.com/web/phone/prod/flight/flightSearchPhone.jsp?%@%@%@%@%@%@%@%@",str1,str2,str3,str4,str5,str6,str7,str8];
    

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
    
    
}
@end
