//
//  WriteOrderCell.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "WriteOrderCell.h"

@implementation WriteOrderCell
@synthesize backView = _backView;
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

    [_backView release];
    [_HUButton release];
    [_endAirPortName release];
    [_endTime release];
    [_startAirPortName release];
    [_startTime release];
    [_date release];
    [_plantType release];
    [_airPortName release];
    [super dealloc];
}
@end
