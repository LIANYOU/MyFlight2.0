//
//  OneWayCheckViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "OneWayCheckViewController.h"
#import "HistroyCheckViewController.h"
#import "ShowSelectedResultViewController.h"
#import "SearchAirPort.h"
#import "ChooseAirPortViewController.h"
#import "AirPortData.h"
#import "AppConfigure.h"
#import "MonthDayCell.h"
#import "SelectCalendarController.h"
#import "HistoryCheckDataBase.h"
#import "UIImage+scaleImage.h"
#import "TransitionString.h"
#import "UIButton+BackButton.h"
@interface OneWayCheckViewController ()
{
    int delegataFlag;
    
    int oneFlag;
    int flag;
    
    NSString * code;
    NSString * oneCode;
    
    ChooseAirPortViewController *chooseAirPort;
    
    UILabel * changeString;
    
    NSString * oneGoData;

//    NSString * twoGoBack;
    
    
    int todayCount;
    int selectDayCount;
}
@end

@implementation OneWayCheckViewController

int searchFlag = 1; // 单程和往返的标记位

int whatday(int year,int month,int day);

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
    if (Default_IsUserLogin_Value) {
        NSLog(@"登陆");
    }

    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"orange_btn.png"] forState:1];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"orange_btn_click.png"] forState:UIControlStateHighlighted];
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(230, 5, 30, 30);
    [histroyBut setImage:[UIImage imageNamed:@"icon_history.png"] forState:0];
    [histroyBut addTarget:self action:@selector(historySearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=histroyBtn;
    [histroyBtn release];
    
       
    self.navigationItem.title = @"机票查询";
    
    startAirport.text = @"北京首都";
    endAirport.text = @"上海虹桥";
    
    oneStartAirPort.text = @"北京首都";
    oneEndAirPort.text = @"上海虹桥";
    
    startCode = @"PEK";
    endCode = @"SHA";
    
    oneStartCode = @"PEK";
    oneEndCode = @"SHA";
    
    flag = 1;
    oneFlag = 1;
    searchFlag = 1;
    
    searchDate.startPortName = startAirport.text;
    searchDate.endPortName = endAirport.text;
    
    self.startNameArr = [NSMutableArray array];
    self.endNameArr = [NSMutableArray array];
    self.flyFlagArr = [NSMutableArray array];
    
    leaveDate = [Date today];
    [leaveDate retain];
   
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
    todayCount = whatday(year, month, day);
    
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

    
    oneGoData = [[NSString alloc] initWithFormat:@"%4d-%@-%@",year,strMonth,strDay ];
    
    NSString * nextDAY = [TransitionString getNextDay:oneGoData];

   
    NSString * string = [NSString stringWithFormat:@"%@-%@",strMonth,strDay];
    NSString * string1 = [nextDAY substringWithRange:NSMakeRange(5, 5)];
    [startDate setText:string];
    [returnDate setText:string1];
    [nextDayTitle setText:@"明天"];
    oneSatrtDate.text = string;
    
    self.twoGoBack = nextDAY;
  
    [dateformatter release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // ******* 定义
    UIColor * myFirstColor = [UIColor colorWithRed:186/255.0 green:195/255.0 blue:215/255.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:20/255.0 green:89/255.0 blue:179/255.0 alpha:1];
    self.view.backgroundColor = myFirstColor;
    
    NSArray * array = [[NSArray alloc]initWithObjects:@"单程",@"往返", nil];
    mySegmentController  = [[SVSegmentedControl alloc]initWithSectionTitles:array];
    mySegmentController.textColor = myFirstColor;
    mySegmentController.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    mySegmentController.height = 40;
    mySegmentController.LKWidth = 150;


        if ([self.flagType isEqualToString:@"2"]) {
      
            mySegmentController.selectedIndex = 1;
            self.selectTwoWay.frame = CGRectMake(0, 61+8, 320, 160);
            [self.view addSubview:self.selectTwoWay];
            
            self.selectOne.frame = CGRectMake(320, 61+8, 320, 160);
            [self.view addSubview:self.selectOne];

        }
        else{
            mySegmentController.selectedIndex = 0;
            self.selectOne.frame = CGRectMake(0, 61+8, 320, 160);
            [self.view addSubview:self.selectOne];
            
            self.selectTwoWay.frame = CGRectMake(320, 61+8, 320, 160);
            [self.view addSubview:self.selectTwoWay];
        }

   // mySegmentController.selectedIndex = 1; // 默认是单程
    mySegmentController.thumb.tintColor = [UIColor whiteColor];
 //   mySegmentController.thumb.
    mySegmentController.center = CGPointMake(160, 36);
    mySegmentController.thumbEdgeInset = UIEdgeInsetsMake(2, 2, 3, 2);
    mySegmentController.cornerRadius = 7;
   

    //[mySegmentController.thumb setBackgroundImage:[UIImage imageNamed:@"tab.png"]];
//    [mySegmentController.thumb setBounds:CGRectMake(0, 0, 144, 10)];

    [mySegmentController.thumb setMultipleTouchEnabled:NO];
   // [mySegmentController.thumb setHighlightedBackgroundImage:[UIImage imageNamed:@"tab.png"]];

    mySegmentController.thumb.textColor = mySceColor;
    mySegmentController.thumb.textShadowColor = [UIColor clearColor];
    [array release];
    mySegmentController.crossFadeLabelsOnDrag = YES;
    
    mySegmentController.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    [self.view addSubview:mySegmentController];
    
    mySegmentController.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [mySegmentController addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
    if (self.history != nil) {

        if ([self.flagType isEqualToString:@"1"]) {

            searchFlag = 1;
            oneStartAirPort.text = self.oneStartName;
            oneEndAirPort.text = self.oneEndName;
            oneStartCode = self.oneStartCode;
            oneEndCode = self.oneEndCode;
        }
        else{

            searchFlag = 2;
            startAirport.text = self.startName;
            endAirport.text = self.endName;
            startCode = self.startCode;
            endCode = self.endCode;
        }
        
        self.history = nil;

    }
    
}
- (void)viewDidUnload
{
    [startAirport release];
    startAirport = nil;
    [endAirport release];
    endAirport = nil;
    [startDate release];
    startDate = nil;
    [returnDate release];
    returnDate = nil;
    [returnBtn release];
    returnBtn = nil;
    [retrunDateTitle release];
    retrunDateTitle = nil;

    [returnImage release];
    returnImage = nil;
    [image release];
    image = nil;
    [self setSelectOne:nil];
    [oneStartAirPort release];
    oneStartAirPort = nil;
    [oneEndAirPort release];
    oneEndAirPort = nil;
    [oneSatrtDate release];
    oneSatrtDate = nil;
    [beginView release];
    beginView = nil;
    [endView release];
    endView = nil;
    [beginImage release];
    beginImage = nil;
    [endImage release];
    endImage = nil;
    [beginTitle release];
    beginTitle = nil;
    [endTitle release];
    endTitle = nil;
    [twoBeginView release];
    twoBeginView = nil;
    [twoEndView release];
    twoEndView = nil;
    [twoBeginImageView release];
    twoBeginImageView = nil;
    [twoEndImageView release];
    twoEndImageView = nil;
    [twoBeginTitle release];
    twoBeginTitle = nil;
    [twoEndTitle release];
    twoEndTitle = nil;

    [self setSelectButton:nil];
    [oneDayTitle release];
    oneDayTitle = nil;
    [dayTitle release];
    dayTitle = nil;
    [nextDayTitle release];
    nextDayTitle = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)historySearch
{

    HistroyCheckViewController * history = [[HistroyCheckViewController alloc] init];
    [self.navigationController pushViewController:history animated:YES];
    [history release];
}

- (IBAction)getStartPort:(id)sender {
    
    chooseAirPort =[[ChooseAirPortViewController alloc] init];
    chooseAirPort.startAirportName = startAirport.text;
    chooseAirPort.endAirPortName = endAirport.text;
    chooseAirPort.choiceTypeOfAirPort=START_AIRPORT_TYPE;
    
    
    chooseAirPort.delegate =self;
    [self.navigationController pushViewController:chooseAirPort animated:YES];    
}

int whatday(int year,int month,int day) /*计算给定年月日的某一天是当年的第几天*/
{
    int isleap(int);
    int ans=0;
    switch(month)
    {
        case 1:ans=0;break;
        case 2:ans=31;break;
        case 3:ans=59;break;
        case 4:ans=90;break;
        case 5:ans=120;break;
        case 6:ans=151;break;
        case 7:ans=181;break;
        case 8:ans=212;break;
        case 9:ans=243;break;
        case 10:ans=273;break;
        case 11:ans=304;break;
        case 12:ans=334;break;
    }
    ans+=day;
    if(((year%100!=0&&year%4==0)||year%400==0)&&month>2)ans++;
    return ans;
}


-(void) setYear: (int) year month: (int) month day: (int) day {
    [leaveDate setYear:year month:month day:day];
    
    selectDayCount =  whatday( year, month,day);

    if (delegataFlag == 0) {
  
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
        
        [oneSatrtDate setText:[NSString stringWithFormat:@"%@-%@", strMonth, strDay]];
        [startDate setText:[NSString stringWithFormat:@"%@-%@", strMonth, strDay]];
        
        oneGoData = [[NSString alloc] initWithFormat:@"%4d-%@-%@",year,strMonth,strDay];
        
        switch (selectDayCount- todayCount) {
            case 0:
                oneDayTitle.text = @"今天";
                dayTitle.text = @"今天";
                break;
            case 1:
                oneDayTitle.text = @"明天";
                dayTitle.text = @"明天";
          
                break;
                
            case 2:
                oneDayTitle.text = @"后天";
                dayTitle.text = @"后天";
          
                break;
                
                
            default:
                oneDayTitle.text = @"";
                dayTitle.text = @"";
                break;
        }

        

        delegataFlag = 10;
    }
    
    if (delegataFlag == 1) {

        
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
        
        [returnDate setText:[NSString stringWithFormat:@"%@-%@", strMonth, strDay]];
        
        self.twoGoBack = [[NSString alloc] initWithFormat:@"%4d-%@-%@",year,strMonth,strDay];
        
        switch (selectDayCount- todayCount) {
            case 0:
                nextDayTitle.text = @"今天";
                break;
            case 1:
                nextDayTitle.text = @"明天";
                
                break;
                
            case 2:
               nextDayTitle.text = @"后天";
                
                break;
                
                
            default:
                nextDayTitle.text = @"";
                break;
        }

        
        delegataFlag = 10;
    }
    
    
    

}


- (IBAction)getStartDate:(id)sender {
    delegataFlag = 0;
    [MonthDayCell selectYear:leaveDate.year month:leaveDate.month day:leaveDate.day];
    SelectCalendarController* controller = [[SelectCalendarController alloc] init];
    [controller setDelegate:self];
    [controller showCalendar];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction)getBackData:(id)sender {
    delegataFlag = 1;
    [MonthDayCell selectYear:leaveDate.year month:leaveDate.month day:leaveDate.day];
    
    SelectCalendarController* controller = [[SelectCalendarController alloc] init];
    [controller setDelegate:self];
    [controller showCalendar];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

}

- (IBAction)getEndPort:(id)sender {
    
    chooseAirPort =[[ChooseAirPortViewController alloc] init];
    chooseAirPort.startAirportName = startAirport.text;
    chooseAirPort.endAirPortName = endAirport.text;
    chooseAirPort.choiceTypeOfAirPort = END_AIRPORT_TYPE;
    chooseAirPort.delegate =self;
    [self.navigationController pushViewController:chooseAirPort animated:YES];
    
}


- (IBAction)select:(id)sender {

   
    SearchAirPort * searchAirPort;
    
    ShowSelectedResultViewController * show = [[ShowSelectedResultViewController alloc] init];

    
    if (searchFlag == 1) {
        
     //   NSLog(@"首页单程机票查询条件 ：%@%@%@",oneStartCode,oneEndCode,oneGoData);
        searchAirPort = [[SearchAirPort alloc] initWithdpt:oneStartCode arr:oneEndCode date:oneGoData ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        show.startPort = oneStartAirPort.text;
        show.endPort = oneEndAirPort.text;
        show.startThreeCode = oneStartCode;
        show.endThreeCode = oneEndCode;
        
        show.goDate = oneGoData;
        
         [HistoryCheckDataBase addHistoryFlightWithStartName:oneStartAirPort.text endName:oneEndAirPort.text startApCode:oneStartCode  endApCode:oneEndCode searchFlag: [NSString stringWithFormat:@"%d",1 ]];
        
          }
    else{
        
        NSArray * GoARR = [oneGoData componentsSeparatedByString:@"-"];
        int goCount = whatday([[GoARR objectAtIndex:0]intValue], [[GoARR objectAtIndex:1]intValue], [[GoARR objectAtIndex:2]intValue]);
        
        NSArray * backARR = [self.twoGoBack componentsSeparatedByString:@"-"];
         int backCount = whatday([[backARR objectAtIndex:0]intValue], [[backARR objectAtIndex:1]intValue], [[backARR objectAtIndex:2]intValue]);
        
        if (goCount>=backCount) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"选择日期有误，请重新选择。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            return;
          
        }
       
        NSLog(@"首页往返机票查询条件 ： %@%@%@，%@",startCode,endCode,oneGoData,self.twoGoBack);
        searchAirPort = [[SearchAirPort alloc] initWithdpt:startCode arr:endCode date:oneGoData ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        show.startPort = startAirport.text;
        show.endPort = endAirport.text;
        show.startThreeCode = startCode;
        show.endThreeCode = endCode;
        
        show.goDate = oneGoData;
        
        show.goBackDate = self.twoGoBack;
        
        // 加入到历史数据库中
        [HistoryCheckDataBase addHistoryFlightWithStartName:startAirport.text endName:endAirport.text startApCode:startCode  endApCode:endCode searchFlag: [NSString stringWithFormat:@"%d",2 ]];
       

    }
    
    show.airPort = searchAirPort;
    show.one = self;
    

    show.oneGoDate = startDate.text;
    show.twoGoBackDate = returnDate.text;
    
    show.startDate = oneGoData;
    
    show.flag = searchFlag;
    
    [self.navigationController pushViewController:show animated:YES];
    
    
    
    
    [show release];
}

- (IBAction)changeAirPort:(id)sender {    
    [UIView animateWithDuration:0.5 animations:^(void)  //不用回调
     {
         if (flag == 1) {
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(170, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(-170, 0);
             twoBeginView.layer.affineTransform = moveTo;
             twoEndView.layer.affineTransform = moveFrom;
             flag = 2;
         }
         else{
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(0, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(0, 0);
             twoEndView.layer.affineTransform = moveTo;
             twoBeginView.layer.affineTransform = moveFrom;
             flag = 1;
         }
         
     }  completion:^(BOOL finished)
     {
    
         
         if (flag == 2) {
             twoBeginImageView.image = [UIImage imageNamed:@"icon_arrive.png"];
             twoEndImageView.image = [UIImage imageNamed:@"icon_depart.png"];
             twoBeginTitle.text = @"到达机场";
             twoEndTitle.text = @"出发机场";
             
         }
         else{
             twoBeginImageView.image = [UIImage imageNamed:@"icon_depart.png"];
             twoEndImageView.image = [UIImage imageNamed:@"icon_arrive.png"];
             twoBeginTitle.text = @"出发机场";
             twoEndTitle.text = @"到达机场";
             
         }

         
         changeString = startAirport;
         startAirport = endAirport;
         endAirport = changeString;
         changeString = nil;
         
         code = startCode;
         startCode = endCode;
         endCode = code;
         code = nil;
         }  ];
}

- (IBAction)oneChangeAirPort:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^(void)  //不用回调
     {
         if (oneFlag == 1) {
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(170, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(-170, 0);
             beginView.layer.affineTransform = moveTo;
             endView.layer.affineTransform = moveFrom;
             oneFlag = 2;
         }
         else{
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(0, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(0, 0);
             endView.layer.affineTransform = moveTo;
             beginView.layer.affineTransform = moveFrom;
             oneFlag = 1;
         }
         
     }  completion:^(BOOL finished)
     {
         changeString = oneStartAirPort;
         oneStartAirPort = oneEndAirPort;
         oneEndAirPort = changeString;
         changeString = nil;
         
         if (oneFlag == 2) {
             beginImage.image = [UIImage imageNamed:@"icon_arrive.png"];
             endImage.image = [UIImage imageNamed:@"icon_depart.png"];
             beginTitle.text = @"到达机场";
             endTitle.text = @"出发机场";

         }
         else{
             beginImage.image = [UIImage imageNamed:@"icon_depart.png"];
             endImage.image = [UIImage imageNamed:@"icon_arrive.png"];
             beginTitle.text = @"出发机场";
             endTitle.text = @"到达机场";

         }
         
         oneCode = oneStartCode;
         oneStartCode = oneEndCode;
         oneEndCode = oneCode;
         oneCode = nil;
         
     }  ];

}


- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger )choiceType didSelectAirPortInfo:(AirPortData *)airPort{
    
    if (choiceType==START_AIRPORT_TYPE) {
        
        startAirport.text = airPort.apName;
        oneStartAirPort.text = airPort.apName;
        startCode =   airPort.apCode;
        oneStartCode = airPort.apCode;
        
    } else if(choiceType==END_AIRPORT_TYPE){
        
        endAirport.text = airPort.apName;
        oneEndAirPort.text = airPort.apName;
        endCode = airPort.apCode;
        oneEndCode = airPort.apCode;
    }
 
}
- (void)dealloc {
    [startAirport release];
    [endAirport release];
    [startDate release];
    [returnDate release];
    [returnBtn release];
    [retrunDateTitle release];
    [returnImage release];
    [image release];
    [_selectOne release];
    [oneStartAirPort release];
    [oneEndAirPort release];
    [oneSatrtDate release];
    [beginView release];
    [endView release];
    [beginImage release];
    [endImage release];
    [beginTitle release];
    [endTitle release];
    [twoBeginView release];
    [twoEndView release];
    [twoBeginImageView release];
    [twoEndImageView release];
    [twoBeginTitle release];
    [twoEndTitle release];

    [_selectButton release];
    [oneDayTitle release];
    [dayTitle release];
    [nextDayTitle release];
    [super dealloc];
}


-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    if (arg.selectedIndex == 0) {
        searchFlag = 1;
       
        self.flagType = @"1";
        
        [UIView animateWithDuration:0.2 animations:^(void)  //不用回调
         {
             if ([self.flagType isEqualToString:@"2"]) {
                 
                 self.selectOne.frame = CGRectMake(0, 61+8, 320, 160);
                 
                 self.selectTwoWay.frame = CGRectMake(320, 61+8, 320, 160);
             }
             else
             {
                 self.selectOne.frame = CGRectMake(0, 61+8, 320, 160);
                 
                 self.selectTwoWay.frame = CGRectMake(320, 61+8, 320, 160);
             }
          }  completion:^(BOOL finished)
         {
             
         }];

    }else if (arg.selectedIndex == 1){

        self.flagType = @"2";
        searchFlag = 2;
        
        [UIView animateWithDuration:0.2 animations:^(void)  //不用回调
         {
             if ([self.flagType isEqualToString:@"2"]) {
                 
                 self.selectTwoWay.frame = CGRectMake(0, 61+8, 320, 160);
                 
                 self.selectOne.frame = CGRectMake(320, 61+8, 320, 160);
                 
             }
             else{
                 
                 self.selectTwoWay.frame = CGRectMake(0, 61+8, 320, 160);
                 
                 self.selectOne.frame = CGRectMake(320, 61+8, 320, 160);
             }
             
         }  completion:^(BOOL finished)
         {
             
         }];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
