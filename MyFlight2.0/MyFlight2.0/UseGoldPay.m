//
//  UseGoldPay.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-28.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "UseGoldPay.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@implementation UseGoldPay

-(id)initWithIsOpenAccount:(NSString * )isOpenAccount
               andMemberId:(NSString *)memberId
                   andSign:(NSString *)sign
             andOrderPrice:(NSString *)orderPrice
             andTotalPrice:(NSString *)totalPrice
               andProdType:(NSString *)prodType
                 andSource:(NSString *)source
             andAirCompany:(NSString *)airCompany
                    andDpt:(NSString *)dpt
                    andArr:(NSString *)arr
                andDisount:(NSString *)discount
           andInsuranceNum:(NSString *)insuranceNum
    andInsuranceTotalPrice:(NSString *)insuranceTotalPrice
                   andHwld:(NSString *)hwld
{
    if ([super init]) {
        self.isOpenAccount = isOpenAccount;
        self.memberId = memberId;
        self.sign = sign;
        self.orderPrice = orderPrice;
        self.totalPrice = totalPrice;
        self.prodType = prodType;
        self.source = source;
        self.airCompany = airCompany;
        self.dpt = dpt;
        self.arr = arr;
        self.discount = discount;
        self.insuranceNum = insuranceNum;
        self.insuranceTotalPrice = insuranceTotalPrice;
        self.hwId = hwld;
        
    }
    return self;
}

-(void)searchGold
{
    self.allData = [NSData data];
    self.dictionary = [NSDictionary dictionary];
    
    /*
    NSLog(@"%@",self.isOpenAccount);
    NSLog(@"%@",self.memberId);
    NSLog(@"%@",self.sign);
    NSLog(@"%@",self.orderPrice);
    NSLog(@"%@",self.totalPrice);
    NSLog(@"%@",self.prodType);
    NSLog(@"%@",self.source);
    NSLog(@"%@",self.airCompany);
    NSLog(@"%@",self.dpt);
    NSLog(@"%@",self.arr);
    NSLog(@"%@",self.discount);
    NSLog(@"%@",self.insuranceNum);
    NSLog(@"%@",self.insuranceTotalPrice);
    NSLog(@"%@",self.hwId);
     */
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/order/flight/account.jsp"]];
    
    [request setPostValue:self.isOpenAccount forKey:@"isOpenAccount"];
    [request setPostValue:self.memberId forKey:@"memberId"];
    [request setPostValue:self.sign forKey:@"sign"];
    [request setPostValue:self.orderPrice forKey:@"orderPrice"];
    [request setPostValue:self.totalPrice forKey:@"totalPrice"];
    [request setPostValue:self.prodType forKey:@"prodType"];
    [request setPostValue:self.source forKey:@"source"];
    [request setPostValue:self.airCompany forKey:@"airCompany"];
    [request setPostValue:self.dpt forKey:@"dpt"];
    [request setPostValue:self.arr forKey:@"arr"];
    [request setPostValue:self.discount forKey:@"discount"];
    [request setPostValue:self.insuranceNum forKey:@"insuranceNum"];
    [request setPostValue:self.insuranceTotalPrice forKey:@"insuranceTotalPrice"];
    [request setPostValue:self.hwId forKey:@"hwId"];
    [request setRequestMethod:@"POST"];
    __block NSDictionary * dictionary = [NSDictionary dictionary];
    
    [request setCompletionBlock:^{
        
        self.allData = [request responseData];
        
       
        
        self.dictionary = [self.allData objectFromJSONData];
                
        dictionary = [[self.dictionary objectForKey:@"result"] objectForKey:@"message"];
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.dictionary,@"arr", nil];
        NSNotification * not = [NSNotification notificationWithName:@"返回金币数目" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];

    
    [request setDelegate:self];
    [request startAsynchronous];

}

@end
