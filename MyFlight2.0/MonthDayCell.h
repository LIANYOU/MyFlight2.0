//
//  MonthDayCell.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChineseCalendar.h"
#import "SelectCalendarController.h"

@interface MonthDayCell : UIView {
    
    int _year;
    int _month;
    int _day;
    
    UILabel* dayLabel;
    UILabel* textLabel;
    
    UIButton* button;
    
    BOOL _isSelected;
    
    BOOL _isGrayed;
    BOOL _isInteractable;

    BOOL _weekDay;

}

@property (nonatomic) int row;

-(int) year;
-(int) month;
-(int) day;

+(int) selectedYear;
+(int) selectedMonth;
+(int) selectedDay;

+(void) selectYear: (int) year month:(int) month day:(int) day;

-(void) setYear: (int) year month:(int) month day:(int) day;

-(void) setWeekDay: (int) weekDay;

-(BOOL) isGrayed;
-(void) setIsGrayed: (BOOL) isGrayed;

-(void) setIsInteractable: (BOOL) isInteractable;

-(void) setSelected: (BOOL) isSelected;

@end
