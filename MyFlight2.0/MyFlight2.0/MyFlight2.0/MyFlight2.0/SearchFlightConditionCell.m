//
//  SearchFlightConditionCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-9.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchFlightConditionCell.h"

@implementation SearchFlightConditionCell

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
    [_flightCompany release];
    [_flightNum release];
    [_deptAirport release];
    [_arrAirport release];
    [_expectedDeptTime release];
    [_expectedArrTime release];
    [_deptTime release];
    [_arrTime release];
    [_flightState release];
    [super dealloc];
}
@end
