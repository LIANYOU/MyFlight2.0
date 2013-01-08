//
//  LookFlightConditionCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "LookFlightConditionCell.h"

@implementation LookFlightConditionCell

- (void)dealloc {
    [_fno release];
    [_company release];
    [_data release];
    [_today release];
    [_realTime release];
    [_excepterTime release];
    [_startAirPort release];
    [_endAirPort release];
    [_station release];
    [_closeBtn release];
    [super dealloc];
}
@end
