//
//  WJOrderBasicCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJOrderBasicCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *orderNo;
@property (retain, nonatomic) IBOutlet UILabel *orderData;
@property (retain, nonatomic) IBOutlet UILabel *orderStation;
@property (retain, nonatomic) IBOutlet UILabel *payStation;
@property (retain, nonatomic) IBOutlet UIButton *orderAllPay;
@property (retain, nonatomic) IBOutlet UIView *infoView;
@property (retain, nonatomic) IBOutlet UILabel *discount;
@property (retain, nonatomic) IBOutlet UILabel *discountPay;
@property (retain, nonatomic) IBOutlet UILabel *slive;
@property (retain, nonatomic) IBOutlet UILabel *gold;
@property (retain, nonatomic) IBOutlet UILabel *payOnline;
@end
