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
    
    self.searchFlightDateArr = [NSMutableArray array];
    self.searchBackFlightDateArr = [NSMutableArray array];
    self.indexArr = [NSMutableArray array];
    
    self.indexFlag = 1000;
    
    NSString * navigationTitle = [NSString stringWithFormat:@"%@ -- %@",self.startPort,self.endPort];
    self.navigationItem.title = navigationTitle;
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (self.one != nil || self.write != nil) {
        if (self.write != nil) {
            self.flag  = 3; // 随便标记一位， 在推进到填写订单的时候使用
        }
        self.dateArr = [NSArray array];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
        [self.airPort searchAirPort];
        
        
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
    
    for (int i = 0; i<self.dateArr.count; i++) {
        SearchFlightData * s = [[SearchFlightData alloc] init] ;
        
        NSDictionary * dic = [self.dateArr objectAtIndex:i];
        
        s.temporaryLabel = [dic objectForKey:@"code"];
        s.airPort = [dic objectForKey:@"carrier"];
        s.palntType = [TransitionString transitionPalntType:[dic objectForKey:@"plantype"]];
        s.beginTime = [TransitionString transitionTime:[dic objectForKey:@"dptTime"]];
        s.endTime = [TransitionString transitionTime:[dic objectForKey:@"arrTime"]];
        s.pay = [TransitionString transitionPay:[dic objectForKey:@"cabinYPrice"]]; // Y仓价格
        s.discount = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"lowestCabinCode"]]; // 仓位折扣
        s.ticketCount = [TransitionString transitionSeatNum:[dic objectForKey:@"lowestSeatNum"]]; // 剩余票数
        s.cabinsArr = [dic objectForKey:@"Cabins"];
        s.startPortName = self.startPort;  // 机场名字 如:（北京首都）
        s.endPortName = self.endPort;
        
        if (self.write != nil) {

            [self.searchBackFlightDateArr addObject:s];
        }
        else {
            [self.searchFlightDateArr addObject:s];
        }
        
        [s release];

    }

  //  NSLog(@"==========%d",self.searchBackFlightDateArr.count);
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

    if (self.write != nil  ||  self.netFlag == 1) {
        data = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
    }
    else
    {
        data = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    }
    
    
    cell.temporaryLabel.text = data.temporaryLabel;
    cell.airPort.text = data.airPort;
    cell.palntType.text = data.palntType;
    cell.beginTime.text = data.beginTime;
    cell.endTime.text = data.endTime;
    cell.pay.text = data.pay; // Y仓价格
    cell.discount.text = data.discount; // 仓位折扣
    cell.ticketCount.text = data.ticketCount; // 剩余票数

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ChooseSpaceViewController * order = [[ChooseSpaceViewController alloc] init];
    if (self.write != nil ||  self.netFlag == 1) {
        order.searchBackFlight = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
        self.indexFlag = indexPath.row;
    } 

    if (self.indexFlag == 1000) {
        
        [self.indexArr addObject:[self.searchFlightDateArr objectAtIndex:indexPath.row]];
        order.searchFlight = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    }
    
    else
    {
        order.searchFlight = [self.indexArr lastObject];
    }
    
    order.flag = self.flag;
   
    [self.navigationController pushViewController:order animated:YES];
    
    self.write = nil;
    self.one = nil;
    
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
