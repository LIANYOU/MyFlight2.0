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
    NSString * twoGoData;
    NSString * twoGoBack;
}
@end

@implementation OneWayCheckViewController

int searchFlag = 1; // 单程和往返的标记位

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

    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(230, 5, 30, 30);
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_history_.png"]];
    [histroyBut addTarget:self action:@selector(historySearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=histroyBtn;
    [histroyBtn release];
    
    self.selectOne.frame = CGRectMake(0, 61+8, 320, 160);
    [self.view addSubview:self.selectTwoWay];
    
    self.selectTwoWay.frame = CGRectMake(320, 61+8, 320, 160);
    [self.view addSubview:self.selectOne];
    
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
    
    searchDate.startPortName = startAirport.text;
    searchDate.endPortName = endAirport.text;
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    self.view.backgroundColor = myFirstColor;
    
    NSArray * array = [[NSArray alloc]initWithObjects:@"单程",@"往返", nil];
    mySegmentController  = [[SVSegmentedControl alloc]initWithSectionTitles:array];
    mySegmentController.textColor = myFirstColor;
    //mySegmentController.thumb.backgroundImage = [UIImage imageNamed:@"block3_change.png"];
    mySegmentController.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    mySegmentController.height = 40;
    mySegmentController.LKWidth = 150;
    mySegmentController.thumb.tintColor = [UIColor whiteColor];
    mySegmentController.center = CGPointMake(160, 36);
    
    mySegmentController.thumb.textColor = mySceColor;
    mySegmentController.thumb.textShadowColor = [UIColor clearColor];
    [array release];
    mySegmentController.crossFadeLabelsOnDrag = YES;
    
    mySegmentController.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    [self.view addSubview:mySegmentController];
    
    self.startNameArr = [NSMutableArray array];
    self.endNameArr = [NSMutableArray array];
    self.flyFlagArr = [NSMutableArray array];
    
    mySegmentController.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [mySegmentController addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
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
    NSString * string = [NSString stringWithFormat:@"%d月%d日",month,day];
    oneGoData = [[NSString alloc] initWithFormat:@"%4d-%2d-%2d",year,month,day ];
    NSLog(@"%@",oneGoData);
    [startDate setText:string];
    oneSatrtDate.text = string;
    
    
    [dateformatter release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    HistroyCheckViewController * histroy = [[HistroyCheckViewController alloc] init];
    [self.navigationController pushViewController:histroy animated:YES];
    [histroy release];
}

- (IBAction)getStartPort:(id)sender {
    
    chooseAirPort =[[ChooseAirPortViewController alloc] init];
    chooseAirPort.startAirportName = startAirport.text;
    chooseAirPort.endAirPortName = endAirport.text;
    chooseAirPort.choiceTypeOfAirPort=START_AIRPORT_TYPE;
    
    
    chooseAirPort.delegate =self;
    [self.navigationController pushViewController:chooseAirPort animated:YES];    
}

-(void) setYear: (int) year month: (int) month day: (int) day {
    
    [leaveDate setYear:year month:month day:day];
    [oneSatrtDate setText:[NSString stringWithFormat:@"%d月%d日", month, day]];
    [startDate setText:[NSString stringWithFormat:@"%d月%d日", month, day]];
    [returnDate setText:[NSString stringWithFormat:@"%d月%d日", month, day]];
    oneGoData = [[NSString alloc] initWithFormat:@"%d-%d-%d",year,month,day];
    if (delegataFlag == 1) {
         twoGoBack = [[NSString alloc] initWithFormat:@"%d-%d-%d",year,month,day];
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
        
        searchAirPort = [[SearchAirPort alloc] initWithdpt:oneStartCode arr:oneEndCode date:oneGoData ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        show.startPort = oneStartAirPort.text;
        show.endPort = oneEndAirPort.text;
        show.startThreeCode = oneStartCode;
        show.endThreeCode = oneEndCode;
        
          }
    else{
        searchAirPort = [[SearchAirPort alloc] initWithdpt:startCode arr:endCode date:oneGoData ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        show.startPort = startAirport.text;
        show.endPort = endAirport.text;
        show.startThreeCode = startCode;
        show.endThreeCode = endCode;
        
        show.goBackDate = twoGoBack;
       

    }
    
    show.airPort = searchAirPort;
    show.one = self;
    

    
    show.startDate = @"2012-12-30";   // 假定一个写死的出发日期
    
    show.flag = searchFlag;
    
    [self.navigationController pushViewController:show animated:YES];
    [show release];
}

- (IBAction)changeAirPort:(id)sender {    
    [UIView animateWithDuration:1.0 animations:^(void)  //不用回调
     {
         if (flag == 1) {
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(-170, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(170, 0);
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
    
    [UIView animateWithDuration:1.0 animations:^(void)  //不用回调
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
    [super dealloc];
}


-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    if (arg.selectedIndex == 0) {
        searchFlag = 1;
       
        [UIView animateWithDuration:0.2 animations:^(void)  //不用回调
         {
             CGAffineTransform moveTo = CGAffineTransformMakeTranslation(0, 0);
             CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(320, 0);
             self.selectOne.layer.affineTransform = moveTo;
             self.selectTwoWay.layer.affineTransform = moveFrom;
         }  completion:^(BOOL finished)
         {
             
         }];

    }else if (arg.selectedIndex == 1){

        searchFlag = 2;
        
        [UIView animateWithDuration:0.2 animations:^(void)  //不用回调
         {
             CGAffineTransform moveTo1 = CGAffineTransformMakeTranslation(320, 0);
             CGAffineTransform moveFrom1 = CGAffineTransformMakeTranslation(-320, 0);
             self.selectTwoWay.layer.affineTransform = moveFrom1;
             self.selectOne.layer.affineTransform = moveTo1;
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
