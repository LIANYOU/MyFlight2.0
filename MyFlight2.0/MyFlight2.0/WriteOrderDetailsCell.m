//
//  WriteOrderDetailsCell.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "WriteOrderDetailsCell.h"

@implementation WriteOrderDetailsCell

@synthesize personName = _personName;
@synthesize phoneNumber = _phoneNumber;
@synthesize person = _person;
@synthesize addPerson = _addPerson;

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
    [personName release];
    [phoneNumber release];
    [addPerson release];
    [_personName release];
    [_phoneNumber release];
    [_person release];
    [_phone release];
    [_addPerson release];
    [super dealloc];
}
@end
