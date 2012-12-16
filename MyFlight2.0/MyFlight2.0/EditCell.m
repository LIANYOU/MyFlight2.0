//
//  EditCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "EditCell.h"

@implementation EditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
        _firstLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_firstLabel];
        
        _text = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 190, 20)];
        _text.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_text];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
