//
//  LookFlightConditionCell.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookFlightConditionCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *fno;
@property (retain, nonatomic) IBOutlet UILabel *company;
@property (retain, nonatomic) IBOutlet UILabel *data;
@property (retain, nonatomic) IBOutlet UILabel *today;
@property (retain, nonatomic) IBOutlet UILabel *realTime;
@property (retain, nonatomic) IBOutlet UILabel *excepterTime;
@property (retain, nonatomic) IBOutlet UILabel *startAirPort;
@property (retain, nonatomic) IBOutlet UILabel *endAirPort;
@property (retain, nonatomic) IBOutlet UILabel *station;
@property (retain, nonatomic) IBOutlet UIButton *closeBtn;



@end
