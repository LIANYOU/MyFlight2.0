//
//  WriterOrderCommonCell.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "WriterOrderCommonCell.h"

@implementation WriterOrderCommonCell
@synthesize firstLable = _firstLable;
@synthesize secondLable = _secondLable;
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
    [firstLable release];
    [secondLabel release];
    [_firstLable release];
    [_secondLable release];
    [_backView release];
    [_imageLabel release];
    [super dealloc];
}
@end
