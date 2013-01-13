//
//  TravelTrafficViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TravelTrafficViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "UIButton+BackButton.h"

@interface TravelTrafficViewController ()

@end

@implementation TravelTrafficViewController
@synthesize airPortCode = _airPortCode;
@synthesize airPortName = _airPortName;
@synthesize subAirPortData = _subAirPortData;
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
    //tableView x=0 y=64
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;

    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    customViewIsCoach = YES;
#pragma mark - cell高Array
    coachCellHeightArray = [[NSMutableArray alloc]initWithCapacity:0];
    coachCellHeightArray1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    subwayCellHeightArray = [[NSMutableArray alloc]initWithCapacity:0];
    subwayCellHeightArray1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    taxiCellHeightArray = [[NSMutableArray alloc]initWithCapacity:0];
    taxiCellHeightArray1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    
    rightRect = CGRectMake(320, 0, 320, [[UIScreen mainScreen]bounds].size.height - 30 - 44 - 20);
    centerRect = CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height - 30 - 44 - 20);
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, [[UIScreen mainScreen]bounds].size.height - 50 - 44 - 20)];
    [self.view addSubview:contentView];
    
    coachTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, contentView.bounds.size.height) style:UITableViewStylePlain];
    coachTableView.separatorColor = [UIColor clearColor];
    coachTableView.delegate = self;
    coachTableView.dataSource = self;
    coachTableView.hidden = NO;

    
    subwayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, contentView.bounds.size.height) style:UITableViewStylePlain];
    subwayTableView.separatorColor = [UIColor clearColor];
    subwayTableView.delegate = self;
    subwayTableView.dataSource = self;
    subwayTableView.hidden = NO;
    
    
    taxiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, contentView.bounds.size.height) style:UITableViewStylePlain];
    taxiTableView.separatorColor = [UIColor clearColor];
    taxiTableView.delegate = self;
    taxiTableView.dataSource = self;
    taxiTableView.hidden = NO;


#pragma mark - 最后方案
#pragma mark - begin
    contentTaxiView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, contentView.bounds.size.height)];
    contentTaxiView.backgroundColor = [UIColor blueColor];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 280, 27)];
    
    [contentTaxiView addSubview:label1];
    
//    UITextView * textView = [UITextView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
   
#pragma mark - 最后方案
#pragma mark - over
    
    
    //将tableview添加进去
//    [contentView addSubview:taxiTableView];
//    [contentView addSubview:subwayTableView];
    [contentView addSubview:coachTableView];

    currTableView = coachTableView;
    
#pragma mark - 3个tableView背景色
    coachTableView.backgroundColor = BACKGROUND_COLOR;
    subwayTableView.backgroundColor = BACKGROUND_COLOR;
//    taxiTableView.backgroundColor = BACKGROUND_COLOR;
    taxiTableView.backgroundColor = [UIColor blueColor];
    
    
    //导航栏view
    UIView * navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 210, 44)];
    
    
    navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont systemFontOfSize:14];
    navLabel.textAlignment = UITextAlignmentRight;
    
    navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
    
    navImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle_white_down.png"]];
    navImageView.frame = CGRectMake(135, 17, 10, 10);
    [navgationView addSubview:navImageView];
    [navgationView addSubview:navLabel];
    self.navigationItem.titleView = navgationView;
    UITapGestureRecognizer * navTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(navTapClick:)];
    navTap.numberOfTapsRequired = 1;
    navTap.numberOfTouchesRequired = 1;
    [navgationView addGestureRecognizer:navTap];
    [navTap release];
    
    //默认方向 0，去机场
    orientation = 0;
    orientationCoach = 0;
    orientationSubway = 0;
    orientationTaxi = 0;
    //默认大巴
    trfficType = 0;
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"机场大巴",@"机场快轨",@"出租车", nil];
    segmented = [[SVSegmentedControl alloc]initWithSectionTitles:titleNameArray];
    [titleNameArray release];
    segmented.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    segmented.textColor = myFirstColor;
    segmented.center = CGPointMake(160, 23);
    
    //segmented.thumb.backgroundImage = [UIImage imageNamed:@"tab.png"];
    
    segmented.height = 38;
    segmented.LKWidth = 100;
    
    segmented.thumb.textColor = mySceColor;
    segmented.thumb.tintColor = [UIColor whiteColor];
    segmented.thumb.textShadowColor = [UIColor clearColor];
    segmented.crossFadeLabelsOnDrag = YES;
   
    segmented.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    
    [segmented addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];
    
    //第一次请求
    [self getData1];
    
    
  
}

#pragma mark - segment值改变
-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    if (segmented.selectedIndex == 0) {
        trfficType = 0;//机场大巴
        if (customViewIsCoach == NO) {
            [taxiTableView removeFromSuperview];
            [contentView addSubview:coachTableView];
        }
        customViewIsCoach = YES;
        
        if (orientationCoach == 1) {
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
        }else{
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
        }

    }else if (segmented.selectedIndex == 1){
        trfficType = 2;//机场快轨
        if (customViewIsCoach == NO) {
            [taxiTableView removeFromSuperview];
            [contentView addSubview:coachTableView];
        }
        customViewIsCoach = YES;
        //更改nav的标题
        if (orientationSubway == 1) {
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
        }else{
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
        }

    }else if (segmented.selectedIndex == 2){
        trfficType = 1;//出租车
        if (customViewIsCoach == YES) {
            [coachTableView removeFromSuperview];
            [contentView addSubview:contentTaxiView];
        }
        customViewIsCoach = NO;
        //更改nav的标题
        if (orientationTaxi == 1) {
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
        }else{
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
        }
        
        
    }
    
    
    //根据选择的方式发送请求
    if (segmented.selectedIndex == 0) {
        if (orientationCoach == 0) {
            if (coachDic == nil) {
                [self getData1];
            }else{
                [coachTableView reloadData];
            }
        }else{
            if (coachDicFromAirPort == nil) {
                [self getData2];
            }else{
                [coachTableView reloadData];
            }
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            if (subwayDic == nil) {
                [self getData3];
            }else{
//                [subwayTableView reloadData];
                [coachTableView reloadData];
            }
        }else{
            if (subwayDicFromAirPort == nil) {
                [self getData4];
            }else{
//                [subwayTableView reloadData];
                [coachTableView reloadData];
            }
        }
        
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if (taxiDic == nil) {
                [self getData5];
            }else{
                [self fillTaxiData1];
            }
        }else{
            if (taxiDicFromAirPort == nil) {
                [self getData6];
            }else{
                [self fillTaxiData2];
            }
        }
        
    }
}

#pragma mark - 填充taxi数据
-(void)fillTaxiData1{
    taxiRuleTitleLast.text = [[sectionCountTaxi objectAtIndex:0]objectForKey:@"lineName"];
    taxiRuleLabelLast.text =  [[[sectionCountTaxi objectAtIndex:0]objectForKey:@"lineStops"]stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
    taxiLineNameLast.text = [[sectionCountTaxi objectAtIndex:1]objectForKey:@"lineName"];
    aboutRangeLast.text = [[sectionCountTaxi objectAtIndex:1]objectForKey:@"lineStops"];
    taxiPriceLast.text = [[sectionCountTaxi objectAtIndex:1]objectForKey:@"lineFares"];
    taxiPlaceLast.text = [[sectionCountTaxi objectAtIndex:2]objectForKey:@"lineStops"];
}
-(void)fillTaxiData2{
     taxiRuleTitleLast.text = [[sectionCountTaxiFromAirPort objectAtIndex:0]objectForKey:@"lineName"];
    taxiRuleLabelLast.text =  [[[sectionCountTaxiFromAirPort objectAtIndex:0]objectForKey:@"lineStops"]stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
    taxiLineNameLast.text = [[sectionCountTaxiFromAirPort objectAtIndex:1]objectForKey:@"lineName"];
    aboutRangeLast.text = [[sectionCountTaxiFromAirPort objectAtIndex:1]objectForKey:@"lineStops"];
    taxiPriceLast.text = [[sectionCountTaxiFromAirPort objectAtIndex:1]objectForKey:@"lineFares"];
    taxiPlaceLast.text = [[sectionCountTaxiFromAirPort objectAtIndex:2]objectForKey:@"lineStops"];
}
#pragma mark -
-(void)getDataWithType:(NSInteger)trafficType sendOrientation:(NSInteger)sendOrientation{
    
}
-(void)getData1{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    
//    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"0"] forKey:@"TrafficType"];

    [request setPostValue:[NSString stringWithFormat:@"0"] forKey:@"DrivingDirection"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"coachDic :%@",str);

        coachDic = [str objectFromJSONString];
        sectionCountCoach = [[NSArray alloc]initWithArray:[coachDic objectForKey:@"TrafficTools"]];
        NSLog(@"sectionCountCoach=== %d",[sectionCountCoach count]);
        
        
        
        [coachCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountCoach count]; i++) {
            NSString * s = [[sectionCountCoach objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [coachCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        
        
        [coachTableView reloadData];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)getData2{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"0"] forKey:@"TrafficType"];  //0、大巴，1、taxi  2、快轨
    [request setPostValue:[NSString stringWithFormat:@"1"] forKey:@"DrivingDirection"]; //0、去机场    1、去市区
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"coachDicFromAirPort :%@",str);
        coachDicFromAirPort = [str objectFromJSONString];
        sectionCountCoachFromAirPort = [[NSArray alloc]initWithArray:[coachDicFromAirPort objectForKey:@"TrafficTools"]];
        NSLog(@"sectionCountCoachFromAirPort=== %d",[sectionCountCoachFromAirPort count]);
        
        
        [coachCellHeightArray1 removeAllObjects];
        for (int i = 0; i < [sectionCountCoachFromAirPort count]; i++) {
            NSString * s = [[sectionCountCoachFromAirPort objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [coachCellHeightArray1 addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
        
        
        [coachTableView reloadData];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)getData3{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"2"] forKey:@"TrafficType"];  //0、大巴，1、taxi  2、快轨
    [request setPostValue:[NSString stringWithFormat:@"0"] forKey:@"DrivingDirection"]; //0、去机场    1、去市区
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"subwayDic :%@",str);
        subwayDic = [str objectFromJSONString];
        sectionCountSubway = [[NSArray alloc]initWithArray:[subwayDic objectForKey:@"TrafficTools"]];
      
        
        [subwayCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountSubway count]; i++) {
            NSString * s = [[sectionCountSubway objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [subwayCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
        
        
//        [subwayTableView reloadData];
        [coachTableView reloadData];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)getData4{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"2"] forKey:@"TrafficType"];  //0、大巴，1、taxi  2、快轨
    [request setPostValue:[NSString stringWithFormat:@"1"] forKey:@"DrivingDirection"]; //0、去机场    1、去市区
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"subwayDicFromAirPort :%@",str);
        subwayDicFromAirPort = [str objectFromJSONString];
        sectionCountSubwayFromAirPort = [[NSArray alloc]initWithArray:[subwayDicFromAirPort objectForKey:@"TrafficTools"]];
        
     
        
        [subwayCellHeightArray1 removeAllObjects];
        for (int i = 0; i < [sectionCountSubwayFromAirPort count]; i++) {
            NSString * s = [[sectionCountSubwayFromAirPort objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [subwayCellHeightArray1 addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        
//        [subwayTableView reloadData];
        [coachTableView reloadData];
        
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)getData5{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"1"] forKey:@"TrafficType"];  //0、大巴，1、taxi  2、快轨
    [request setPostValue:[NSString stringWithFormat:@"0"] forKey:@"DrivingDirection"]; //0、去机场    1、去市区
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
       
        NSString * temp1= [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"aaaaa"];
        NSString * temp2= [temp1 stringByReplacingOccurrencesOfString:@"\r" withString:@"aaaaa"];
        NSString * temp3= [temp2 stringByReplacingOccurrencesOfString:@"\n" withString:@"aaaaa"];
        taxiDic = [temp3 objectFromJSONString];
         NSLog(@"taxiDic :%@",temp3);
        sectionCountTaxi = [[NSArray alloc]initWithArray:[taxiDic objectForKey:@"TrafficTools"]];
        NSLog(@"[sectionCountTaxi count]  : %d",[sectionCountTaxi count]);
     
        
        [taxiCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountTaxi count]; i++) {
            NSString * s = [[sectionCountTaxi objectAtIndex:i]objectForKey:@"lineStops"];
            NSString * tempS = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [tempS sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [taxiCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        [self fillTaxiData1];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)getData6{
    NSString * urlStr = [NSString stringWithFormat:@"%@/3gWeb/api/traffic.jsp",BASE_DOMAIN_URL];
    NSURL * url = [NSURL URLWithString:urlStr];
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:[NSString stringWithFormat:@"1"] forKey:@"TrafficType"];  //0、大巴，1、taxi  2、快轨
    [request setPostValue:[NSString stringWithFormat:@"1"] forKey:@"DrivingDirection"]; //0、去机场    1、去市区
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
//        NSLog(@"taxiDicFromAirPort :%@",str);
        NSString * temp1= [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"aaaaa"];
        NSString * temp2= [temp1 stringByReplacingOccurrencesOfString:@"\r" withString:@"aaaaa"];
        NSString * temp3= [temp2 stringByReplacingOccurrencesOfString:@"\n" withString:@"aaaaa"];
        taxiDicFromAirPort = [temp3 objectFromJSONString];
        sectionCountTaxiFromAirPort = [[NSArray alloc]initWithArray:[taxiDicFromAirPort objectForKey:@"TrafficTools"]];
        
        
        
        [taxiCellHeightArray1 removeAllObjects];
        for (int i = 0; i < [sectionCountTaxiFromAirPort count]; i++) {
            NSString * s = [[sectionCountTaxiFromAirPort objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [taxiCellHeightArray1 addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
        
        [self fillTaxiData2];
       
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}
#pragma mark - getData over
#pragma mark - 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 导航栏点击事件
-(void)navTapClick:(UITapGestureRecognizer *)navTap{
    NSLog(@"navTapClick:");
    
    CCLog(@"当前选择的是 %d",segmented.selectedIndex);
    if(segmented.selectedIndex == 0){
        //换成去市区
        if (orientationCoach == 0) {
            orientationCoach = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            if (sectionCountCoachFromAirPort == nil) {
                [self getData2];
            }else{
                [coachTableView reloadData];
            }
        }else{
            orientationCoach = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            if (sectionCountCoach == nil) {
                [self getData1];
            }else{
                [coachTableView reloadData];
            }
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            orientationSubway = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            if (sectionCountSubwayFromAirPort == nil) {
                [self getData4];
            }else{
//                [subwayTableView reloadData];
                [coachTableView reloadData];
            }

        }else{
            orientationSubway = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            if (sectionCountSubway == nil) {
                [self getData3];
            }else{
//                [subwayTableView reloadData];
                [coachTableView reloadData];
            }
        }
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            orientationTaxi = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            if (sectionCountTaxiFromAirPort == nil) {
                [self getData6];
            }else{
                [self fillTaxiData1];
            }
        }else{
            orientationTaxi = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            if (sectionCountTaxi == nil) {
                [self getData5];
            }else{
                [self fillTaxiData2];
            }
        }
    }
}



#pragma mark - tableView代理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == coachTableView) {
        if (orientationCoach == 0) {
            return [sectionCountCoach count];
        }else{
            return [sectionCountCoachFromAirPort count];
        }
    }
        return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if (tableView == coachTableView) {
            cell.showsReorderControl = YES;
            
            UILabel * firstBusLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 60, 21)];
            firstBusLable.font = [UIFont systemFontOfSize:12];
            firstBusLable.textAlignment = NSTextAlignmentRight;
            firstBusLable.text = @"首班车:";
            firstBusLable.backgroundColor = [UIColor clearColor];
            firstBusLable.textColor = FONT_COLOR_GRAY;
            [cell addSubview:firstBusLable];
            [firstBusLable release];
            
            UILabel * lastBusLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 20, 50, 21)];
            lastBusLabel.font = [UIFont systemFontOfSize:12];
            lastBusLabel.textColor = FONT_COLOR_GRAY;
            lastBusLabel.text = @"末班车:";
            lastBusLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview:lastBusLabel];
            [lastBusLabel release];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 20, 9, 12)];
            [imageView setImage:[UIImage imageNamed:@"icon_arrowhead_.png"]];
            [cell addSubview:imageView];
            [imageView release];
            
            UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
            imageView1.backgroundColor = [UIColor whiteColor];
            [cell addSubview:imageView1];
            [imageView1 release];
            
            UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42, 320, 1)];
            imageView.backgroundColor = LINE_COLOR;
            [cell addSubview:imageView2];
            [imageView2 release];
            
            
            lineName = [[UILabel alloc]initWithFrame:CGRectMake(70, 4, 160, 21)];
            lineName.textAlignment = NSTextAlignmentLeft;
            lineName.backgroundColor = [UIColor clearColor];
            lineName.font = [UIFont systemFontOfSize:14];
            lineName.textColor = FONT_COLOR_GRAY;
            [cell.contentView addSubview:lineName];
            [lineName release];
            
            firstBusTime = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 58, 21)];
            firstBusTime.font = [UIFont systemFontOfSize:12];
            firstBusTime.textAlignment = NSTextAlignmentLeft;
            firstBusTime.backgroundColor = [UIColor clearColor];
            firstBusTime.textColor = FONT_COLOR_GRAY;
            [cell addSubview:firstBusTime];
            [firstBusTime release];
            
            
            lastBusTime = [[UILabel alloc]initWithFrame:CGRectMake(156, 20, 68, 21)];
            lastBusTime.font = [UIFont systemFontOfSize:12];
            lastBusTime.textAlignment = NSTextAlignmentLeft;
            lastBusTime.backgroundColor = [UIColor clearColor];
            lastBusTime.textColor = FONT_COLOR_GRAY;
            [cell addSubview:lastBusTime];
            
            lineIndex = [[UILabel alloc]initWithFrame:CGRectMake(5, 4, 60, 21)];
            lineIndex.textColor = FONT_COLOR_GRAY;
            lineIndex.textAlignment = NSTextAlignmentRight;
            lineIndex.backgroundColor = [UIColor clearColor];
            lineIndex.font = [UIFont systemFontOfSize:14];
            [cell addSubview:lineIndex];
            
            lineFares = [[UILabel alloc]initWithFrame:CGRectMake(253, 10, 42, 21)];
            lineFares.font = [UIFont systemFontOfSize:17];
            lineFares.textAlignment = NSTextAlignmentLeft;
            lineFares.textColor = FONT_COLOR_RED;
            lineFares.backgroundColor = [UIColor clearColor];
            [cell addSubview:lineFares];
            [lineFares release];

        }
                
    }
    
    if (segmented.selectedIndex == 0) {
        if (orientationCoach == 0) {
            if (sectionCountCoach) {
                NSLog(@"00");
                lineName.text = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                NSLog(@"lineName.text:%@",lineName.text);
                firstBusTime.text = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                lastBusTime.text = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                lineIndex.text = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                lineFares.text = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }
        }else{
            if (sectionCountCoachFromAirPort) {
                NSLog(@"01");
                lineName.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                NSLog(@"lineName.text:%@",lineName.text);
                firstBusTime.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                lastBusTime.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                lineIndex.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                lineFares.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }
        }
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            if (sectionCountSubway) {
                NSLog(@"10");
                lineName.text = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                firstBusTime.text = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                lastBusTime.text = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                lineIndex.text = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                lineFares.text = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }
        }else{
            if (sectionCountSubwayFromAirPort) {
                NSLog(@"11");
                lineName.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                firstBusTime.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                lastBusTime.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                lineIndex.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                lineFares.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }
        }
    }
       

    return cell;
}


#pragma mark - tableViewCell over
#pragma mark -

//-(void)refreshGetData{
//    [self getData];
//}
-(void)fillData:(NSDictionary *)dic{
    
}




-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc{

    [coachTableView release];
    [subwayTableView release];
    [taxiTableView release];
    
    [navImageView release];
    [navgaitionLabel release];
    [navImageView release];
    self.airPortName = nil;
    [super dealloc];
}
@end
