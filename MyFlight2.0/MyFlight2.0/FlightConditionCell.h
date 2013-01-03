//
//  FlightConditionCell.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightConditionCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *HUButton;
@property (retain, nonatomic) IBOutlet UILabel *endAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *startAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *startTime;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *plantType;
@property (retain, nonatomic) IBOutlet UILabel *airPortName;
@property (retain, nonatomic) IBOutlet UIButton *changeTicket;
@end
