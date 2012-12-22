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
#import "ShowSelectedCell.h"
@interface ShowSelectedResultViewController ()
{
    NSMutableArray * sortArr;  // 去程筛选以后的数组
    NSMutableArray * sortBackArr; // 返程筛选以后的数组
    int sortFlag;  // 是否经过去程筛选的标记位
    int sortBackFlag;  // 返程筛选标记位
    
    int airPortNameFlag;   // 按照航空公司排序标记
    int timeSortFlag;  // 按照时间排序的标记位   （返回结果默认是这样，这里只是形式而已）
}

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
        
    self.searchFlightDateArr = [NSMutableArray array];
    self.searchBackFlightDateArr = [NSMutableArray array];
    self.indexArr = [NSMutableArray array];
    self.tempTwoCodeArr = [NSMutableArray array];  // 缓存已经得到的二字码
    
    self.indexFlag = 1000;
    
    sortFlag = 0;
    sortBackFlag = 0;
    timeSortFlag = 0;
    airPortNameFlag = 0;
    
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
    
 
    self.backView.hidden = YES;
    self.sortTableView.hidden = YES;
    
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"AirPortCode" ofType:@"plist"];
    
    dicCode = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    
    
    UISwipeGestureRecognizer * swipe  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionUp;
    [self.showResultTableView addGestureRecognizer:swipe];
    [swipe release];

    

   // NSLog(@"%@",dicCode.allKeys);
    [super viewDidLoad];
    
}

-(void)swipe:(UISwipeGestureRecognizer * )swipe//轻扫
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationTransition:(swipe.direction == (UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionUp)) ? UIViewAnimationTransitionCurlUp :UIViewAnimationTransitionFlipFromRight forView: im cache:YES];
//    [UIView commitAnimations];
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"左边");
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
         NSLog(@"右边");
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.showResultTableView.delegate = self;
    self.showResultTableView.dataSource = self;
    self.sortTableView.delegate = self;
    self.sortTableView.dataSource = self;

    
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
    [_sortTableView release];
    [_backView release];
    [_selectedCell release];
    [airPortLabel release];
    [timeLabel release];
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
    [self setSortTableView:nil];
    [self setBackView:nil];
    [self setSelectedCell:nil];
    [airPortLabel release];
    airPortLabel = nil;
    [timeLabel release];
    timeLabel = nil;
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
        s.pay = [dic objectForKey:@"lowestPrice"]; // 价格
        s.discount = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"lowestCabinCode"]]; // 仓位折扣
        s.ticketCount = [TransitionString transitionSeatNum:[dic objectForKey:@"lowestSeatNum"]]; // 剩余票数
        s.cabinsArr = [dic objectForKey:@"Cabins"];
        s.adultBaf = [dic objectForKey:@"adulBaf"];
       
        s.childBaf = [dic objectForKey:@"childBaf"];
        s.constructionFee = [dic objectForKey:@"constructionFee"];
        s.childConstructionFee = [dic objectForKey:@"childConstructionFee"];
        s.standerPrice = [dic objectForKey:@"standerPrice"];
        
//        s.personPrice = [dic objectForKey:@"lowestPrice"];
//        s.childPrice = [dic objectForKey:@"lowestChildTicket"];
        
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
    if (tableView == self.sortTableView) {

        if ( timeSortFlag == 3) {
            self.sortTableView.frame = CGRectMake(0, 282, 320, 86);
            return 2;
        }

        else{
            self.sortTableView.frame = CGRectMake(0, 187, 320, 181);
            return self.tempTwoCodeArr.count + 1;  // 第一行是不限航空公司
        }
    }
    else{
        if (airPortNameFlag == 4) {
            return sortArr.count;
        }
        if ( timeSortFlag == 3) {
            return 2;
        }
        else{
            return self.dateArr.count;
        }
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sortTableView) {
        return 44;
    }
    else
    {
    return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.showResultTableView) {
        static NSString *CellIdentifier = @"Cell";
        SelectResultCell *cell = (SelectResultCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            NSArray *array =  [[NSBundle mainBundle] loadNibNamed:@"SelectResultCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        if (self.write != nil  ||  self.netFlag == 1) {
            if (sortBackFlag == 2) {
                data = [sortBackArr objectAtIndex:indexPath.row];
            }
            else
            {
                data = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
            }
        }
        else
        {
            if (sortFlag == 1) {
                data = [sortArr objectAtIndex:indexPath.row];

            }
            else{
                data = [self.searchFlightDateArr objectAtIndex:indexPath.row];
            }
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
    else
    {
        static NSString *CellIdentifier = @"Cell";
        ShowSelectedCell *cell = (ShowSelectedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"ShowSelectedCell" owner:self options:nil];
            cell = self.selectedCell;
        }
        if (timeSortFlag == 3)
        {
            if (indexPath.row == 0)
            {
                cell.airportName.text = @"时间从早到晚";
            }
            else
            {
                cell.airportName.text = @"价格从低到高";
            }
        }
        if (airPortNameFlag == 4) {
            
            if (indexPath.row == 0) {
                cell.airportName.text = @"不限航空公司";
            }
            else{
                cell.airportName.text = [self.tempTwoCodeArr objectAtIndex:indexPath.row-1];
            }
        }
        
        [cell.selectBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];

      return cell;
   }
}

-(void)changeImage:(UIButton *)send
{
    send.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.showResultTableView)
    {
        ChooseSpaceViewController * order = [[ChooseSpaceViewController alloc] init];
        
        SearchFlightData * data_;
        if (sortFlag == 1) {
            data_ = [sortArr objectAtIndex:indexPath.row];
        }
        else{
            data_ = [self.searchFlightDateArr objectAtIndex:indexPath.row];
        }
        
        if (self.write != nil ||  self.netFlag == 1) {
            
            if (sortBackFlag == 2) {
                order.searchBackFlight = [sortBackArr objectAtIndex:indexPath.row];
            }
            else{
                order.searchBackFlight = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
            }
            
            //NSLog(@"----%@",order.searchBackFlight.temporaryLabel);
            searchCabin * search = [[searchCabin alloc] initWithdpt:data.endPortThreeCode arr:data.startPortThreeCode date:@"2012-12-30" code:order.searchBackFlight.temporaryLabel edition:@"v1.0" source:@"xxxx"];
            order.searchCab = search;
            
            self.indexFlag = indexPath.row;  // 标记一下。
        }
        
        if (self.indexFlag == 1000) {
            
            if (sortFlag == 1) {
                [self.indexArr addObject:[sortArr objectAtIndex:indexPath.row]]; // indexArr是为了保存用户所有来回选取的记录， 最终去的最后一条
                order.searchFlight = [sortArr objectAtIndex:indexPath.row];
            }
            else{
                [self.indexArr addObject:[self.searchFlightDateArr objectAtIndex:indexPath.row]]; // indexArr是为了保存用户所有来回选取的记录， 最终去的最后一条
                order.searchFlight = [self.searchFlightDateArr objectAtIndex:indexPath.row];
            }

            NSLog(@"%@,%@,%@",data_.temporaryLabel,data_.startPortThreeCode,data_.endPortThreeCode);
            searchCabin * search = [[searchCabin alloc] initWithdpt:data_.startPortThreeCode arr:data_.endPortThreeCode date:@"2012-12-30" code:data_.temporaryLabel edition:@"v1.0" source:@"xxxx"];
            order.searchCab = search;
        }
        
        else
        {
            order.searchFlight = [self.indexArr lastObject];  // 用户来回查看不同的航班信息的时候，保存最后一条
        }
        
        order.flag = self.flag;
        
        order.goPay = self.payMoney;    // 此处上一个页面记录的传递的是成人的去程价格
        order.goCabin = self.cabin;
        order.childGoPay = self.childPayMoney;
        
        [self.navigationController pushViewController:order animated:YES];
        
        self.write = nil;
        self.one = nil;
        
        [order release];

    }
    else{
        if (timeSortFlag == 3) {
            
            if (sortFlag == 1) {
                if (indexPath.row == 0) {
                    
                    SearchFlightData * data1;
                    SearchFlightData * data2;
                    SearchFlightData * tempData;
                    
                    int k = 0;
                    
                    for (int i = 0; i<sortArr.count-1; i++)
                    {
                        
                        k = i;
                        
                        for (int j = i+1; j<sortArr.count; j++) {
                            data2 = [sortArr objectAtIndex:j];
                            data1 = [sortArr objectAtIndex:i];
                            
                            NSString * string = data2.beginTime;
                            NSArray * timeArr = [string componentsSeparatedByString:@":"];
                            NSString * str = [NSString stringWithFormat:@"%@%@",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1]];
                            int time2 = [str intValue];
                            
                            NSString * string1 = data1.beginTime;
                            NSArray * timeArr1 = [string1 componentsSeparatedByString:@":"];
                            NSString * str1 = [NSString stringWithFormat:@"%@%@",[timeArr1 objectAtIndex:0],[timeArr objectAtIndex:1]];
                            int time1 = [str1 intValue];
                            
                            if (time1 < time2) {
                                k = j;
                            }
                            
                            tempData = data1;
                            data1 = data2;
                            data2 = tempData;
                        }
                    }
                    
                    //                for (SearchFlightData * da in sortArr) {
                    //                    NSLog(@"%@",da.beginTime);
                    //                 }
                }
                if (indexPath.row == 1)
                {
                    SearchFlightData * data1 = nil;
                    SearchFlightData * data2 = nil;
                    SearchFlightData *tmpData1 = nil;
                    SearchFlightData * tempData = nil;
                    
                    int k = 0;
                    
                    for (int i = 0; i<sortArr.count-1; i++)
                    {
                        
                         k = i;
                        
                        
                        //待交换
                         tmpData1 = [sortArr objectAtIndex:i];
                       
                        
                        
                        for (int j = i+1; j<sortArr.count; j++) {
                            
                            data2 = [sortArr objectAtIndex:j];
                            //待比较
                            data1 = [sortArr objectAtIndex:k];
                            
                            NSString * string = data2.pay;
                            
                            int time2 = [string intValue];
                            
                            NSString * string1 = data1.pay;
                             NSLog(@"time1 = %@",string1);
                            NSLog(@"time2 = %@",string);
                            int time1 = [string1 intValue];
                            
                            if (time1 > time2) {
                                k = j;
                                
                                
                                NSLog(@"*********k= %d************",k);
                            }
                            
                            
                        }
                        
                        SearchFlightData * tempK = [sortArr objectAtIndex:k];
                        
                        NSLog(@"=======比较完成%@与,%@ 所在下标 %d交换顺序 &&&&&&&&&&&&&&&",tmpData1.pay,tempK.pay,k);
                                                
                        tempData = tmpData1;
                        tmpData1 = tempK;
                        tempK = tempData;
                        
                        
                    }
                    
                    for (SearchFlightData * da in sortArr) {
                        NSLog(@"%@",da.pay);
                    }
                }
            
            
            
                self.backView.hidden = YES;
                self.sortTableView.hidden = YES;
                return;
            }
        }
        else
        {
            ShowSelectedCell *cell = (ShowSelectedCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
            
            if (self.indexFlag == 1000) {  // 去程筛选
                sortFlag = 1;
                if (indexPath.row == 0) {   // 如果点击的是第一行，就是不限航空公司
                    
                    sortArr = self.searchFlightDateArr;
                }
                else
                {
                    NSString * string = cell.airportName.text;
                    
                    for (SearchFlightData * searchData in self.searchFlightDateArr) {
                        if ([searchData.airPort isEqualToString:string]) {
                            [sortArr addObject:searchData];
                        }
                    }
                    
                }
                
            }
            
            if (self.write != nil ||  self.netFlag == 1) {  // 返程筛选
                sortBackFlag = 2;
                if (indexPath.row == 0) {
                    sortBackArr = self.searchBackFlightDateArr;
                }
                else{
                    NSString * string = cell.airportName.text;
                    
                    for (SearchFlightData * searchData in self.searchBackFlightDateArr) {
                        if ([searchData.airPort isEqualToString:string]) {
                            [sortBackArr addObject:searchData];
                        }
                    }
                }
            }
            [self.showResultTableView reloadData];
            self.backView.hidden = YES;
            self.sortTableView.hidden = YES;
        }
    }
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  // 开始滚动的时候隐藏筛选菜单
{
    if (!self.sortTableView.hidden) {
        return;
    }
    
    backImagelabel.hidden = YES;
    siftBtn.hidden = YES;
    sortBtn.hidden = YES;
    airPortLabel.hidden = YES;
    timeLabel.hidden = YES;
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
    airPortLabel.hidden = NO;
    timeLabel.hidden = NO;
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
    
    airPortNameFlag = 4;
    timeSortFlag = 0;
    sortArr = [[NSMutableArray alloc] init];
    sortBackArr = [[NSMutableArray alloc] init];
    self.backView.hidden = NO;
    self.sortTableView.hidden = NO;
    
    [self.sortTableView reloadData];
    
}
- (IBAction)sortByDate:(UIButton *)sender {

    airPortNameFlag = 0;
    timeSortFlag = 3;
    self.backView.hidden = NO;
    self.sortTableView.hidden = NO;
    
    [self.sortTableView reloadData];
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
