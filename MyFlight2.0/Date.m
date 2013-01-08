//
//  Date.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

static NSArray* daysOfMonth;

#import "Date.h"

@implementation Date

-(void) setYear:(int) year month: (int) month day: (int) day {
    _year = year;
    _month = month;
    _day = day;
}

-(int) year {
    return _year;
}

-(int) month {
    return _month;
}

-(int) day {
    return _day;
}


+(int) getDaysOfMonth: (int) month year: (int) year {
    
    if (!daysOfMonth) {
        daysOfMonth = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:31], [NSNumber numberWithInt:28], [NSNumber numberWithInt:31], [NSNumber numberWithInt:30], [NSNumber numberWithInt:31], [NSNumber numberWithInt:30], [NSNumber numberWithInt:31], [NSNumber numberWithInt:31], [NSNumber numberWithInt:30], [NSNumber numberWithInt:31], [NSNumber numberWithInt:30], [NSNumber numberWithInt:31], nil];
        [daysOfMonth retain];
    }
    
    int count = [[daysOfMonth objectAtIndex:month - 1] intValue];
    
    if (month == 2 && [Date isLeapYear:year]) {
        count++;
    }
    
    return count;
}

+(BOOL) isLeapYear: (int) year {

    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

-(void) substractDays: (int) days {

    for (int i = 1; i <= days; i++) {
        
        if (_day == 1) {
            if (_month == 1) {
                _month = 12;
                _day = 31;
                _year--;
            }
            else {
                _month--;
                _day = [Date getDaysOfMonth:_month year:_year];
            }
        }
        else {
            _day--;
        }
    }
}

-(void) addDays: (int) days {
    
    for (int i = 1; i <= days; i++) {
        
        if (_day == [Date getDaysOfMonth:_month year:_year]) {
            if (_month == 12) {
                _month = 1;
                _day = 1;
                _year++;
            }
            else {
                _month++;
                _day = 1;
            }
        }
        else {
            _day++;
        }
    }
}

-(int) getDaysOfYear {

    int days = 0;
    
    for (int i = 1; i <= _month - 1; i++) {
        days += [Date getDaysOfMonth:i year:_year];
    }
    
    days += _day;

    return days;
}

-(int) weekDay {
    
    int week = 6;
    
    for (int i = 2000; i <= _year - 1; i++) {
        week = (week + ([Date isLeapYear:i] ? 2 : 1)) % 7;
    }
    
    
    return (week + [self getDaysOfYear] - 1) % 7;
}

+(Date*) today {

    NSDate* date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];

    Date* todayDate = [[[Date alloc] init] autorelease];
    [todayDate setYear:[dateComponents year] month:[dateComponents month] day:[dateComponents day]];
    
    return todayDate;
}

@end
