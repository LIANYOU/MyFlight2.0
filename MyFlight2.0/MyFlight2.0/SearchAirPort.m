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
//    NSString * str1;
//    if (self.dpt!=nil) {
//        str1=[NSString stringWithFormat:@"dpt=%@",[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str1=@"";
//    }
//    NSString *str2;
//    if (self.arr!=nil) {
//        str2=[NSString stringWithFormat:@"&arr=%@",[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str2=@"";
//    }
//    NSString *str3;
//    if (self.date!=nil) {
//        str3=[NSString stringWithFormat:@"&date=%@",[self.date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str3 = @"";
//    }
//
//    NSString *str4;
//    if (self.ftype) {
//        str4=[NSString stringWithFormat:@"&ftype=%@",[self.ftype stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str4=@"";
//    }
//    NSString *str5;
//    if (self.cabin) {
//        str5=[NSString stringWithFormat:@"&cabin=%d",self.cabin];
//    }
//    else
//    {
//        str5=@"";
//    }
//    NSString *str6;
//    if (self.carrier!=nil) {
//        str6=[NSString stringWithFormat:@"&carrier=%@",[self.carrier stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str6=@"";
//    }
//    NSString *str7;
//    if (self.dptTime) {
//        str7=[NSString stringWithFormat:@"&dptTime=%d",self.dptTime];
//    }
//    else
//    {
//        str7=@"";
//    }
//    NSString *str8;
//    if (self.qryFlag!=nil) {
//        str8=[NSString stringWithFormat:@"&isource=%@",[self.qryFlag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else
//    {
//        str8=@"";
//    }
    // http://test.51you.com/web/phone/prod/flight/flightSearchPhone.jsp
    // http://test.51you.com/web/phone/prod/flight/flightSearchPhone.jsp
//    NSString * search=[NSString stringWithFormat:@"http://test.51you.com/web/phone/prod/flight/flightSearchPhone.jsp?%@%@%@%@%@%@%@%@",str1,str2,str3,str4,str5,str6,str7,str8];
//    
//    NSLog(@"search = %@",search);

    self.allData = [NSMutableData data];
    
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://test.51you.com/web/phone/prod/flight/flightSearchPhone.jsp"]];
    [request setPostValue:[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"dpt"];
    [request setPostValue:[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"arr"];
    [request setPostValue:[self.date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"date"];
//    [request setPostValue:[self.ftype stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"ftype"];
//    [request setPostValue:[NSString stringWithFormat:@"%d",self.cabin] forKey:@"cabin"];
//    [request setPostValue:[self.carrier stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"carrier"];
//    [request setPostValue:[NSString stringWithFormat:@"%d",self.dptTime]  forKey:@"dptTime"];
//    [request setPostValue:[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"dpt"];
    [request setPostValue:@"v1.0" forKey:@"edition"];
    [request setPostValue:[self.qryFlag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"source"];
    
    //__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:search]];
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];

        NSArray * dataArr =  [self analysisData:self.allData];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dataArr,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"接受数据" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
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
