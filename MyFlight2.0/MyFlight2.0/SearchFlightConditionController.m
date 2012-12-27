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
#import "AttentionFlight.h"
@interface SearchFlightConditionController ()

{
    int btnTag;  // 判断取消关注的是哪一个
}
@end

@implementation SearchFlightConditionController
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
    selectView = [[UIView alloc]initWithFrame:CGRectMake(0,-self.view.bounds.size.height, 320, self.view.bounds.size.height)];
    selectView.backgroundColor = BACKGROUND_COLOR;
    isAttention = NO;
    
    
    
    //航班动态列表
    myConditionListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    myConditionListView.backgroundColor = [UIColor blackColor];
    myConditionListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    myConditionListTableView.backgroundColor = FOREGROUND_COLOR;
    myConditionListTableView.dataSource = self;
    myConditionListTableView.delegate = self;
    [myConditionListView addSubview:myConditionListTableView];
    [self.view addSubview:myConditionListView];
    
    //遮罩
    shade = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    shade.backgroundColor = [UIColor blackColor];
    shade.alpha = 0.5;
    shade.userInteractionEnabled = NO;
    //[self.view addSubview:shade];
    
    
    
   
    //定制导航右键
    rightsuperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 72)];
    btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 85, 62)];
    [btnImageView setImage:[UIImage imageNamed:@"add_Attention.png"]];
    [rightsuperView addSubview:btnImageView];
    UITapGestureRecognizer * attentionTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(attentionTapEvent:)];
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
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d-%2d-%2d",year,month,day];
    [self.time setText:nsDateString];
    [self.flightTimeByNumber setText:nsDateString];

    [dateformatter release];
    
    _lookFlightArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    [self getListData];
    
    
    [self.view addSubview:selectView];
    // Do any additional setup after loading the view from its nib.
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


- (IBAction)searchFligth:(id)sender {
    if (mySegmentController.selectedIndex == 0) {

        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:nil fdate:nil dpt:startAirPortCode arr:arrAirPortCode hwld:nil];
        ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
        show.searchCondition = search;
        
        [self.navigationController pushViewController:show animated:YES];
        [search release];
        [show release];
    }else {
        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:self.flightNumber.text fdate:self.flightTimeByNumber.text dpt:nil arr:nil hwld:nil];
        ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
        show.searchCondition = search;
        [self.navigationController pushViewController:show animated:YES];
        [search release];
        [show release];
    }
    

}

- (IBAction)chooseStartAirPort:(id)sender {
    
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

-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    if (arg.selectedIndex == 1) {
        /*
         |a    b    0|
         
         |c    d    0|
         
         |tx   ty   1|
         */
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];

        CGAffineTransform moveTo = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(-320, 0);
        self.selectedByAirPort.layer.affineTransform = moveTo;
        self.selectedByDate.layer.affineTransform = moveFrom;
        [UIView commitAnimations];
        
    }else if (arg.selectedIndex == 0){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        CGAffineTransform moveTo1 = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom1 = CGAffineTransformMakeTranslation(0, 0);
        self.selectedByAirPort.layer.affineTransform = moveFrom1;
        self.selectedByDate.layer.affineTransform = moveTo1;
        [UIView commitAnimations];
    }
}


- (IBAction)returnClicked:(id)sender {
    [self.flightNumber resignFirstResponder];
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"获得已经关注航班信息" object:nil];
    
    [flight getAttentionFlight];
}

-(void)receive:(NSNotification *) not
{

    self.lookFlightArr = [[not userInfo] objectForKey:@"arr"];
    NSLog(@"%@",self.lookFlightArr);

    [myConditionListTableView reloadData];

}
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


-(void)attentionTapEvent:(UITapGestureRecognizer *)tap{
    isAttention = !isAttention;
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
        [btnImageView setImage:[UIImage imageNamed:@"add_Attention.png"]];
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
        
    }
    
    NSDictionary * dic = [self.lookFlightArr objectAtIndex:indexPath.row];
    
    cell.fno.text = [dic objectForKey:@"flightNum"];
    cell.company.text = [dic objectForKey:@"flightCompany"];
    cell.data.text = [dic objectForKey:@"deptDate"];
   // cell.today = [dic ]   // 今天，明天，昨天 
    cell.realTime.text = [dic objectForKey:@"realDeptTime"];
    cell.excepterTime.text = [dic objectForKey:@"expectedArrTime"];
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
    


    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDelFlightData:) name:@"关注航班" object:nil];
    [attention lookFlightAttention];
    

}
-(void)receiveDelFlightData:(NSNotification *)not
{
    NSDictionary * array = [[not userInfo] objectForKey:@"arr"];
    NSString * string = [array objectForKey:@"message"];
    
    NSLog(@"-----%@",array);
    
    if (string == @"") {
        
//        [self.lookFlightArr removeObjectAtIndex:btnTag];
//        [myConditionListTableView reloadData];
        
        NSLog(@"取消航班成功");
    }
    
    else{
        NSLog(@"取消航班失败");
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
@end
