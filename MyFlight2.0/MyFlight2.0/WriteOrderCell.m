//
//  WriteOrderCell.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "WriteOrderCell.h"

@implementation WriteOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [HUButton release];
    [airPortName release];
    [plantType release];
    [date release];
    [startTime release];
    [startAirPortName release];
    [image release];
    [endTime release];
    [endAirPortName release];
    [backView release];
    [_backView release];
    [super dealloc];
}
@end
