//
//  SelectCalendarController.m
//  Calendar
//
//  Created by sss on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCalendarController.h"
#import "UIButton+BackButton.h"
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
    
    if (self.one != nil) {
        self.one = nil;
        [self dismissModalViewControllerAnimated:YES];

    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton backButtonType:4 andTitle:@"选择今天"];
    [histroyBut addTarget:self action:@selector(chooseToday) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=histroyBtn;
    [histroyBtn release];

    
    
    self.navigationItem.title = @"选择日期";
    _instance = self;
}

-(void)back{
    
    if (self.one != nil) {
        self.one = nil;
        [self dismissModalViewControllerAnimated:YES];
        
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)chooseToday{
    
    NSDate *  senddate=[NSDate date];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];

    
    [_delegate setYear:year month:month day:day];
    
    if (self.one != nil) {
        self.one = nil;
        [self dismissModalViewControllerAnimated:YES];
        
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }

    
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
