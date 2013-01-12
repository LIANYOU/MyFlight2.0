//
//  SearchFlightConditionController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchFlightConditionController.h"
#import "SearchFlightCondition.h"
#import "ShowFligthConditionController.h"
#import "DetailFlightConditionViewController.h"
#import "AirPortData.h"
#import "AppConfigure.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "GetAttentionFlight.h"
#import "LookFlightConditionCell.h"
#import "UIButton+BackButton.h"
#import "DetailFlightConditionViewController.h"
@interface SearchFlightConditionController ()

{
    int btnTag;  // 判断取消关注的是哪一个

}
@end

@implementation SearchFlightConditionController
int whichDay(int year,int month,int day);

@synthesize flightTimeByNumber;
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

    
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationItem.title = @"已关注航班列表";
    selectView = [[UIView alloc]initWithFrame:CGRectMake(0,-[[UIScreen mainScreen]bounds].size.height, 320, [[UIScreen mainScreen]bounds].size.height)];
    selectView.backgroundColor = BACKGROUND_COLOR;
    isAttention = NO;
    
    
    
    //航班动态列表,上面放一个tableview,动画也放这上面
    myConditionListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)];
    myConditionListView.backgroundColor = FOREGROUND_COLOR;
//    myConditionListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 320, [[UIScreen mainScreen]bounds].size.height - 64-30)];
//    myConditionListTableView.backgroundColor = FOREGROUND_COLOR;
//    myConditionListTableView.dataSource = self;
//    myConditionListTableView.delegate = self;
//    [myConditionListView addSubview:myConditionListTableView]; //在btn之后加
//    myConditionListTableView.hidden = YES;
    
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, 320, [UIScreen mainScreen].bounds.size.height - 64 - 25)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.contentSize = CGSizeMake(320, 1000);
    [myConditionListView addSubview:scrollview];
    scrollview.hidden = YES;
    
//    NSDictionary * btnusedic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil];
//    UIImageView * cunbtn = [self createBtnWithDic:btnusedic index:0];
    
//    [scrollview addSubview:cunbtn];

    
    [self.view addSubview:myConditionListView];
    
    
    
    
    
   
    //动画
//    animationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height/2 - 160 - 32, 320, 320)];
    animationView = [[UIImageView alloc]initWithFrame:CGRectMake(48,40,224, 224)];
    NSArray * animationImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"dong1.png"],[UIImage imageNamed:@"dong2.png"], nil];
    animationView.animationImages = animationImageArray;
    animationView.animationDuration = .35;
    animationView.hidden = YES;
//    [myConditionListView addSubview:animationView];
    animationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [animationBtn addSubview:animationView];
    animationBtn.frame = CGRectMake(0, 0, 224, 224);
    [animationBtn addTarget:self action:@selector(attentionTapEvent) forControlEvents:UIControlEventTouchUpInside];
    animationBtn.hidden = YES;
    [myConditionListView addSubview:animationBtn];
//    [myConditionListView addSubview:myConditionListTableView];
    [myConditionListTableView addSubview:scrollview];
    scrollview.userInteractionEnabled = YES;
    
    remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 340, 320, 20)];
    remindLabel.text = @"关注后可免费获得通知";
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.backgroundColor = [UIColor clearColor];
    remindLabel.hidden = YES;
    remindLabel.textColor = FONT_COLOR_RED;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [myConditionListView addSubview:remindLabel];
    
    remindLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 360, 320, 20)];
    remindLabel1.text = @"随时了解航班起降信息";
    remindLabel1.font = [UIFont systemFontOfSize:14];
    remindLabel1.backgroundColor = [UIColor clearColor];
    remindLabel1.hidden = YES;
    remindLabel1.textColor = FONT_COLOR_RED;
    remindLabel1.textAlignment = NSTextAlignmentCenter;
    [myConditionListView addSubview:remindLabel1];
    
    //遮罩
    shade = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)];
    shade.backgroundColor = [UIColor blackColor];
    shade.alpha = 0.0;
//    shade.hidden = YES;
    shade.userInteractionEnabled = NO;
    [myConditionListView addSubview:shade];
    
    
    
   
    //定制导航右键
    rightsuperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 72)];
    btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 85, 62)];
    [btnImageView setImage:[UIImage imageNamed:@"add_Attention_condition.png"]];
    [rightsuperView addSubview:btnImageView];
    UITapGestureRecognizer * attentionTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(attentionTapEvent)];
    [rightsuperView addGestureRecognizer:attentionTap];
    [attentionTap release];
    
    
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:rightsuperView];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
 
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:222.0/255.0 blue:215.0/255.0 alpha:1];;
    
    NSArray * array = [[NSArray alloc]initWithObjects:@"按起降地",@"按航班号", nil];
    mySegmentController  = [[SVSegmentedControl alloc]initWithSectionTitles:array];
    mySegmentController.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    mySegmentController.textColor = myFirstColor;
    mySegmentController.height = 40;
    mySegmentController.LKWidth = 150;
    mySegmentController.center = CGPointMake(160, 50);
    mySegmentController.thumb.textColor = mySceColor;
    mySegmentController.thumb.tintColor = [UIColor whiteColor];
    mySegmentController.thumb.textShadowColor = [UIColor clearColor];
    [array release];
    mySegmentController.crossFadeLabelsOnDrag = YES;
   
    mySegmentController.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    [selectView addSubview:mySegmentController];
    
    

    mySegmentController.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [mySegmentController addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.selectedByAirPort.frame = CGRectMake(0, 460-390, 320, 378);
    self.selectedByAirPort.backgroundColor = [UIColor clearColor];
    self.selectedByDate.frame = CGRectMake(320, 460-390, 320, 378);
    self.selectedByDate.backgroundColor  = [UIColor clearColor];
    self.selectedByDate.hidden = YES;
    [selectView addSubview:self.selectedByAirPort];
    [selectView addSubview:self.selectedByDate];
    
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];

    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
     todayCount = whichDay(year, month, day);

    
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d-%02d-%02d",year,month,day];
    [self.time setText:nsDateString];
    [self.flightTimeByNumber setText:nsDateString];

    [dateformatter release];
    
    _lookFlightArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    [self getListData];
    
    
    [self.view addSubview:selectView];
    
    self.whichDateLabel.text = @"今天";
    self.whichDataLabelAirPort.text = @"今天";
    // Do any additional setup after loading the view from its nib.
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDelFlightData:) name:@"关注航班" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"获得已经关注航班信息" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [myConditionListTableView release];
    [myConditionListView release];
    [selectView release];
    [mySegmentController release];
    
    [_startAirPort release];
    [_endAirPort release];
    [_time release];
    [_selectedByAirPort release];
 
    [_flightNumber release];
    [_selectedByDate release];
    
    [_lookCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStartAirPort:nil];
    [self setEndAirPort:nil];
    [self setTime:nil];
    [self setSelectedByAirPort:nil];

    [self setFlightNumber:nil];
    [self setSelectedByDate:nil];
    
    [self setLookCell:nil];
    [super viewDidUnload];
}

#pragma mark - 点击日期按钮
- (IBAction)chooseDateBtnClick:(id)sender {
    [self.flightNumber resignFirstResponder];
    
    [MonthDayCell selectYear:leaveDate.year month:leaveDate.month day:leaveDate.day];
    SelectCalendarController* controller = [[SelectCalendarController alloc] init];
    [controller setDelegate:self];
    [controller showCalendar];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


//计算显示 今天、明天或者后天（日期按钮）
/*计算给定年月日的某一天是当年的第几天*/
int whichDay(int year,int month,int day)
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
    ans += day;
    if(((year%100!=0&&year%4==0)||year%400==0)&&month>2)ans++;
    return ans;
}

//日历代理，获得日期
-(void) setYear: (int) year month: (int) month day: (int) day {
    [leaveDate setYear:year month:month day:day];
    NSLog(@"leaveDate : %d,%d,%d",year,month,day);
    NSString * chooseDateStr = [NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    [self.time setText:chooseDateStr];
    [self.flightTimeByNumber setText:chooseDateStr];
    
    selectDayCount =  whichDay(year, month, day);
    NSLog(@"%d",selectDayCount- todayCount);
    switch (selectDayCount- todayCount) {
        case 0:{
            self.whichDateLabel.text = @"今天";
            self.whichDataLabelAirPort.text = @"今天";
            break;
        }
        case 1:{
            self.whichDateLabel.text = @"明天";
            self.whichDataLabelAirPort.text = @"明天";

            break;
        }
        case 2:{
            self.whichDateLabel.text = @"后天";
            self.whichDataLabelAirPort.text = @"后天";

            break;
        }
        default:
            self.whichDateLabel.text = @"";
            self.whichDataLabelAirPort.text = @"";
            break;
    }
}




#pragma mark - 点击查询按钮事件

- (IBAction)searchFligth:(id)sender {
    //收键盘
    [self.flightNumber resignFirstResponder];
    
    if (mySegmentController.selectedIndex == 0) {
        if ([startAirPortCode isEqualToString:arrAirPortCode]) {
            UIAlertView * theSameAirPort = [[UIAlertView alloc]initWithTitle:@"机场相同" message:@"出发机场不能与到达机场相同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [theSameAirPort show];
            [theSameAirPort release];
            
        }else{
            if (startAirPortCode == nil) {
                startAirPortCode = @"PEK";
            }
            if (arrAirPortCode == nil) {
                arrAirPortCode = @"SHA";
            }
            SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:nil fdate:self.time.text dpt:startAirPortCode arr:arrAirPortCode hwld:nil];
            ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
            show.searchCondition = search;
            show.deptAirPortCode = startAirPortCode;
            show.arrAirPortCode = arrAirPortCode;
            [self.navigationController pushViewController:show animated:YES];
            [search release];
            [show release];
        }
    }else {
        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:self.flightNumber.text fdate:self.flightTimeByNumber.text dpt:nil arr:nil hwld:nil];
        ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
        show.searchCondition = search;
        show.deptAirPortCode = startAirPortCode;
        show.arrAirPortCode = arrAirPortCode;
        [self.navigationController pushViewController:show animated:YES];
        [search release];
        [show release];
    }
    

}
#pragma mark - 

#pragma mark - 选择机场
- (IBAction)chooseStartAirPort:(id)sender {
    //收键盘
    
    [self.flightNumber resignFirstResponder];

    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    //默认出发机场 
    controller.startAirportName = self.startAirPort.text;
    //默认到达机场 
    controller.endAirPortName =self.endAirPort.text;
    //选择的类型 
    controller.choiceTypeOfAirPort = START_AIRPORT_TYPE;
    controller.delegate =self;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)chooseEndAirPort:(id)sender {
    //收键盘
    [self.flightNumber resignFirstResponder];
    
    
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    //默认出发机场
    controller.startAirportName = self.startAirPort.text;
    //默认到达机场
    controller.endAirPortName =self.endAirPort.text;
    //选择的类型
    controller.choiceTypeOfAirPort = END_AIRPORT_TYPE;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - 

-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    //收键盘
    [self.flightNumber resignFirstResponder];
    if (arg.selectedIndex == 1) {
        /*
         |a    b    0|
         
         |c    d    0|
         
         |tx   ty   1|
         */
        self.selectedByDate.hidden = NO;
        self.selectedByAirPort.hidden = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(mySegmentValueOne)];
        CGAffineTransform moveTo = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(-320, 0);
        self.selectedByAirPort.layer.affineTransform = moveTo;
        self.selectedByDate.layer.affineTransform = moveFrom;
        [UIView commitAnimations];
        
        
    }else if (arg.selectedIndex == 0){
        self.selectedByDate.hidden = NO;
        self.selectedByAirPort.hidden = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(mySegmentValueTwo)];
        CGAffineTransform moveTo1 = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom1 = CGAffineTransformMakeTranslation(0, 0);
        self.selectedByAirPort.layer.affineTransform = moveFrom1;
        self.selectedByDate.layer.affineTransform = moveTo1;
        [UIView commitAnimations];
    }
}


#pragma mark - 两种查询方法切换后的隐藏
-(void)mySegmentValueOne{
    self.selectedByAirPort.hidden = YES;
}
-(void)mySegmentValueTwo{
    self.selectedByDate.hidden = YES;
}

- (IBAction)returnClicked:(id)sender {
    [self.flightNumber resignFirstResponder];
}

#pragma mark - 选择机场
- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPortP{
    
    
    if (choiceType==START_AIRPORT_TYPE ) {
        //获得用户的出发机场 
        self.startAirPort.text = airPortP.apName;
        startAirPortCode = [NSString stringWithString:airPortP.apCode];
    } else if(choiceType==END_AIRPORT_TYPE){
        //获得用户的到达机场
        self.endAirPort.text = airPortP.apName;
        arrAirPortCode = [NSString stringWithString:airPortP.apCode];
        
    }
}

#pragma mark - 获得已经关注航班信息
-(void)getListData{
    
    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;
    
    GetAttentionFlight * flight = [[GetAttentionFlight alloc] initWithMemberId:memberID
                                                                  andOrgSource:@"51YOU"
                                                                       andType:@"P"
                                                                      andToken:hwID
                                                                     andSource:@"1"
                                                                       andHwid:hwID
                                                                andServiceCode:@"01"];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"获得已经关注航班信息" object:nil];
    [flight getAttentionFlight];
}

#pragma mark - 接受到数据后
-(void)receive:(NSNotification *) not
{

    self.lookFlightArr = [[not userInfo] objectForKey:@"arr"];
    NSLog(@"获得已经关注航班信息 : %@",self.lookFlightArr);

    if (self.lookFlightArr) {
        animationView.hidden = YES;
        [animationView stopAnimating];
//        myConditionListTableView.hidden = NO;
//        [myConditionListTableView reloadData];
        scrollview.hidden = NO;
        animationBtn.hidden = YES;
        remindLabel.hidden = YES;
        remindLabel1.hidden = YES;
//        shade.hidden = YES;
        [self alphaToZero];
        [self resetSendMessageBtnFrame];

    }else{
        animationView.hidden = NO;
        remindLabel.hidden = NO;
        remindLabel1.hidden = NO;
//        myConditionListTableView.hidden = YES;
        scrollview.hidden = YES;
        animationBtn.hidden = NO;
        [animationView startAnimating];
    }
//    [myConditionListTableView reloadData];
    [self resetSendMessageBtnFrame];

}

#pragma mark - 废弃的方法
-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    // NSString * myUrl = [NSString stringWithFormat:@"%@3gWeb/api/provision.jsp",BASE_Domain_Name];
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/flightMovement.jsp"];
    
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"XXX" forKey:@"memberId"];
    [request setPostValue:@"51YOU" forKey:@"orgSource"];
    [request setPostValue:@"iphone" forKey:@"source"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v3.0" forKey:@"edition"];
    
   
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    NSLog(@"request :%@",request);
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"temp : %@",temp);
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}
#pragma mark - 导航右键点击事件响应方法
-(void)attentionTapEvent{
    isAttention = !isAttention;
    selectView.hidden = NO;
    rightsuperView.userInteractionEnabled = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    btnImageView.frame = CGRectMake(0, -2, 85, 62);
    if (isAttention == YES) {
        selectView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 100);
        [self alphaToOne];
    }else{
        selectView.frame = CGRectMake(0, -self.view.bounds.size.height, 320, self.view.bounds.size.height - 100);
         [self alphaToZero];
    }
    [UIView setAnimationDidStopSelector:@selector(animationIsStop)];
    [UIView commitAnimations];
}

-(void)animationIsStop{
    if (isAttention == YES) {
        self.title = @"添加关注航班";
        [btnImageView setImage:[UIImage imageNamed:@"icon_del_attention.png"]];
//        shade.hidden = NO;
        
    }else{
        self.title = @"已关注航班列表";
        selectView.hidden = YES;
//        shade.hidden = YES;
       
        [btnImageView setImage:[UIImage imageNamed:@"add_Attention_condition.png"]];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDidStopSelector:@selector(animationTwoIsStop)];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    btnImageView.frame = CGRectMake(0, 13, 85, 62);
    [UIView commitAnimations];
}
-(void)animationTwoIsStop{
    rightsuperView.userInteractionEnabled = YES;
}


#pragma mark - tableView代理

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return self.lookFlightArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    LookFlightConditionCell *cell = [myConditionListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"LookFlightConditionCell" owner:self options:nil];
        cell = self.lookCell;

        cell.bootImageView.backgroundColor = [UIColor whiteColor];

    }
    
    NSDictionary * dic = [self.lookFlightArr objectAtIndex:indexPath.row];
    
    cell.fno.text = [dic objectForKey:@"flightNum"];
    cell.company.text = [dic objectForKey:@"flightCompany"];
    cell.data.text = [dic objectForKey:@"deptDate"];
    cell.realTime.text = [dic objectForKey:@"deptTime"];
    cell.excepterTime.text = [dic objectForKey:@"arrTime"];
    cell.startAirPort.text = [dic objectForKey:@"deptAirport"];
    cell.endAirPort.text = [dic objectForKey:@"deptAirport"];
    cell.station.text = [dic objectForKey:@"flightState"];
    cell.closeBtn.tag = indexPath.row;
    [cell.closeBtn addTarget:self action:@selector(deleteLookFlight:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}


#pragma mark - 取消关注航班

-(void)deleteLookFlight:(UIButton *)btn
{
    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;
    
    NSDictionary * dic = [self.lookFlightArr objectAtIndex:btn.tag - 10000];
    
    btnTag = (btn.tag - 10000);
    NSLog(@"btn.tag : %d",btnTag);
    NSLog(@"在航班动态里边取消航班时候的取消条件 %@，%@，%@，%@，%@，%@，%@",[dic objectForKey:@"flightNum"],[dic objectForKey:@"deptDate"],[dic objectForKey:@"flightDepcode"],[dic objectForKey:@"flightArrcode"],[dic objectForKey:@"deptTime"],[dic objectForKey:@"arrTime"],[dic objectForKey:@"arrAirport"]);
    
    AttentionFlight * attention = [[AttentionFlight alloc] initWithMemberId:memberID
                                                               andorgSource:@"51YOU"
                                                                     andFno:[dic objectForKey:@"flightNum"]
                                                                   andFdate:[dic objectForKey:@"deptDate"]
                                                                     andDpt:[dic objectForKey:@"flightDepcode"]
                                                                     andArr:[dic objectForKey:@"flightArrcode"]
                                                                 andDptTime:[dic objectForKey:@"deptTime"]
                                                                 andArrTime:[dic objectForKey:@"arrTime"]
                                                                 andDptName:nil
                                                                 andArrName:nil
                                                                    andType:@"C"
                                                                  andSendTo:nil
                                                                 andMessage:nil
                                                                   andToken:hwID
                                                                  andSource:@"1"
                                                                    andHwId:hwID
                                                             andServiceCode:@"01"];
    


    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDelFlightData:) name:@"关注航班" object:nil];
    [attention lookFlightAttention];
    attention.delegate = self;

}

-(void)reloadConditionTableviewData{
    
    [myConditionListTableView reloadData];
}


#pragma mark - 改变位置
-(void)resetSendMessageBtnFrame{
    NSLog(@"//改变列表 并刷新数据");
    for (id obj in scrollview.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = obj;
            NSLog(@"imageView.tag = %d",imageView.tag);
            if (imageView.tag == 9999) {
                NSLog(@"remove formsuperview");
                [imageView removeFromSuperview];
            }
            
        }
    }
    NSLog(@"%d",[self.lookFlightArr count]);
    for (int i = 0; i < [self.lookFlightArr count]; i++) {
        UIImageView * addimageView = [self createBtnWithDic:[self.lookFlightArr objectAtIndex:i] index:i];
        NSLog(@"OK");
        [scrollview addSubview:addimageView];
    }
}


#pragma mark - 自定义UIImageView
-(UIImageView *)createBtnWithDic:(NSDictionary *)cusBtnDic index:(NSInteger)index{
    //myButton.tag = 1000 + index;
    //cancelBtn.tag = 10000 + index;
    UIImageView * bootView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_hangbandongtai.png"]]autorelease];
    bootView.tag = 9999;
    bootView.userInteractionEnabled = YES;
    bootView.frame = CGRectMake(10, 0 + index * 87 + index * 10, 300, 87);
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [myButton addTarget:self action:@selector(myDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    myButton.tag = 1000 + index;
    myButton.frame = CGRectMake(10, 33, 280, 55);
    
    //HU3456
    UILabel * codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 80, 20)];
    codeLabel.textColor = FONT_COLOR_BLUE;
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.text = [cusBtnDic objectForKey:@"flightNum"];
    codeLabel.font = [UIFont boldSystemFontOfSize:17];
    [bootView addSubview:codeLabel];
    [codeLabel release];
    
    
//    NSInteger daycount = 
    //海航  日期  今天
    NSString * myStr = [NSString stringWithFormat:@"%@ %@",[cusBtnDic objectForKey:@"flightCompany"],[cusBtnDic objectForKey:@"deptDate"]];
    UILabel * companyAndDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 12, 120, 15)];
    companyAndDateLabel.textColor = FONT_COLOR_GRAY;
    companyAndDateLabel.backgroundColor = [UIColor clearColor];
    companyAndDateLabel.font = [UIFont systemFontOfSize:12];
    companyAndDateLabel.text = myStr;
    [bootView addSubview:companyAndDateLabel];
    [companyAndDateLabel release];

    
    
    //取消关注btn
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(268, 5, 22, 22);
    [cancelBtn setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(deleteLookFlight:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 10000 + index;
    [bootView addSubview:cancelBtn];
    
    //实际imageview
    UIImageView * realImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_depart.png"]];
    realImageView.frame = CGRectMake(10, 6, 13, 13);
    [myButton addSubview:realImageView];
    [realImageView release];
    
    
    //预计imageView
    UIImageView * expectedArrIamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrive.png"]];
    expectedArrIamgeView.frame = CGRectMake(10, 27, 13, 13);
    [myButton addSubview:expectedArrIamgeView];
    [expectedArrIamgeView release];
    
    //实际
    UILabel * reLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, 6, 28, 15)];
    reLabel.text = @"实际";
    reLabel.backgroundColor = [UIColor clearColor];
    reLabel.textColor = FONT_COLOR_DEEP_GRAY;
    reLabel.font = [UIFont systemFontOfSize:12];
    [myButton addSubview:reLabel];
    [reLabel release];
    
    //预计
    UILabel * expectedLable = [[UILabel alloc]initWithFrame:CGRectMake(27, 25, 28, 15)];
    expectedLable.text = @"预计";
    expectedLable.backgroundColor = [UIColor clearColor];
    expectedLable.textColor = FONT_COLOR_DEEP_GRAY;
    expectedLable.font = [UIFont systemFontOfSize:12];
    [myButton addSubview:expectedLable];
    [expectedLable release];
    
    //实际时间
    UILabel * deptTime = [[UILabel alloc]initWithFrame:CGRectMake(65, 6, 50, 15)];
    deptTime.text = [cusBtnDic objectForKey:@"deptTime"];
    deptTime.backgroundColor = [UIColor clearColor];
    deptTime.textAlignment = NSTextAlignmentLeft;
    deptTime.font = [UIFont boldSystemFontOfSize:15];
    deptTime.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:deptTime];
    [deptTime release];
    
    //预计到达时间
    UILabel * arrTime = [[UILabel alloc]initWithFrame:CGRectMake(65, 25, 50, 15)];
    arrTime.text = [cusBtnDic objectForKey:@"expectedArrTime"];
    arrTime.textAlignment = NSTextAlignmentLeft;
    arrTime.backgroundColor = [UIColor clearColor];
    arrTime.font = [UIFont boldSystemFontOfSize:15];
    arrTime.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:arrTime];
    [arrTime release];
    
    //起飞机场
    UILabel * deptAirPort = [[UILabel alloc]initWithFrame:CGRectMake(125, 6, 60, 15)];
    deptAirPort.text = [cusBtnDic objectForKey:@"deptAirport"];
    deptAirPort.backgroundColor = [UIColor clearColor];
    deptAirPort.textAlignment = NSTextAlignmentLeft;
    deptAirPort.font = [UIFont systemFontOfSize:14];
    deptAirPort.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:deptAirPort];
    [deptAirPort release];
    
    //到达机场
    UILabel * arrAirPort = [[UILabel alloc]initWithFrame:CGRectMake(125, 25, 60, 15)];
    arrAirPort.text = [cusBtnDic objectForKey:@"arrAirport"];
    arrAirPort.backgroundColor = [UIColor clearColor];
    arrAirPort.textAlignment = NSTextAlignmentLeft;
    arrAirPort.font = [UIFont systemFontOfSize:14];
    arrAirPort.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:arrAirPort];
    [arrAirPort release];
    
    //状态
    UILabel * planeState = [[UILabel alloc]initWithFrame:CGRectMake(210, 14, 50, 20)];
    planeState.text = [cusBtnDic objectForKey:@"flightState"];
    planeState.backgroundColor = [UIColor clearColor];
    planeState.textAlignment = NSTextAlignmentLeft;
    planeState.font = [UIFont boldSystemFontOfSize:20];
    planeState.textColor = FONT_Blue_Color;
    [myButton addSubview:planeState];
    [planeState release];
    
    
    //右边箭头图片
    UIImageView * accImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    accImageView.frame = CGRectMake(260, 17, 9, 12);
    [myButton addSubview:accImageView];
    [accImageView release];
    
    [bootView addSubview:myButton];
    return bootView;
}





-(void)receiveDelFlightData:(NSNotification *)not
{
    NSDictionary * array = [[not userInfo] objectForKey:@"arr"];
    NSString * string = [array objectForKey:@"message"];
    
    NSLog(@"-----%@",array);
    
    if (string == @"") {
        //重新获取关注列表
        [self getListData];
        [self resetSendMessageBtnFrame];
//        [myConditionListTableView reloadData];
        
        NSLog(@"取消航班成功");
    }
    
    else{
        NSLog(@"取消航班失败");
    
    }
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(void)alphaToZero{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    shade.alpha = 0;
    
    [UIView commitAnimations];
    
}
-(void)alphaToOne{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    shade.alpha = .5;
    
    [UIView commitAnimations];
}
#pragma mark - 详情btn点击事件
-(void)myDetailBtnClick:(UIButton *)btn{
    NSLog(@"myDetailBtnClick");
    DetailFlightConditionViewController * detail = [[DetailFlightConditionViewController alloc]init];
    NSDictionary * dic = [self.lookFlightArr objectAtIndex:btn.tag - 1000];
    detail.dic = dic;
    detail.isAttentionFlight = NO;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 取消关注点击事件(其他地方已实现，这个不用了)
-(void)cancelBtnClick:(UIButton *)btn{
    NSLog(@"cancelBtnClick");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   
    NSLog(@"收键盘");
    [self.flightNumber resignFirstResponder];
    
}

-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
