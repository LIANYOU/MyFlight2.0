//
//  CalendarView.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:scrollView];
        [scrollView release];
    }
    return self;
}

-(void) setDate:(Date*) date {
    
    int currentYear = [date year];
    int currentMonth = [date month];
    
    
    int dayOfLastMonth = [date day];
    int lastYear = currentYear;
    int lastMonth = currentMonth + 6;
    
    if (lastMonth > 12) {
        lastMonth -= 12;
        lastYear++;
    }
    
    int dayCount = [Date getDaysOfMonth:lastMonth year:lastYear];
    if (dayOfLastMonth > dayCount) {
        dayOfLastMonth = dayCount;
    }
    
    
    int position = 0;
    BOOL addToPosition = YES;
    
    int cellOffset;
    
    for (int i = 0; i <= 6; i++) {
    
        MonthSection* section = [[MonthSection alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
        [section setYear:currentYear andMonth:currentMonth];
        
        if (i == 0) {
            [section disableCellBeforeDay:[date day]];
        }
        else if (i == 6) {
            [section disableCellAfterDay:dayOfLastMonth];
        }
        
        
        if ([section year] == [MonthDayCell selectedYear] && [section month] == [MonthDayCell selectedMonth]) {
            addToPosition = NO;
            cellOffset = 70 + [section cellRowForDay:[MonthDayCell selectedDay]] * 40;
        }
        
        if (addToPosition) {
            position += 70 + [section rowCount] * 40;
        }
        
        
        [scrollView addSubview:section];
        
        [section release];
    
        currentMonth++;
        if (currentMonth == 13) {
            currentMonth = 1;
            currentYear++;
        }
    }

    
    double height = 0;
    
    for (int i = 0; i <= [scrollView.subviews count] - 1; i++) {
        
        MonthSection* month = (MonthSection*)[scrollView.subviews objectAtIndex:i];
        
        month.frame = CGRectMake(0, height, month.frame.size.width, month.frame.size.height);
        height += month.frame.size.height;
    }
    
    
    position += cellOffset - (self.frame.size.height - 44) / 2;
    
    if (position < 0) {
        position = 0;
    }
    else if (position > height - self.frame.size.height) {
        position = height - self.frame.size.height;
    }
    

    scrollView.contentSize = CGSizeMake(self.frame.size.width, height);    
    scrollView.contentOffset = CGPointMake(0, position);
}

@end
