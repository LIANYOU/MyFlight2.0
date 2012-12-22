//
//  SelectCalendarController.h
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "ViewControllerDelegate.h"

@interface SelectCalendarController : UIViewController {

    id <ViewControllerDelegate> _delegate;
}

-(void) setDelegate: (id <ViewControllerDelegate>) delegate;

-(void) showCalendar;

+(SelectCalendarController*) instance;

-(void) selectDate;

@end
