//
//  WriteOrderCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteOrderCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UILabel *HUButton;
@property (retain, nonatomic) IBOutlet UILabel *endAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *startAirPortName;
@property (retain, nonatomic) IBOutlet UILabel *startTime;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *plantType;
@property (retain, nonatomic) IBOutlet UILabel *airPortName;
@end
