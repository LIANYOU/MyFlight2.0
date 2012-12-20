//
//  searchCabin.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "searchCabin.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation searchCabin
-(id) initWithdpt:(NSString *)dpt
              arr:(NSString *)arr
             date:(NSString *)date
             code:(NSString *)code
          edition:(NSString *) edition
           source:(NSString *)source
{
    self = [super init];
    if (self) {
        self.dpt = dpt;
        self.arr = arr;
        self.date = date;
        self.code = code;
        self.edition = edition;
        self.source = source;
    }
    return self;

}

-(void)searchCabin
{
    self.allData = [NSMutableData data];
    
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://test.51you.com/web/phone/prod/flight/searchCabin.jsp"]];
    [request setPostValue:[self.dpt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"dpt"];
    [request setPostValue:[self.arr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"arr"];
    [request setPostValue:[self.date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"date"];
    [request setPostValue:[self.code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"flightNo"];
    [request setPostValue:self.edition forKey:@"edition"];
    [request setPostValue:self.source forKey:@"source"];
    
    NSLog(@"%@,,%@,,%@,,%@,,%@",self.dpt,self.arr,self.date,self.edition,self.source);
    
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];
        
        NSArray * dataArr =  [self analysisData:self.allData];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dataArr,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"接受舱位数据" object:self userInfo:dic];
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

    NSArray * arr = [self.dictionary objectForKey:@"cabins"];
    
    return arr;
}
@end
