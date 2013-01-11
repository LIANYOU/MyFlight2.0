//
//  MultiChoiceCell.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-11.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "MultiChoiceCell.h"

@implementation MultiChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.frame = CGRectMake(0, 0, 300, 44);
        
        UIButton *selection = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
