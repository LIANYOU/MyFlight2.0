//
//  discountCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface discountCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *count;
@property (retain, nonatomic) IBOutlet UILabel *beginDate;
@property (retain, nonatomic) IBOutlet UILabel *endDate;
@property (retain, nonatomic) IBOutlet UIButton *selectBtn;

@end
