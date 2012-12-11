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
#import "WriteOrderViewController.h"
#import "ChooseSpaceViewController.h"
#import "TransitionString.h"
#import "SearchFlightData.h"
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
    
    NSString * navigationTitle = [NSString stringWithFormat:@"%@ -- %@",self.startPort,self.endPort];
    self.navigationItem.title = navigationTitle;
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (self.one != nil || self.write != nil) {
        self.dateArr = [NSArray array];
        self.searchFlightDateArr = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
        [self.airPort searchAirPort];
        
        self.one = nil;
        self.write = nil;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [_showCell release];
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
    [self setShowCell:nil];
    [super viewDidUnload];
}

-(void)receive:(NSNotification *)not
{
    self.dateArr = [[not userInfo] objectForKey:@"arr"];
    
    [self.dateArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SearchFlightData * s = [[SearchFlightData alloc] init] ;
        
        NSDictionary * dic = [self.dateArr objectAtIndex:idx];
        
        s.temporaryLabel = [dic objectForKey:@"code"];
        s.airPort = [dic objectForKey:@"carrier"];
        s.palntType = [TransitionString transitionPalntType:[dic objectForKey:@"plantype"]];
        s.beginTime = [TransitionString transitionTime:[dic objectForKey:@"dptTime"]];
        s.endTime = [TransitionString transitionTime:[dic objectForKey:@"arrTime"]];
        s.pay = [TransitionString transitionPay:[dic objectForKey:@"cabinYPrice"]]; // Y仓价格
        s.discount = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"lowestCabinCode"]]; // 仓位折扣
        s.ticketCount = [TransitionString transitionSeatNum:[dic objectForKey:@"lowestSeatNum"]]; // 剩余票数
        s.cabinsArr = [dic objectForKey:@"Cabins"];
        s.startPortName = self.startPort;
        s.endPortName = self.endPort;
        [self.searchFlightDateArr addObject:s];
        
        [s release];

    }];
    
    [self.showResultTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SelectResultCell *cell = (SelectResultCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SelectResultCell" owner:self options:nil];
        cell = self.showCell;
    }

    SearchFlightData * s = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    
    cell.temporaryLabel.text = s.temporaryLabel;
    cell.airPort.text = s.airPort;
    cell.palntType.text = s.palntType;
    cell.beginTime.text = s.beginTime;
    cell.endTime.text = s.endTime;
    cell.pay.text = s.pay; // Y仓价格
    cell.discount.text = s.discount; // 仓位折扣
    cell.ticketCount.text = s.ticketCount; // 剩余票数

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseSpaceViewController * order = [[ChooseSpaceViewController alloc] init];
    order.searchFlight = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:order animated:YES];
    [order release];
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
