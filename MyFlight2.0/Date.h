//
//  Date.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Date : NSObject {

    int _year;
    int _month;
    int _day;
}

-(void) setYear:(int) year month: (int) month day: (int) day;

-(int) year;
-(int) month;
-(int) day;

+(int) getDaysOfMonth: (int) month year: (int) year;

+(BOOL) isLeapYear: (int) year;

-(void) substractDays: (int) days;

-(void) addDays: (int) days;

-(int) weekDay;

+(Date*) today;

@end
