//
//  SelectResultCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectResultCell : UITableViewCell
{    
  
}
@property (retain, nonatomic) IBOutlet UILabel *temporaryLabel;
@property (retain, nonatomic) IBOutlet UILabel *airPort;
@property (retain, nonatomic) IBOutlet UILabel *palntType;
@property (retain, nonatomic) IBOutlet UILabel *beginTime;
@property (retain, nonatomic) IBOutlet UILabel *endTime;
@property (retain, nonatomic) IBOutlet UILabel *pay;
@property (retain, nonatomic) IBOutlet UILabel *discount;
@property (retain, nonatomic) IBOutlet UILabel *ticketCount;


@end
