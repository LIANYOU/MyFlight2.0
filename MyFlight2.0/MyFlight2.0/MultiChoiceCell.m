//
//  MultiChoiceCell.m
//  MyFlight2.0
//
//  Created by lianyou on 13-1-11.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "MultiChoiceCell.h"

@implementation MultiChoiceCell

@synthesize delegate;
@synthesize choosed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        choosed = NO;
        
        self.frame = CGRectMake(0, 0, 300, 44);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        service = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, 80, 16)];
        
        service.backgroundColor = [UIColor clearColor];
        
        service.font = [UIFont systemFontOfSize:16.0f];
        service.textColor = FONT_COLOR_BIG_GRAY;
        service.textAlignment = UITextAlignmentLeft;
        
        [self addSubview:service];
        [service release];
        
        user = [[UILabel alloc] initWithFrame:CGRectMake(130, 15, 127, 14)];
        
        user.backgroundColor = [UIColor clearColor];
        
        user.font = [UIFont systemFontOfSize:14.0f];
        user.textColor = FONT_COLOR_BIG_GRAY;
        user.textAlignment = UITextAlignmentRight;
        
        [self addSubview:user];
        [user release];
        
        selection = [UIButton buttonWithType:UIButtonTypeCustom];
        
        selection.frame = CGRectMake(267, 11, 22, 22);
        
        [selection setImage:[UIImage imageNamed:@"icon_not_choosed.png"] forState:UIControlStateNormal];
        
        [selection addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:selection];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setServiceName:(NSString *)string
{
    service.text = string;
}

- (void) setUserName:(NSString *)string
{
    user.text = string;
}

- (void) click
{
    if(self.choosed)
    {
        self.choosed = NO;
        [selection setImage:[UIImage imageNamed:@"icon_not_choosed.png"] forState:UIControlStateNormal];
        [self.delegate didDeselectItemWithTag:self.tag];
    }
    else
    {
        self.choosed = YES;
        [selection setImage:[UIImage imageNamed:@"icon_choosed.png"] forState:UIControlStateNormal];
        [self.delegate didSelectItemWithTag:self.tag];
    }
}

@end
