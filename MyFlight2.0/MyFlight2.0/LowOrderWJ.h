//
//  LowOrderWJ.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-4.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"
@interface LowOrderWJ : NSObject<ServiceDelegate>

@property (nonatomic,retain) NSString * source;    //来源
@property (nonatomic,retain) NSString * dpt;//出发机场
@property (nonatomic,retain) NSString * arr;//到达机场
@property (nonatomic,retain) NSString * dateStart;//最早时间
@property (nonatomic,retain) NSString * dateEnd;//最晚时间
@property (nonatomic,retain) NSString * discount;//最高折扣
@property (nonatomic,retain) NSString * mobile;//手机号
@property (nonatomic,retain) NSString * hwId;//硬件ID
@property (nonatomic,retain) NSString * memberId;//用户ID
@property (nonatomic,retain) NSString * sign;//MD5（memberId+source+token）
@property (nonatomic, assign) id<ServiceDelegate> delegate;


-(id)initWithSource:(NSString *)source
             andDpt:(NSString *)dpt
             andArr:(NSString *)arr
       andDateSatrt:(NSString *)dateSatrt
         andDateEnd:(NSString *)dateEnd
        andDiscount:(NSString *)discount
          andMobile:(NSString *)mobile
            andHwId:(NSString *)hwId
        andMemberId:(NSString *)memberId
            andSign:(NSString *)sign
        andDelegate:(id<ServiceDelegate>) delegate;


-(void) getLowOrderInfo;

@end
