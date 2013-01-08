//
//  ShowSelectedCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-21.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ShowSelectedCell.h"

@implementation ShowSelectedCell

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
    [_airPortImage release];
    [_airportName release];
    [_selectBtn release];
    [super dealloc];
}
@end
