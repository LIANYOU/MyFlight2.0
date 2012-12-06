//
//  CustomTableViewCell.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize airPortName = _airPortName;
@synthesize selectBtn = _selectBtn;
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
    [airPortName release];
    [selectBtn release];
    [_airPortName release];
    [_selectBtn release];
    [super dealloc];
}
@end
