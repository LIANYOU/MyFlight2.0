//
//  MonthSection.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonthSection.h"
#import "ColorUility.h"
@implementation MonthSection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        titleBar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        [titleBar setBackgroundColor:[UIColor colorWithRed:28/255.0 green:92/255.0 blue:178/255.0 alpha:1]];
        titleBar.textColor = [UIColor whiteColor];
        [self addSubview:titleBar];
        [titleBar release];
        
        weekDaysBar = [[UIView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 30)];
        [weekDaysBar setBackgroundColor:[UIColor colorWithRed:28/255.0 green:92/255.0 blue:178/255.0 alpha:1]];
        [self addSubview:weekDaysBar];
        [weekDaysBar release];
 
        container = [[UIView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)];
        [container setBackgroundColor:[UIColor blackColor]];
        [self addSubview:container]; 
        [container release];
    }
    return self;
}

-(int) year {
    return _year;
}

-(int) month {
    return _month;
}

-(int) rowCount {
    return _rowCount;
}

-(void) setYear:(int) year andMonth:(int) month {
    
    _year = year;
    _month = month;
    
    [self setHeight];
    [self buildTitleBar];
    [self buildMonthDays];
}

-(void) disableCellBeforeDay:(int) day {

    for (MonthDayCell* cell in container.subviews) {
        if ([cell month] < _month || ([cell month] == _month && [cell day] < day)) {
            [cell setIsInteractable:NO];
        }
    }
}

-(void) disableCellAfterDay:(int) day {
    
    for (MonthDayCell* cell in container.subviews) {
        if ([cell month] > _month || ([cell month] == _month && [cell day] > day)) {
            [cell setIsInteractable:NO];
        }
    }
}

-(void) setContainerSize {

    container.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70);
}

-(void) setHeight {

    int days = [Date getDaysOfMonth:_month year:_year];
    
    Date* date = [[Date alloc] init];
    [date setYear:_year month:_month day:1];
    
    int column = [date weekDay];
    int row = 0;
    
    [date release];
    
    for (int i = 1; i <= days; i++) {
        
        column++;
        if (column == 7) {
            column = 0;
            row++;
        }
    }
    
    _rowCount = row + 1;
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, (row + 1) * 40 + 70);
    [self setContainerSize];
}

-(void) buildTitleBar {
    
    [titleBar setText:[NSString stringWithFormat:@"%d年%d月", _year, _month]];
    titleBar.textAlignment = UITextAlignmentCenter;
    
    
    double cellWidth = self.frame.size.width / 7;
    
    for (int i = 0; i <= 6; i++)
    {
        WeekDayCell* cell = [[WeekDayCell alloc] initWithFrame:CGRectMake(cellWidth * i, 0, cellWidth, 30)];
        [cell setDay:i];
        [weekDaysBar addSubview:cell];
        [cell release];
    }
}

-(void) buildMonthDays {
    
    Date* date = [[Date alloc] init];
    [date setYear:_year month:_month day:1];

    [date substractDays:[date weekDay]];
    
    double cellWidth = container.frame.size.width / 7;
    double cellHeight = container.frame.size.height / _rowCount;
    
    int weekDay = 0;
    int row = 0;
    
    for (int i = 1; i <= _rowCount * 7; i++) {
        
        MonthDayCell* cell = [[MonthDayCell alloc] initWithFrame:CGRectMake(cellWidth * weekDay, cellHeight * row, cellWidth, cellHeight)];
        
        cell.row = row;
        
        [cell setYear:[date year] month:[date month] day:[date day]];
        [cell setWeekDay:weekDay];
        [cell setIsGrayed:[date month] != _month];
        [cell setIsInteractable:YES];
        
        [container addSubview:cell];
        [cell release];
    
        
        [date addDays:1];
        
        weekDay++;
        
        if (weekDay == 7) {
            weekDay = 0;
            row++;
        }
    }
    
    [date release];
}

-(int) cellRowForDay: (int) day {

    for (MonthDayCell* cell in container.subviews) {
        if (![cell isGrayed] && [cell day] == day) {
            return [cell row];
        }
    }
    
    return 0;
}


@end
