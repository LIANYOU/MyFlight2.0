//
//  PassengerCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassengerCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *number;
@property (retain, nonatomic) IBOutlet UILabel *orderNo;
@property (retain, nonatomic) IBOutlet UILabel *orderInfo;
@property (retain, nonatomic) IBOutlet UIImageView *image;

@end
