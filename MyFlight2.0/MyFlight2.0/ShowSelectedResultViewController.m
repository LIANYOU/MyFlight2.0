//
//  ShowSelectedResultViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ShowSelectedResultViewController.h"
#import "SelectResultCell.h"
#import "CustomTableView.h"
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
    self.showResultTableView.delegate = self;
    self.showResultTableView.dataSource = self;

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static BOOL nibsRegistered=NO;
    if(!nibsRegistered)
    {//第一次运行时注册nib文件，文件名不需要扩展名
        UINib *nib=[UINib nibWithNibName:@"SelectResultCell" bundle:nil];
        [self.showResultTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered=YES;
    }
    SelectResultCell *cell = [self.showResultTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  // 开始滚动的时候隐藏筛选菜单
{
    backImagelabel.hidden = YES;
    siftBtn.hidden = YES;
    sortBtn.hidden = YES;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  // 停止滚动后2秒显示筛选菜单
{
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showSift) userInfo:nil repeats:NO];
}
-(void)showSift
{
    backImagelabel.hidden = NO;
    siftBtn.hidden = NO;
    sortBtn.hidden = NO;
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

- (IBAction)siftByAirPort:(UIButton *)sender {
    CustomTableView * view = [[CustomTableView alloc] initWithButtonName:sender.titleLabel.text];
    view.frame = CGRectMake(0, 250, 320, 120);
    [self.view addSubview:view];
    [view release];
}
- (IBAction)sortByDate:(UIButton *)sender {
    CustomTableView * view = [[CustomTableView alloc] initWithButtonName:sender.titleLabel.text];
    view.frame = CGRectMake(0, 250, 320, 120);
    [self.view addSubview:view];
    [view release];
}
@end
