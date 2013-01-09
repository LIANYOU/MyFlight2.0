//
//  TrafficCell.h
//  MyFlight2.0
//
//  Created by apple on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrafficCell : UITableViewCell
{
    
}
@property(nonatomic,retain)IBOutlet UILabel * lineName;
@property(nonatomic,retain)IBOutlet UILabel * firstBusTime;
@property(nonatomic,retain)IBOutlet UILabel * lastBusTime;
@property(nonatomic,retain)IBOutlet UILabel * lineIndex;
@property(nonatomic,retain)IBOutlet UILabel * lineFares;

@end
