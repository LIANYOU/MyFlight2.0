//
//  ShowSelectedResultViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ShowSelectedResultViewController.h"

@interface ShowSelectedResultViewController ()

@end

@implementation ShowSelectedResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [salesText release];
    [cancelSalesText release];
    [theDayBeforeBtn release];
    [theDayAfterBtn release];
    [nowDateBtn release];
    [_showResultTableView release];
    [backImagelabel release];
    [siftBtn release];
    [sortBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [salesText release];
    salesText = nil;
    [cancelSalesText release];
    cancelSalesText = nil;
    [theDayBeforeBtn release];
    theDayBeforeBtn = nil;
    [theDayAfterBtn release];
    theDayAfterBtn = nil;
    [nowDateBtn release];
    nowDateBtn = nil;
    [self setShowResultTableView:nil];
    [backImagelabel release];
    backImagelabel = nil;
    [siftBtn release];
    siftBtn = nil;
    [sortBtn release];
    sortBtn = nil;
    [super viewDidUnload];
}
- (IBAction)enterSales:(id)sender {
    CCLog(@"进入内嵌促销网页");
}
- (IBAction)enterTheDayBefore:(id)sender {
    CCLog(@"刷新前一天");
}
- (IBAction)showCalendar:(id)sender {
    CCLog(@"显示日历");
}
- (IBAction)enterTheDayAfter:(id)sender {
    CCLog(@"刷新后一天");
}

- (IBAction)siftByAirPort:(id)sender {
    CCLog(@"筛选航空公司");
}
- (IBAction)sortByDate:(id)sender {
    CCLog(@"按照日期进行排序");
}
@end
