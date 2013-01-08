//
//  SmallListCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallListCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UILabel *discount;
@property (retain, nonatomic) IBOutlet UILabel *startName;
@property (retain, nonatomic) IBOutlet UILabel *endName;
@property (retain, nonatomic) IBOutlet UILabel *startDate;
@property (retain, nonatomic) IBOutlet UILabel *endDate;
@property (retain, nonatomic) IBOutlet UIButton *closeBtn;

@end
