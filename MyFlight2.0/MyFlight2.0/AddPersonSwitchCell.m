//
//  AddPersonSwitchCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AddPersonSwitchCell.h"

@implementation AddPersonSwitchCell

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
    [_cellTitle release];
    [_swith release];
    [super dealloc];
}
- (IBAction)switchOFFOrON:(UISwitch *)sender {
    
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:nil message:@"您登录后才能保存乘机人信息，是否登录?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"【暂不登录】",@"【登录】", nil];
    [alter show];
    [alter release];
}
@end
