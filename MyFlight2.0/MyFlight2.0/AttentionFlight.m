//
//  AttentionFlight.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-25.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AttentionFlight.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@implementation AttentionFlight
@synthesize delegate = _delegate;
-(id) initWithMemberId:(NSString *)memberId
          andorgSource:(NSString *)orgSource
                andFno:(NSString *)fno
              andFdate:(NSString *)fdate
                andDpt:(NSString *)dpt
                andArr:(NSString *)arr
            andDptTime:(NSString *)dptTime
            andArrTime:(NSString *)arrTime
            andDptName:(NSString *)dptName
            andArrName:(NSString *)arrName
               andType:(NSString *)type
             andSendTo:(NSString *)sendTo
            andMessage:(NSString *)message
              andToken:(NSString *)token
             andSource:(NSString *)source
               andHwId:(NSString *)hwId
        andServiceCode:(NSString *)serviceCode
{
    self = [super init];
    if (self) {
        self.memberId = memberId;
        self.orgSource = orgSource;
        self.fno = fno;
        self.fdate = fdate;
        self.dpt = dpt;
        self.arr = arr;
        self.dptTime = dptTime;
        self.arrTime = arrTime;
        self.dptName = dptName;
        self.arrName = arrName;
        self.type = type;
        self.sendTo = sendTo;
        self.message = message;
        self.token = token;
        self.source = source;
        self.hwId = hwId;
        self.serviceCode = serviceCode;

    }
    return self;
}
-(void)lookFlightAttention
{
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Flight/BookFlightMovement.json"]];
    
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.orgSource forKey:@"orgSource"];
    [request setPostValue:self.fno  forKey:@"fno"];
    [request setPostValue:self.fdate  forKey:@"fdate"];
    [request setPostValue:self.dpt forKey:@"dpt"];
    [request setPostValue:self.arr forKey:@"arr"];
    [request setPostValue:self.dptTime forKey:@"dptTime"];
    [request setPostValue:self.arrTime forKey:@"arrTime"];
    [request setPostValue:self.dptName forKey:@"dptName"];
    [request setPostValue:self.arrName forKey:@"arrName"];
    [request setPostValue:self.type forKey:@"type"];
    [request setPostValue:self.sendTo forKey:@"sendTo"];
    [request setPostValue:self.message forKey:@"message"];
    [request setPostValue:self.token forKey:@"token"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setPostValue:self.serviceCode forKey:@"serviceCode"];

    
    self.allData = [NSData data];
    self.dictionary = [NSDictionary dictionary];
    
    __block NSDictionary * dictionary = [NSDictionary dictionary];
    
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];
        
    
        
        self.dictionary = [self.allData objectFromJSONData];
        
      
        
        dictionary = [self.dictionary objectForKey:@"result"];
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dictionary,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"关注航班" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];
//        [self.delegate reloadConditionTableviewData];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];

  
}
@end
