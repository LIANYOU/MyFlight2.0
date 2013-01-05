//
//  ResultForLeijiViewCell.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/5/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "ResultForLeijiViewCell.h"

@implementation ResultForLeijiViewCell

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
    [_nameLabel release];
    [_thisDetailLabel release];
    [super dealloc];
}
@end
