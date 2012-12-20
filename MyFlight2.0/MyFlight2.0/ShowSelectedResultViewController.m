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
#import "LowOrderController.h"
#import "searchCabin.h"
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
    self.tempTwoCodeArr = [NSMutableArray array];
    
    self.indexFlag = 1000;
    
    UIButton * backBtn_ = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn_.frame = CGRectMake(10, 5, 30, 31);
    backBtn_.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn_.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn_ addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn_];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(250, 5, 60, 31);
    histroyBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [histroyBut setTitle:@"低价预约" forState:UIControlStateNormal];
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clean_histroy_4words_.png"]];
    [histroyBut addTarget:self action:@selector(lowOrder) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];
    
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"AirPortCode" ofType:@"plist"];
    
    dicCode = [[NSDictionary alloc] initWithContentsOfFile:dataPath];

   // NSLog(@"%@",dicCode.allKeys);
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.twoCodeArr = [[NSMutableArray alloc] init];
    
    if (self.write != nil) {
        navigationTitle = [NSString stringWithFormat:@"%@ -- %@",self.endPort,self.startPort];
    }
    else{
        navigationTitle = [NSString stringWithFormat:@"%@ -- %@",self.startPort,self.endPort];
        self.navigationItem.title = navigationTitle;
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 5, 30)];
    label.text = navigationTitle;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor  = [UIColor clearColor];
    self.navigationItem.titleView = label;


    if (self.one != nil || self.write != nil) {
        if (self.write != nil) {
            self.flag  = 3; // 随便标记一位， 在推进到填写订单的时候使用
        }
        self.dateArr = [NSArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
        [self.airPort searchAirPort];
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
    
        [HUD show:YES];
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
        s.beginTime = [dic objectForKey:@"dptTime"];
        s.endTime = [dic objectForKey:@"arrTime"];
        s.pay = [TransitionString transitionPay:[dic objectForKey:@"cabinYPrice"]]; // Y仓价格
        s.discount = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"lowestCabinCode"]]; // 仓位折扣
        s.ticketCount = [TransitionString transitionSeatNum:[dic objectForKey:@"lowestSeatNum"]]; // 剩余票数
        s.cabinsArr = [dic objectForKey:@"Cabins"];
        s.startPortName = self.startPort;  // 机场名字 如:（北京首都）
        s.endPortName = self.endPort;
        s.startPortThreeCode = self.startThreeCode;
        s.endPortThreeCode = self.endThreeCode;
        
        if (self.write != nil) {

            s.startPortName = self.endPort;
            s.endPortName = self.startPort;
            [self.searchBackFlightDateArr addObject:s];
        }
        else {
            [self.searchFlightDateArr addObject:s];
        }
        
        [s release];

    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.showResultTableView reloadData];
    
    
    if (self.write != nil  ||  self.netFlag == 1) {
        for (SearchFlightData * _data in self.searchBackFlightDateArr) {
            if (self.twoCodeArr.count == 0) {
                [self.twoCodeArr addObject:_data.airPort];
            }
            for (int i = 0; i<self.twoCodeArr.count; i++) {
                
                NSString * str = [self.twoCodeArr objectAtIndex:i];
                if ([_data.airPort isEqualToString:str]) {
                    break;
                }
                if (i == self.twoCodeArr.count-1) {
                    [self.twoCodeArr addObject:_data.airPort];
                }
            }

        }
        
    }
    else
    {
        for (SearchFlightData * _data in self.searchFlightDateArr) {
            if (self.twoCodeArr.count == 0) {
                [self.twoCodeArr addObject:_data.airPort];
            }
            for (int i = 0; i<self.twoCodeArr.count; i++) {
                
                NSString * str = [self.twoCodeArr objectAtIndex:i];
                if ([_data.airPort isEqualToString:str]) {
                    break;
                }
                if (i == self.twoCodeArr.count-1) {
                    [self.twoCodeArr addObject:_data.airPort];
                }
            }
            
        }

    }
    self.tempTwoCodeArr = self.twoCodeArr;
    
    [HUD removeFromSuperview];
	[HUD release];
	HUD = nil;


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
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SelectResultCell *cell = (SelectResultCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
      NSArray *array =  [[NSBundle mainBundle] loadNibNamed:@"SelectResultCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }

    if (self.write != nil  ||  self.netFlag == 1) {
        data = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
    }
    else
    {
        data = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    }
    
    
   
    
    NSString * string ;
    
    for (int i = 0; i<dicCode.allKeys.count; i++) {
        
        if ([data.airPort isEqualToString:[dicCode.allKeys objectAtIndex:i]]) {
        
            string = [dicCode objectForKey:[dicCode.allKeys objectAtIndex:i]];
            
            break;
        }
        else
        {
            string = data.airPort;
        }
    }
    
    cell.temporaryLabel.text =  data.temporaryLabel;
    cell.airPort.text = string;
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
    
    SearchFlightData * data_ = [self.searchFlightDateArr objectAtIndex:indexPath.row];
    
    if (self.write != nil ||  self.netFlag == 1) {
        order.searchBackFlight = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
        //NSLog(@"----%@",order.searchBackFlight.temporaryLabel);
        searchCabin * search = [[searchCabin alloc] initWithdpt:data.endPortThreeCode arr:data.startPortThreeCode date:@"2012-12-30" code:order.searchBackFlight.temporaryLabel edition:@"v1.0" source:@"xxxx"];
        order.searchCab = search;
        
        self.indexFlag = indexPath.row;
    }
    
    if (self.indexFlag == 1000) {
        
        [self.indexArr addObject:[self.searchFlightDateArr objectAtIndex:indexPath.row]];
        order.searchFlight = [self.searchFlightDateArr objectAtIndex:indexPath.row];
        
        //NSLog(@"%@",data_.temporaryLabel);
        searchCabin * search = [[searchCabin alloc] initWithdpt:data_.startPortThreeCode arr:data_.endPortThreeCode date:@"2012-12-30" code:data_.temporaryLabel edition:@"v1.0" source:@"xxxx"];
        order.searchCab = search;
    }
    
    else
    {
        order.searchFlight = [self.indexArr lastObject];
    }
    
    order.flag = self.flag;
    
    order.goPay = self.payMoney;
    order.goCabin = self.cabin;
    
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
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    [HUD show:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    self.airPort.date = @"2012-12-21";
    [self.airPort searchAirPort];
}
- (IBAction)showCalendar:(id)sender {
    
    CCLog(@"显示日历");
}
- (IBAction)enterTheDayAfter:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    [HUD show:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    self.airPort.date = @"2012-12-22";
    [self.airPort searchAirPort];
}

- (IBAction)siftByAirPort:(UIButton *)sender {
    if (self.one != nil || self.write != nil) {
        CustomTableView * view = [[CustomTableView alloc] initWithButtonName:sender.titleLabel.text andAirPortTwoCode:self.twoCodeArr andTable:self.showResultTableView];
        view.frame = CGRectMake(0, 250, 320, 120);
        [self.view addSubview:view];
        [view release];
    }
    else
    {
        CustomTableView * view = [[CustomTableView alloc] initWithButtonName:sender.titleLabel.text andAirPortTwoCode:self.tempTwoCodeArr andTable:self.showResultTableView];
        view.frame = CGRectMake(0, 250, 320, 120);
        [self.view addSubview:view];
        [view release];
    }
    
}
- (IBAction)sortByDate:(UIButton *)sender {
    CustomTableView * view = [[CustomTableView alloc] initWithButtonName:sender.titleLabel.text andAirPortTwoCode:self.twoCodeArr andTable:self.showResultTableView];
    view.frame = CGRectMake(0, 250, 320, 120);
    [self.view addSubview:view];
    [view release];
}

-(void)lowOrder
{
    LowOrderController * low = [[LowOrderController alloc] init];
    [self.navigationController pushViewController:low animated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
