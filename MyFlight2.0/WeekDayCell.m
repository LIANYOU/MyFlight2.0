//
//  WeekDayCell.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WeekDayCell.h"

static NSArray* chineseWeekDays;

@implementation WeekDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:209/255.0 green:201/255.0 blue:187/255.0 alpha:1];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 1, frame.size.height - 1)];
        label.textColor = [UIColor colorWithRed:178/255.0 green:172/255.0 blue:163/255.0 alpha:1];
        label.backgroundColor = [UIColor colorWithRed:237/255.0 green:232/255.0 blue:226/255.0 alpha:1];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        if (!chineseWeekDays) {
            chineseWeekDays = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
            [chineseWeekDays retain];
        }
    }
    return self;
}

-(int) day {
    return _day;
}

-(void) setDay:(int) day {
    _day = day;
    label.text = [chineseWeekDays objectAtIndex:day];
}

@end
