//
//  MyOrderListCell.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *totalMoney; //订单金额
 
@property (retain, nonatomic) IBOutlet UILabel *orderState; //订单状态

@property (retain, nonatomic) IBOutlet UILabel *areaInfo; //出发到达地点

@property (retain, nonatomic) IBOutlet UILabel *orderTime; //订单日期

@end
