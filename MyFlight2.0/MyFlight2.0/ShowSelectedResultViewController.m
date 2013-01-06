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

#import "AppConfigure.h"
#import "MonthDayCell.h"
#import "SelectCalendarController.h"
#import "UIButton+BackButton.h"
@interface ShowSelectedResultViewController ()
{
    int beforeFlag;
    int CalendarFlag;  // 判断是不是从日历里边返回
 
    int sortViewFlag;  // 标记上次排序的是选择的哪一个
    
    int sortFlag;  // 是否经过去程筛选的标记位
    int sortBackFlag;  // 返程筛选标记位
    
    int sortTimeFlag;
    int sortBackTimeFlag;
        
    int airPortNameFlag;   // 按照航空公司排序标记
    int timeSortFlag;  // 按照时间排序的标记位
    
    
    int lowOrderFlag;  // 判断是不是进入了低价预约，， 回来的时候不用联网
    
    NSString * deviceTime; // 获取当前时间
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
    
    self.indexFlag = 1000;
    
    sortViewFlag = 100;
    
    airPortNameFlag = 0;   // 按照航空公司排序标记
    timeSortFlag = 0;
    
    self.searchFlightDateArr = [[NSMutableArray alloc] initWithCapacity:5];
    self.searchBackFlightDateArr = [[NSMutableArray alloc] initWithCapacity:5];
    self.indexArr = [[NSMutableArray alloc] initWithCapacity:5];
    self.tempTwoCodeArr = [[NSMutableArray alloc] initWithCapacity:5];  // 缓存已经得到的二字码
    
    sortFlag = 0;

    
    UIButton * backBtn_ = [UIButton backButtonType:0 andTitle:@""];
    [backBtn_ addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn_];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    UIButton * histroyBut = [UIButton backButtonType:4 andTitle:@"低价预约"];
    [histroyBut addTarget:self action:@selector(lowOrder) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];
    
 
    self.backView.hidden = YES;
    self.sortTableView.hidden = YES;
    
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"AirPortCode" ofType:@"plist"];
    
    dicCode = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeGrayView:)];
    [self.grayView addGestureRecognizer:tap];
    [tap release];
    
    
    
    UISwipeGestureRecognizer * swipe  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;

    [self.showResultTableView addGestureRecognizer:swipe];
    [swipe release];
    
    UISwipeGestureRecognizer * swipe1  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipe1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.showResultTableView addGestureRecognizer:swipe1];
    [swipe1 release];

    self.showResultTableView.separatorColor = [UIColor clearColor];
    
    
    
    self.sortArr = [[NSMutableArray alloc] init];
    self.sortBackArr = [[NSMutableArray alloc] init];

    [super viewDidLoad];
    
}

-(void)removeGrayView:(UITapGestureRecognizer *)tap
{
    self.backView.hidden = YES;
    self.sortTableView.hidden = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
-(void)swipeGesture:(UISwipeGestureRecognizer * )swipe//轻扫
{

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        
        [UIView animateWithDuration:0.001 animations:^(void)  //不用回调
         {
             self.showResultTableView.frame = CGRectMake(320, 44, 320, 480);
           //  self.navigationController.view.frame = CGRectMake(160, 0, 320, 480);

         }  completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 self.showResultTableView.frame = CGRectMake(0, 44, 320, 480);
             } completion:^(BOOL finished) {
                 self.airPort.date = @"2012-01-10";
                 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
                 [self.airPort searchAirPort];
                           
             }];
         }];
      //  NSLog(@"左边");
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
    
  
    
    if (self.write != nil || self.netFlag == 1) {
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
    

    if (lowOrderFlag != 10 && CalendarFlag != 1) {
        if (self.one != nil || self.write != nil) {
            
            if (self.write != nil) {
                
                self.airPort.date = self.goBackDate;
                
                NSArray * array = [self.airPort.date componentsSeparatedByString:@"-"];
                
                [nowDateBtn setTitle:[NSString stringWithFormat:@"%@-%@",[array objectAtIndex:1],[array objectAtIndex:2]] forState:0];
                
                self.flag  = 3; // 随便标记一位， 在推进到填写订单的时候使用
            }
            if (self.one != nil) {
                
                self.airPort.date = self.startDate;    // 不同的时候设置不同的搜索时间
                
                NSArray * array = [self.airPort.date componentsSeparatedByString:@"-"];
                
                [nowDateBtn setTitle:[NSString stringWithFormat:@"%@-%@",[array objectAtIndex:1],[array objectAtIndex:2]] forState:0];
                
            }
            
            self.dateArr = [NSArray array];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
            [self.airPort searchAirPort];
            
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            [HUD show:YES];
        }
    }
    
    
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
    NSString * strMonth=nil;
    NSString * strDay=nil;
    if (month<10) {
        strMonth = [[NSString alloc] initWithFormat:@"0%d",month];
        
    }
    else{
        strMonth = [NSString stringWithFormat:@"%d",month];
    }
    if (day<10) {
        strDay = [NSString stringWithFormat:@"0%d",day];
    }
    else{
        strDay = [NSString stringWithFormat:@"%d",day];
    }
    
    deviceTime = [[NSString alloc] initWithFormat:@"%4d%@%@",year,strMonth,strDay];
    
    [dateformatter release];

    NSArray * timeArr = [self.airPort.date componentsSeparatedByString:@"-"];
    NSString * timeStr = [NSString stringWithFormat:@"%@%@%@",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1],[timeArr objectAtIndex:2]];
    
    NSLog(@"系统时间和查询时候的时间 %d,,%d",[deviceTime intValue],[timeStr intValue]);
    if ([deviceTime intValue] == [timeStr intValue]) {

        theDayBeforeBtn.enabled = NO;
        
    }
    else{
        theDayBeforeBtn.enabled = YES;
    }
    
    
    
    NSLog(@"返程数据 %d",self.searchBackFlightDateArr.count);
    
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
    [_grayView release];
    [backImageView release];
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
    [self setGrayView:nil];
    [backImageView release];
    backImageView = nil;
    [super viewDidUnload];
}

-(void)receive:(NSNotification *)not
{
    
    timeSortFlag = 0 ;
    airPortNameFlag = 0;
    sortFlag =0;
    sortTimeFlag = 0;
    
    self.dateArr = [[not userInfo] objectForKey:@"arr"];
    
    if (self.write != nil || self.netFlag == 1) {
       
        [self.searchBackFlightDateArr removeAllObjects];
    }
    else{
        [self.searchFlightDateArr removeAllObjects];
    }
    
    for (int i = 0; i<self.dateArr.count; i++) {
        
        SearchFlightData * s = [[SearchFlightData alloc] init] ;
        
        NSDictionary * dic = [self.dateArr objectAtIndex:i];
        
        s.temporaryLabel = [dic objectForKey:@"code"];
        s.airPort = [dic objectForKey:@"carrier"];
        s.palntType = [dic objectForKey:@"plantype"];
        s.beginTime = [dic objectForKey:@"dptTime"];
        s.endTime = [dic objectForKey:@"arrTime"];
        s.pay = [[dic objectForKey:@"lowestPrice"] intValue]; // 价格
        s.discount = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"lowestCabinCode"]]; // 仓位折扣
        s.ticketCount = [TransitionString transitionSeatNum:[dic objectForKey:@"lowestSeatNum"]]; // 剩余票数
        s.cabinsArr = [dic objectForKey:@"Cabins"];
        s.adultBaf = [dic objectForKey:@"adulBaf"];
       
        s.childBaf = [dic objectForKey:@"childBaf"];
        s.constructionFee = [dic objectForKey:@"constructionFee"];
        s.childConstructionFee = [dic objectForKey:@"childConstructionFee"];
        s.standerPrice = [dic objectForKey:@"standerPrice"];
        
        s.personPrice = [dic objectForKey:@"lowestPrice"];
        s.childPrice = [dic objectForKey:@"lowestChildTicket"];
        
        s.startPortName = self.startPort;  // 机场名字 如:（北京首都）
        s.endPortName = self.endPort;
        s.startPortThreeCode = self.startThreeCode;
        s.endPortThreeCode = self.endThreeCode;
        
        s.beginDate = self.startDate;
        
        if (self.write != nil || self.netFlag == 1) {
            
            s.goOrBackFlag = @"2";
            s.backDate = self.goBackDate;
            s.startPortName = self.endPort;
            s.endPortName = self.startPort;
            s.beginDate = self.goBackDate;
            s.startPortThreeCode = self.endThreeCode;
            s.endPortThreeCode = self.startThreeCode;
            
            
            [self.searchBackFlightDateArr addObject:s];
        }
        else {
            s.goOrBackFlag = @"1";
            
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
        
        if (self.write != nil  || CalendarFlag == 1 ) {

            return self.dateArr.count;
        }
       
        
        if (timeSortFlag == 3 || airPortNameFlag == 4 ) {   // 判断如果是经过排序
         
            if (self.sortBackArr.count != 0) {
            
                return self.sortBackArr.count;
            }
            else{
 
                return self.sortArr.count;
            }
            
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
            
//            if (CalendarFlag == 1) {
//                data = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
//            }
            
            if (sortBackFlag == 2 || sortBackTimeFlag == 2) {
            
                data = [self.sortBackArr objectAtIndex:indexPath.row];  // 经过排序处理
            }
            else
            {
                data = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
            }
        }

        else
        {
            
//            if (CalendarFlag == 1) {
//                data = [self.searchFlightDateArr objectAtIndex:indexPath.row];
//            
//            }
            
            if (sortFlag == 1 || sortTimeFlag == 1) {
            
                data = [self.sortArr objectAtIndex:indexPath.row];
            
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
        cell.palntType.text = [NSString stringWithFormat:@"%@机型",data.palntType];
        cell.beginTime.text = data.beginTime;
        cell.endTime.text = data.endTime;
        cell.pay.text =[NSString stringWithFormat:@"%d",data.pay] ; // Y仓价格
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
        cell.airportName.textColor = [UIColor whiteColor];
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

        
        if (indexPath.row == sortViewFlag) {
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_default1_click.png"] forState:0];
        }
        else{
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"icon_Default1.png"] forState:0];
        }
        
        cell.selectionStyle = 2;
        
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
    
    [self.showResultTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CalendarFlag = 0;
    lowOrderFlag = 0;
    if (tableView == self.showResultTableView)
    {
        ChooseSpaceViewController * order = [[ChooseSpaceViewController alloc] init];
        
        order.goBackDate = self.goBackDate;
        
        SearchFlightData * data_ = nil;
        
        if (self.write != nil ||  self.netFlag == 1) {    // 返程的时候走的方法
           
            if (sortBackFlag == 2 || sortBackTimeFlag == 2) {  // 经过返程筛选
              
                data_ = [self.sortBackArr objectAtIndex:indexPath.row];
                
                order.searchBackFlight = [self.sortBackArr objectAtIndex:indexPath.row];
                
            }
            else{
                
                order.searchBackFlight = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
                
                data_ = [self.searchBackFlightDateArr objectAtIndex:indexPath.row];
            }
            
            searchCabin * search = [[searchCabin alloc] initWithdpt:data_.startPortThreeCode arr:data_.endPortThreeCode date:self.goBackDate code:order.searchBackFlight.temporaryLabel edition:@"v1.0" source:@"xxxx"];
            order.searchCab = search;
            
            self.indexFlag = indexPath.row;  // 标记一下。
        }
        
        if (self.indexFlag == 1000) {   //  标记单程走这个方法
            
            if (sortFlag == 1 || sortTimeFlag == 1) {
                [self.indexArr addObject:[self.sortArr objectAtIndex:indexPath.row]]; // indexArr是为了保存用户所有来回选取的记录， 最终去的最后一条
                order.searchFlight = [self.sortArr objectAtIndex:indexPath.row];
                data_ = [self.sortArr objectAtIndex:indexPath.row];
            }
            else{
                [self.indexArr addObject:[self.searchFlightDateArr objectAtIndex:indexPath.row]]; // indexArr是为了保存用户所有来回选取的记录， 最终去的最后一条
                order.searchFlight = [self.searchFlightDateArr objectAtIndex:indexPath.row];
                data_ = [self.searchFlightDateArr objectAtIndex:indexPath.row];
            }
            
            searchCabin * search = [[searchCabin alloc] initWithdpt:data_.startPortThreeCode arr:data_.endPortThreeCode date:self.startDate code:data_.temporaryLabel edition:@"v1.0" source:@"xxxx"];
            order.searchCab = search;
        }
        
        else
        {
            order.searchFlight = [self.indexArr lastObject];  // 用户来回查看不同的航班信息的时候，保存最后一条
        }
        
        order.flag = self.flag;
        [order setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [self.navigationController pushViewController:order animated:YES];
        
        self.write = nil;
        self.one = nil;
        
        [order release];
        
    }
    else{

        ShowSelectedCell *cell = (ShowSelectedCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selectBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];

        if (timeSortFlag == 3) {
            
            sortViewFlag = indexPath.row;
            
            if (self.write != nil ||  self.netFlag == 1) {  // 返程排序
                
                sortBackFlag = indexPath.row;
                
                    if (self.sortBackArr.count == 0) {
                        self.sortBackArr = self.searchBackFlightDateArr;
                    }
 

                
                sortBackTimeFlag = 2;
                
                if (indexPath.row == 0) {   // 按照时间从早到晚排序
                    
                    NSSortDescriptor * sortDescriptor;
                    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"beginTime" ascending:YES] autorelease];
                    NSArray * sortByPayArr = [NSArray arrayWithObject:sortDescriptor ] ;
                    
                    NSMutableArray * atttt = [NSMutableArray arrayWithArray:[self.sortBackArr sortedArrayUsingDescriptors:sortByPayArr]] ;
                    
                    self.sortBackArr =  atttt ;

                   
                }
                if (indexPath.row == 1)  // 按照价格从高到底排序
                {
                    
                    NSSortDescriptor * sortDescriptor;
                    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"pay" ascending:YES] autorelease];
                    NSArray * sortByPayArr = [NSArray arrayWithObject:sortDescriptor ] ;
                    
                    NSMutableArray * atttt = [NSMutableArray arrayWithArray:[self.sortBackArr sortedArrayUsingDescriptors:sortByPayArr]] ;
                    
                    self.sortBackArr =  atttt ;

                }
                [self.showResultTableView reloadData];
                self.backView.hidden = YES;
                self.sortTableView.hidden = YES;
                return;
                
            }
            
            if (self.indexFlag == 1000) {  // 去程排序
                
                sortTimeFlag = 1;
                                
                if (self.sortArr.count == 0) {
                    self.sortArr = self.searchFlightDateArr;
                }
                
                if (indexPath.row == 0) {   // 按照时间从早到晚排序
                    
                    NSSortDescriptor * sortDescriptor;
                    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"beginTime" ascending:YES] autorelease];
                    NSArray * sortByPayArr = [NSArray arrayWithObject:sortDescriptor ] ;
                    
                    NSMutableArray * atttt = [NSMutableArray arrayWithArray:[self.sortArr sortedArrayUsingDescriptors:sortByPayArr]] ;
                    
                    self.sortArr =  atttt ;
                
                   
                    
                }
                if (indexPath.row == 1)  // 按照价格从高到底排序
                {
                    NSSortDescriptor * sortDescriptor;
                    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"pay" ascending:YES] autorelease];
                    NSArray * sortByPayArr = [NSArray arrayWithObject:sortDescriptor ] ;
                    
                    NSMutableArray * atttt = [NSMutableArray arrayWithArray:[self.sortArr sortedArrayUsingDescriptors:sortByPayArr]] ;
                    
                  
                    self.sortArr = atttt;
                 
                    
                }
                [self.showResultTableView reloadData];
                self.backView.hidden = YES;
                self.sortTableView.hidden = YES;
                return;
            }
            
            
        }
        else    // 筛选部分
        {
            
            ShowSelectedCell *cell = (ShowSelectedCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_Selected_.png"]];
            
            sortViewFlag = indexPath.row;
            
            if (self.indexFlag == 1000) {  // 去程筛选
                
                sortFlag = 1;
                                
                if (indexPath.row == 0) {   // 如果点击的是第一行，就是不限航空公司

                    [self.sortArr removeAllObjects];
                    for (SearchFlightData * da in self.searchFlightDateArr) {
                        [self.sortArr addObject:da];
                    }                   
                }
                else
                {
                   
                    NSString * string = cell.airportName.text;                   
                    
                    [self.sortArr removeAllObjects];                  
                    
                    for (SearchFlightData * searchData in self.searchFlightDateArr) {
                        
                        if ([searchData.airPort isEqualToString:string]) {
                            [self.sortArr addObject:searchData];
                        }
                    }
//                    for (SearchFlightData * sea in self.sortArr) {
//                        NSLog(@"%@",sea.temporaryLabel);
//                    }
                    
                }
                [self.showResultTableView reloadData];
                self.backView.hidden = YES;
                self.sortTableView.hidden = YES;
                
            }
            
            if (self.write != nil ||  self.netFlag == 1) {  // 返程筛选
                self.write = nil;
                
                sortBackFlag = 2;
                
                if (indexPath.row == 0) {
                    
                    [self.sortBackArr removeAllObjects];
                    for (SearchFlightData * da in self.searchBackFlightDateArr) {
                        [self.sortBackArr addObject:da];
                    }
                    
                   
                }
                else{
                    
                    NSString * string = cell.airportName.text;
                    
                    [self.sortBackArr removeAllObjects];
                    
                    for (SearchFlightData * searchData in self.searchBackFlightDateArr) {
                        if ([searchData.airPort isEqualToString:string]) {
                            
                            [self.sortBackArr addObject:searchData];
                        }
                    }
                }
                [self.showResultTableView reloadData];
                self.backView.hidden = YES;
                self.sortTableView.hidden = YES;
                
            }
        }
    }
    
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  // 开始滚动的时候隐藏筛选菜单
{
    if (!self.sortTableView.hidden) {
        return;
    }
    
    backImageView.hidden = YES;
    backImagelabel.hidden = YES;
    siftBtn.hidden = YES;
    sortBtn.hidden = YES;
    airPortLabel.hidden = YES;
    timeLabel.hidden = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  // 停止滚动后2秒显示筛选菜单
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showSift) userInfo:nil repeats:NO];
}
-(void)showSift
{
    backImageView.hidden = NO;
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
    timeSortFlag = 0;
    airPortNameFlag = 0;
    beforeFlag = 1;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    [HUD show:YES];
    

    NSString * month = nil;
    NSString * year = nil;
    NSString * day = nil;
    
    int month_ = 0;
    int year_ = 0;
    int day_ = 0;
    
    NSString * tempDate = nil;
    
    if (self.write != nil || self.netFlag == 1) {

        tempDate = self.goBackDate;
        
    }
    else{
   
        tempDate = self.startDate;
       
    }
    
    NSArray * timeArr = [tempDate componentsSeparatedByString:@"-"];
    
    year = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:0]];
    month = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:1]];
    day = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:2]];
    
    month_ = [month intValue];
    year_ = [year intValue];
    day_ = [day intValue];
    
    
    if (day_ == 1) {
        switch ([[timeArr objectAtIndex:1] intValue]) {
            case 12:
                tempDate = [NSString stringWithFormat:@"%@-%d-%d",[timeArr objectAtIndex:0],11,30];
                break;
            case 11:
                tempDate = [NSString stringWithFormat:@"%@-%d-%d",[timeArr objectAtIndex:0],10,31];
                break;
            case 10:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],9,30];
                break;
            case 9:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],8,31];
                break;
            case 8:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],7,31];
                break;
            case 7:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],6,30];
                break;
            case 6:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],5,31];
                break;
            case 5:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],4,30];
                break;
            case 4:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],3,31];
                break;
            case 3:
                if((year_%4==0&&year_%100!=0)||(year_%400==0))
                {
                    tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],2,29];
                }
                else{
                    tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],2,28];
                }
                
                break;
            case 2:
                tempDate = [NSString stringWithFormat:@"%@-0%d-%d",[timeArr objectAtIndex:0],1,31];
                break;
            case 1:
                tempDate = [NSString stringWithFormat:@"%d-%d-%d",[[timeArr objectAtIndex:0] intValue]-1,12,31];
                break;

                
            default:
                break;
        }
        
        [nowDateBtn setTitle:tempDate forState:0];
        
        NSLog(@"判断月份减一    %@",self.startDate);
    }

    else{
        NSString * m = nil;
        NSString * d = nil;
        if (month_ <10) {

            m = [NSString stringWithFormat:@"0%d",month_];
        }
        else{
            m = [NSString stringWithFormat:@"%d",month_];
        }
        if (day_ <= 10) {
            
            d = [NSString stringWithFormat:@"0%d",day_-1];
        }
        else{
            d = [NSString stringWithFormat:@"%d",day_-1];
        }
        
        tempDate = [NSString stringWithFormat:@"%d-%@-%@",year_,m,d];  // 修改出发日期的数值
       
        [nowDateBtn setTitle:[NSString stringWithFormat:@"%@-%@",m, d] forState:0];

    }
    
   // self.startDate = tempDate;
    
    
    NSString * timeStr;
    NSArray * arr = [tempDate componentsSeparatedByString:@"-"];
   

    timeStr = [NSString stringWithFormat:@"%@%@%@",[arr objectAtIndex:0],[arr objectAtIndex:1],[arr objectAtIndex:2]];


        
    if ([deviceTime intValue] >= [timeStr intValue]) {
        theDayBeforeBtn.enabled = NO;
    }
    
    if (self.write != nil || self.netFlag == 1) {
        self.goBackDate = tempDate;
        
    }
    else{
        self.startDate = tempDate;
        
    }

    
    self.airPort.date = tempDate  ;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];

    NSLog(@"查询时候用的时间 :  %@",self.startDate);



    [self.airPort searchAirPort];
}

-(void) setYear: (int) year month: (int) month day: (int) day {
    
    NSLog(@"******************************************");
    
    [leaveDate setYear:year month:month day:day];
    NSString * strMonth;
    NSString * strDay;
    if (month<10) {
        strMonth = [NSString stringWithFormat:@"0%d",month];
    }
    else{
        strMonth = [NSString stringWithFormat:@"%d",month];
    }
    if (day<10) {
        strDay = [NSString stringWithFormat:@"0%d",day];
    }
    else{
        strDay = [NSString stringWithFormat:@"%d",day];
    }
    
    if (self.write != nil) {
        
        self.goBackDate = [NSString stringWithFormat:@"%d-%@-%@",year,strMonth,strDay];
        self.airPort.date = self.goBackDate;
    }
    else{
        self.startDate = [NSString stringWithFormat:@"%d-%@-%@",year,strMonth,strDay];
        self.airPort.date = self.startDate;
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    [self.airPort searchAirPort];
    
    NSLog(@"showCalendar  %d,%d,%d",year,month,day);
}


- (IBAction)showCalendar:(id)sender {
    
    CalendarFlag = 1;
    
    sortFlag =0;
    sortTimeFlag = 0;
    sortBackFlag = 0;
    sortBackTimeFlag = 0;
    
    [MonthDayCell selectYear:leaveDate.year month:leaveDate.month day:leaveDate.day];
    
    SelectCalendarController *logVC=[[[SelectCalendarController alloc]init] autorelease];
    [logVC setDelegate:self];
    [logVC showCalendar];
    logVC.one = self;
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:logVC];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar1.png"]forBarMetrics:UIBarMetricsDefault];
  
    [self presentModalViewController:navigation animated:YES];
    
    
    
}
- (IBAction)enterTheDayAfter:(id)sender {
    
    theDayBeforeBtn.enabled = YES;  // 打开用户交互
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    [HUD show:YES];

    
    NSString * tempDate = nil;
    
    if (self.write != nil || self.netFlag == 1) {
        
        tempDate = self.goBackDate;
        
    }
    else{
        tempDate = self.startDate;
        
    }
    
    NSArray * timeArr = [tempDate componentsSeparatedByString:@"-"];
    
    NSString * month = nil;
    NSString * year = nil;
    NSString * day = nil;
    
    int month_ = 0;
    int year_ = 0;
    int day_ = 0;
    
    year = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:0]];
    month = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:1]];
    day = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:2]];
    
    month_ = [month intValue];
    year_ = [year intValue];
    day_ = [day intValue];

    
    if (month_ == 01 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d%d%d",year_,2,1];
    }
    if ((month_ == 02 && day_ == 28) || (month_ == 02 && day_ == 29)) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,3,1];
    }
    if (month_ == 03 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,4,1];
    }
    if (month_ == 04 && day_ == 30 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,5,1];
    }
    if (month_ == 05 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,6,1];
    }
    if (month_ == 06 && day_ == 30 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,7,1];
    }
    if (month_ == 07 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,8,1];
    }
    if (month_ == 8 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,9,1];
    }
    if (month_ == 9 && day_ == 30 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,10,1];
    }
    if (month_ == 10 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,11,1];
    }
    if (month_ == 11 && day_ == 30 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_,12,1];
    }
    if (month_ == 12 && day_ == 31 ) {
        tempDate = [NSString stringWithFormat:@"%d-%d-%d",year_+1,1,1];
    }
    
    else{
        
        tempDate = [NSString stringWithFormat:@"%@-%@-%d",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1],[[timeArr objectAtIndex:2]intValue]+1];
    }
    
    NSArray * dataArr = [tempDate componentsSeparatedByString:@"-"];
    
    NSString * m = nil;
    NSString * d = nil;
    
    m = [dataArr objectAtIndex:1];
    d = [dataArr objectAtIndex:2];

    if ([[dataArr objectAtIndex:2] intValue]<10) {
        d = [NSString stringWithFormat:@"0%@",[dataArr objectAtIndex:2]];
    }
    
    
    [nowDateBtn setTitle:[NSString stringWithFormat:@"%@-%@",m,d]forState:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    self.airPort.date = tempDate;
 
    NSLog(@"返程时间  %@",tempDate);
 
    [self.airPort searchAirPort];
    
    if (self.write != nil || self.netFlag == 1) {
        
        self.goBackDate = tempDate;
        
    }
    else{
        self.startDate = tempDate;
        
    }

}

- (IBAction)siftByAirPort:(UIButton *)sender {

    airPortNameFlag = 4;
    timeSortFlag = 0;

    
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
    lowOrderFlag = 10;
    LowOrderController * low = [[LowOrderController alloc] init];
    low.show = self;
    if (self.write != nil || self.netFlag == 1) {
        low.start = self.endPort;
        low.end = self.startPort;
        low.startCode = self.endThreeCode;
        low.endCode = self.startThreeCode;
        
    }
    else{
        
        low.start = self.startPort;
        low.end = self.endPort;
        
        low.startCode = self.startThreeCode;
        low.endCode = self.endThreeCode;
    }

    [self.navigationController pushViewController:low animated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
