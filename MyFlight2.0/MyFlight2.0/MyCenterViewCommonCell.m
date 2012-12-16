
//
//  MyCenterViewCommonCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-15.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "MyCenterViewCommonCell.h"

@implementation MyCenterViewCommonCell

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
    [_firstLabel release];
    [_secondLabel release];
    [_imaeView release];
    [super dealloc];
}
@end
