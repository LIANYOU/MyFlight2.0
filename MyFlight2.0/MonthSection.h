//
//  MonthSection.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekDayCell.h"
#import "Date.h"
#import "MonthDayCell.h"

@interface MonthSection : UIView {
    
    int _year;
    int _month;
    
    int _rowCount;
    
    UILabel* titleBar;
    UIView* weekDaysBar;
    UIView* container;
}

-(int) year;
-(int) month;

-(int) rowCount;

-(void) setYear:(int) year andMonth:(int) month;

-(void) disableCellBeforeDay:(int) day;

-(void) disableCellAfterDay:(int) day;

-(int) cellRowForDay: (int) day;

@end
