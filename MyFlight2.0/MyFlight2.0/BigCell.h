//
//  BigCell.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *airPort;
@property (retain, nonatomic) IBOutlet UILabel *palntType;
@property (retain, nonatomic) IBOutlet UILabel *beginTime;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *scheduleDate;
@property (retain, nonatomic) IBOutlet UILabel *beginAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *endAirPortName;

@end
