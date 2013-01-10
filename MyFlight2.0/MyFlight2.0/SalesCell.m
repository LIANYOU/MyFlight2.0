//
//  SalesCell.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-10.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SalesCell.h"

@implementation SalesCell

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
    [_name release];
    [super dealloc];
}
@end
