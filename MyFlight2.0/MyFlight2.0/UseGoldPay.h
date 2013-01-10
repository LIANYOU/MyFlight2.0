//
//  UseGoldPay.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-28.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UseGoldPay : NSObject

@property (nonatomic,retain) NSData * allData;
@property (nonatomic,retain) NSDictionary * dictionary;

@property (nonatomic,retain) NSString * isOpenAccount;//是否使用账户	默认为true
@property (nonatomic,retain) NSString * memberId;
@property (nonatomic,retain) NSString * sign;  //MD5（memberId+ source +mobile+token）
@property (nonatomic,retain) NSString * orderPrice;//机票的票面价
@property (nonatomic,retain) NSString * totalPrice;//机票总价
@property (nonatomic,retain) NSString * prodType;//产品类型  必填 01机票
@property (nonatomic,retain) NSString * source; //来源
@property (nonatomic,retain) NSString * airCompany;//航空公司
@property (nonatomic,retain) NSString * dpt;//出发机场
@property (nonatomic,retain) NSString * arr;//到达机场
@property (nonatomic,retain) NSString * discount;
@property (nonatomic,retain) NSString * insuranceNum;//保险数
@property (nonatomic,retain) NSString * insuranceTotalPrice;//保险总金额
@property (nonatomic,retain) NSString * hwId;

-(id)initWithIsOpenAccount:(NSString *)isOpenAccount
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
                   andHwld:(NSString *)hwld;

-(void)searchGold;
@end
