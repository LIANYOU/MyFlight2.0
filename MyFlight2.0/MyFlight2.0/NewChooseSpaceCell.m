//
//  NewChooseSpaceCell.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "NewChooseSpaceCell.h"

@implementation NewChooseSpaceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        
        self.SpaceName.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  
    [super setSelected:selected animated:animated];

    if (selected) {
       
        self.SpaceName.textColor = [UIColor redColor];
    }
    else {
   
        self.SpaceName.textColor = [UIColor blackColor];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        
        self.SpaceName.textColor = [UIColor blackColor];
    }
    else {

        self.SpaceName.textColor = [UIColor blackColor];
    }
}


- (void)dealloc {
    [_view release];
    [_wImage release];
    [_dImage release];
    [_textView release];
    [_selectBtn release];
    [_sortImage release];
    [_sortimage release];
    [super dealloc];
}
@end
