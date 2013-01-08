//
//  BigCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "BigCell.h"

@implementation BigCell

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
    [_view release];
    [_nextDayLabel release];
    [_planeImage release];
    [super dealloc];
}
@end
