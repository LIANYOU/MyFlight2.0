//
//  MonthDayCell.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonthDayCell.h"

static int _selectedYear;
static int _selectedMonth;
static int _selectedDay;

static int _nowYear;
static int _nowMonth;
static int _nowToday;

static UIColor* normalColor;
static UIColor* saturdayColor;
static UIColor* sundayColor;
static UIColor* selectedColor;
static UIColor* todayColor;

static UIFont* textLabelFont;

@implementation MonthDayCell
@synthesize row;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:218/255.0 green:210/255.0 blue:196/255.0 alpha:1];
        
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 1, frame.size.height / 2)];
        dayLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:dayLabel];
        [dayLabel release];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width - 1, frame.size.height / 2 - 1)];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:textLabel];    
        [textLabel release];
        
        
        if (!normalColor) {
            normalColor = [UIColor colorWithRed:248/255.0 green:245/255.0 blue:241/255.0 alpha:1];
            [normalColor retain];
        }
        
        if (!saturdayColor) {
            saturdayColor = [UIColor colorWithRed:248/255.0 green:245/255.0 blue:241/255.0 alpha:1];
            [saturdayColor retain];
        }
        
        if (!sundayColor) {
            sundayColor = [UIColor colorWithRed:248/255.0 green:245/255.0 blue:241/255.0 alpha:1];
            [sundayColor retain];
        }

        if (!selectedColor) {
            selectedColor = [UIColor colorWithRed:38/255.0 green:108/255.0 blue:192/255.0 alpha:1];
            [selectedColor retain];
        }

    
        if (!todayColor) {
            todayColor = [UIColor colorWithRed:1 green:1 blue:0.8 alpha:1];
            [todayColor retain];
        }
    }
    return self;
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

+(int) selectedYear {
    return _selectedYear;
}

+(int) selectedMonth {
    return _selectedMonth;
}

+(int) selectedDay {
    return _selectedDay;
}

+(void) selectYear: (int) year month:(int) month day:(int) day {
    
    _selectedYear = year;
    _selectedMonth = month;
    _selectedDay = day;
}

-(void) buttonClicked {
    
    [self setSelected:YES];
    
    _selectedYear = _year;
    _selectedMonth = _month;
    _selectedDay = _day;
    
    [[SelectCalendarController instance] selectDate];
}

-(void) setYear: (int) year month:(int) month day:(int) day {
    
    _year = year;
    _month = month;
    _day = day;
    
    _nowYear = year;
    _nowMonth = month;
    _nowToday = day;
    
 
    
   

    
    

    [dayLabel setText:[NSString stringWithFormat:@"%d", day]];
    [textLabel setText:[ChineseCalendar findFestivalOrDayWithYear:_year month:_month day:_day]];
    
    
    if (!textLabelFont) {
        textLabelFont = [UIFont systemFontOfSize:12];
    }
    
    [textLabel setFont:textLabelFont];
}

-(void) setWeekDay: (int) weekDay {
    
    _weekDay = weekDay;
    [self updateBackground];
}

-(void) updateTextColor {

    if (_isGrayed || !_isInteractable) {
        dayLabel.textColor = [UIColor colorWithRed:182/255.0 green:175/255.0 blue:167/255.0 alpha:1];
        
        textLabel.textColor = [UIColor colorWithRed:182/255.0 green:175/255.0 blue:167/255.0 alpha:1];
    }
    else {
        dayLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        textLabel.textColor = [UIColor colorWithRed:182/255.0 green:175/255.0 blue:167/255.0 alpha:1];
        
        
    }
    if ([textLabel.text isEqualToString:@"春节"] || [textLabel.text isEqualToString:@"元旦"] || [textLabel.text isEqualToString:@"清明"]|| [textLabel.text isEqualToString:@"端午节"]|| [textLabel.text isEqualToString:@"劳动节"]|| [textLabel.text isEqualToString:@"国庆节"]|| [textLabel.text isEqualToString:@"中秋节"]) {
        dayLabel.textColor  = [UIColor redColor];
        textLabel.textColor = [UIColor redColor];
    }
    
    NSDate* date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    

    if (_nowYear == [dateComponents year] && _nowMonth == [dateComponents month] && _nowToday == [dateComponents day]) {
        dayLabel.textColor  = [UIColor colorWithRed:100/255.0 green:169/255.0 blue:38/255.0 alpha:1];
        textLabel.textColor = [UIColor colorWithRed:100/255.0 green:169/255.0 blue:38/255.0 alpha:1];
    }
        

}

-(BOOL) isGrayed {
    return _isGrayed;
}

-(void) setIsGrayed: (BOOL) isGrayed {
    
    _isGrayed = isGrayed;
    [self updateTextColor];
}

-(void) setIsInteractable: (BOOL) isInteractable {
    
    _isInteractable = isInteractable;
    [self updateTextColor];
    
    if (isInteractable) {
        
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.01]];
            [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];  
            [button release];
        }
        
        if (!_isGrayed && _selectedYear == _year && _selectedMonth == _month && _selectedDay == _day) {
            [self setSelected:YES];
        }
    }
    else {
        
        if (button) {
            [button removeFromSuperview];
            button = nil;
        }
        
        [self setSelected:NO];
    }
}

-(void) setSelected: (BOOL) isSelected {

    _isSelected = isSelected;
    [self updateBackground];
}

-(void) updateBackground {

    if (_isSelected) {
        
        
       
        dayLabel.textColor = [UIColor whiteColor];
        textLabel.textColor = [UIColor whiteColor];
        
        
        dayLabel.backgroundColor = selectedColor;
        textLabel.backgroundColor = selectedColor;
    }
    else if (_weekDay == 0) {
        dayLabel.backgroundColor = sundayColor;
        textLabel.backgroundColor = sundayColor;
    }
    else if (_weekDay == 6) {
        dayLabel.backgroundColor = saturdayColor;
        textLabel.backgroundColor = saturdayColor;
    }
    else {
        dayLabel.backgroundColor = normalColor;
        textLabel.backgroundColor = normalColor;
    }
}

@end
