//
//  SelectCalendarController.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCalendarController.h"

static SelectCalendarController *_instance;

@interface SelectCalendarController ()

@end

@implementation SelectCalendarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setDelegate: (id <ViewControllerDelegate>) delegate {
    _delegate = delegate;
}

-(void) showCalendar {
    
    CalendarView* calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    [calendarView setDate:[Date today]];
    [self.view addSubview:calendarView];
    [calendarView release];
}

+(SelectCalendarController*) instance {
    return _instance;
}

-(void) selectDate {
    
    [_delegate setYear:[MonthDayCell selectedYear] month:[MonthDayCell selectedMonth] day:[MonthDayCell selectedDay]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"选择日期";
    _instance = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
