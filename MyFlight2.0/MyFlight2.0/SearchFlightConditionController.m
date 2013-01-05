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

    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationItem.title = @"已关注航班列表";
    selectView = [[UIView alloc]initWithFrame:CGRectMake(0,-[[UIScreen mainScreen]bounds].size.height, 320, [[UIScreen mainScreen]bounds].size.height)];
    selectView.backgroundColor = BACKGROUND_COLOR;
    isAttention = NO;
    
    
    
    //航班动态列表,上面放一个tableview,动画也放这上面
    myConditionListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)];
    myConditionListView.backgroundColor = FOREGROUND_COLOR;
    myConditionListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 320, [[UIScreen mainScreen]bounds].size.height - 64-30)];
    myConditionListTableView.backgroundColor = FOREGROUND_COLOR;
    myConditionListTableView.dataSource = self;
    myConditionListTableView.delegate = self;
//    [myConditionListView addSubview:myConditionListTableView]; //在btn之后加
    myConditionListTableView.hidden = YES;
    [self.view addSubview:myConditionListView];

   
    //动画
//    animationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height/2 - 160 - 32, 320, 320)];
    animationView = [[UIImageView alloc]initWithFrame:CGRectMake(10,40 , 300, 300)];
    NSArray * animationImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"dong1.png"],[UIImage imageNamed:@"dong2.png"], nil];
    animationView.animationImages = animationImageArray;
    animationView.animationDuration = .35;
    animationView.hidden = YES;
//    [myConditionListView addSubview:animationView];
    animationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [animationBtn addSubview:animationView];
    animationBtn.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height);
    [animationBtn addTarget:self action:@selector(attentionTapEvent) forControlEvents:UIControlEventTouchUpInside];
    [myConditionListView addSubview:animationBtn];
    [myConditionListView addSubview:myConditionListTableView];
    
    
    //遮罩
    shade = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height)];
    shade.backgroundColor = [UIColor blackColor];
    shade.alpha = 0.5;
    shade.userInteractionEnabled = NO;
    //[self.view addSubview:shade];
    
    
    
   
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
        myConditionListTableView.hidden = NO;
        [myConditionListTableView reloadData];
    }else{
        animationView.hidden = NO;
        myConditionListTableView.hidden = YES;
        [animationView startAnimating];
    }
    [myConditionListTableView reloadData];

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
        selectView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
    }else{
        selectView.frame = CGRectMake(0, -self.view.bounds.size.height, 320, self.view.bounds.size.height);
    }
    [UIView setAnimationDidStopSelector:@selector(animationIsStop)];
    [UIView commitAnimations];
}

-(void)animationIsStop{
    if (isAttention == YES) {
        self.title = @"添加关注航班";
        [btnImageView setImage:[UIImage imageNamed:@"icon_del_attention.png"]];
    }else{
        self.title = @"已关注航班列表";
        selectView.hidden = YES;
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
//        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input.png"]];
//        imageView.alpha = 0.5;
//        imageView.frame = CGRectMake(10, 35, 300, 50);
//        [cell addSubview:imageView];
//        [imageView release];
        cell.bootImageView.backgroundColor = [UIColor whiteColor];
//        cell.bootImageView.frame = CGRectMake(10, 35, 300, 50);
//        [cell.bootImageView.layer  :4];
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
    
    NSDictionary * dic = [self.lookFlightArr objectAtIndex:btn.tag];
    
    btnTag = btn.tag;
    
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

-(void)receiveDelFlightData:(NSNotification *)not
{
    NSDictionary * array = [[not userInfo] objectForKey:@"arr"];
    NSString * string = [array objectForKey:@"message"];
    
    NSLog(@"-----%@",array);
    
    if (string == @"") {
        //重新获取关注列表
        [self getListData];
//        [myConditionListTableView reloadData];
        
        
        NSLog(@"取消航班成功");
    }
    
    else{
        NSLog(@"取消航班失败");
    }
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   
    NSLog(@"收键盘");
    [self.flightNumber resignFirstResponder];
    
}


@end
