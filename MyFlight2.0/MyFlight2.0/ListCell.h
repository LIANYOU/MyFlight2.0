//
//  ListCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *discount;
@property (retain, nonatomic) IBOutlet UILabel *startName;
@property (retain, nonatomic) IBOutlet UILabel *endName;
@property (retain, nonatomic) IBOutlet UILabel *startDate;
@property (retain, nonatomic) IBOutlet UILabel *endDate;
@property (retain, nonatomic) IBOutlet UILabel *searchDate;
@property (retain, nonatomic) IBOutlet UILabel *searchDiscount;
@property (retain, nonatomic) IBOutlet UILabel *searchPay;
@property (retain, nonatomic) IBOutlet UIButton *closeBtn;




@end
