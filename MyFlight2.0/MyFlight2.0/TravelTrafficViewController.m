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
    
    //将tableview添加进去
    [contentView addSubview:taxiTableView];
    [contentView addSubview:subwayTableView];
    [contentView addSubview:coachTableView];

    currTableView = coachTableView;
    
#pragma mark - 3个tableView背景色
    coachTableView.backgroundColor = BACKGROUND_COLOR;
    subwayTableView.backgroundColor = BACKGROUND_COLOR;
    taxiTableView.backgroundColor = BACKGROUND_COLOR;
    
    
    //导航栏view
    UIView * navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    
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
        coachTableView.hidden = NO;
        if (currTableView != coachTableView) {
            [UIView transitionFromView:currTableView toView:coachTableView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
                currTableView = coachTableView;
                [coachTableView reloadData];
                NSLog(@"current coachTableView");
            }];
        }
       
//        [coachTableView setFrame:centerRect];
//        
//        [subwayTableView setFrame:rightRect];
        //更改nav的标题
        if (orientationCoach == 1) {
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
        }else{
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
        }

    }else if (segmented.selectedIndex == 1){
        trfficType = 2;//机场快轨
        if (currTableView != subwayTableView) {
            [UIView transitionFromView:currTableView toView:subwayTableView duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
                currTableView = subwayTableView;
                [subwayTableView reloadData];
                NSLog(@"current subwayTableView");
            }];
        }
        //更改nav的标题
        if (orientationSubway == 1) {
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
        }else{
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
        }

    }else if (segmented.selectedIndex == 2){
        trfficType = 1;//出租车
        if (currTableView != taxiTableView) {
            [UIView transitionFromView:currTableView toView:taxiTableView duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
                currTableView = taxiTableView;
                [taxiTableView reloadData];
                 NSLog(@"current taxiTableView");
            }];
        }
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
                [subwayTableView reloadData];
            }
        }else{
            if (subwayDicFromAirPort == nil) {
                [self getData4];
            }else{
                [subwayTableView reloadData];
            }
        }
        
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if (taxiDic == nil) {
                [self getData5];
            }else{
                [taxiTableView reloadData];
            }
        }else{
            if (taxiDicFromAirPort == nil) {
                [self getData6];
            }else{
                [taxiTableView reloadData];
            }
        }
        
    }
}

-(void)getDataWithType:(NSInteger)trafficType sendOrientation:(NSInteger)sendOrientation{
    
}
-(void)getData1{
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCountCoach count];
        flagOpenOrCloseCoach = (BOOL *)malloc(size);
        memset(flagOpenOrCloseCoach, NO, size);
        
        
        
        
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
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCountCoachFromAirPort count];
        flagOpenOrCloseCoachFromAirPort = (BOOL *)malloc(size);
        memset(flagOpenOrCloseCoachFromAirPort, NO, size);
        
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
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCountSubway count];
        flagOpenOrCloseSubway = (BOOL *)malloc(size);
        memset(flagOpenOrCloseSubway, NO, size);
        
        [subwayCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountSubway count]; i++) {
            NSString * s = [[sectionCountSubway objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [subwayCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
        
        
        [subwayTableView reloadData];
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
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        
        int size = sizeof(BOOL *) * [sectionCountSubwayFromAirPort count];
        flagOpenOrCloseSubwayFromAirPort = (BOOL *)malloc(size);
        memset(flagOpenOrCloseSubwayFromAirPort,NO,size);
        
        [subwayCellHeightArray1 removeAllObjects];
        for (int i = 0; i < [sectionCountSubwayFromAirPort count]; i++) {
            NSString * s = [[sectionCountSubwayFromAirPort objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [subwayCellHeightArray1 addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        
        [subwayTableView reloadData];
        
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
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCountTaxi count];
        flagOpenOrCloseTaxi = (BOOL *)malloc(size);
        memset(flagOpenOrCloseTaxi, NO, size);
        
        [taxiCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountTaxi count]; i++) {
            NSString * s = [[sectionCountTaxi objectAtIndex:i]objectForKey:@"lineStops"];
            NSString * tempS = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [tempS sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [taxiCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        
        [taxiTableView reloadData];
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
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
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
        NSLog(@"taxiDicFromAirPort :%@",str);
        taxiDicFromAirPort = [str objectFromJSONString];
        sectionCountTaxiFromAirPort = [[NSArray alloc]initWithArray:[taxiDicFromAirPort objectForKey:@"TrafficTools"]];
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCountTaxiFromAirPort count];
        flagOpenOrCloseTaxiFromAirPort = (BOOL *)malloc(size);
        memset(flagOpenOrCloseTaxiFromAirPort, NO, size);
        
        
        [taxiCellHeightArray1 removeAllObjects];
        for (int i = 0; i < [sectionCountTaxiFromAirPort count]; i++) {
            NSString * s = [[sectionCountTaxiFromAirPort objectAtIndex:i]objectForKey:@"lineStops"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [taxiCellHeightArray1 addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
        
        
        [taxiTableView reloadData];
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
                [subwayTableView reloadData];
            }

        }else{
            orientationSubway = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            if (sectionCountSubway == nil) {
                [self getData3];
            }else{
                [subwayTableView reloadData];
            }
        }
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            orientationTaxi = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            if (sectionCountTaxiFromAirPort == nil) {
                [self getData6];
            }else{
                [taxiTableView reloadData];
            }
        }else{
            orientationTaxi = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            if (sectionCountTaxi == nil) {
                [self getData5];
            }else{
                [taxiTableView reloadData];
            }
        }
    }
}

#pragma mark - 填写数据
-(void)fillData{
    if (segmented.selectedIndex == 0) {
        //大巴
        NSArray * myArray = [coachDic objectForKey:@"TrafficTools"];
        for (int i = 0; i < [myArray count]; i++) {
            //价格
            coachPriceLabel.text = [[myArray objectAtIndex:i]objectForKey:@"lineFares"];
            //起点
            coachDeptLabel.text = [[myArray objectAtIndex:i]objectForKey:@"lineFares"];
            //时间
            coachTime.text = [[myArray objectAtIndex:i]objectForKey:@"lineFares"];
            //从哪到哪
            
            //首班车发车时间
            
            //末班车时间
            
            //班车间隔时间
            
            //经停站
        }
       
    }else if(segmented.selectedIndex == 1){
        //快轨

    }else if(segmented.selectedIndex == 2){
        //出租车
        
    }
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (segmented.selectedIndex == 0) {
        if (orientationCoach == 0) {
            if ([sectionCountCoach count] == 0) {
                return 0;
            }else{
                return [sectionCountCoach count];
            }
        }else{
            if ([sectionCountCoachFromAirPort count] == 0) {
                return 0;
            }else{
                return [sectionCountCoachFromAirPort count];
            }
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            if ([sectionCountSubway count] == 0) {
                return 0;
            }else{
                return [sectionCountSubway count];
            }
        }else{
            if ([sectionCountSubwayFromAirPort count] == 0) {
                return 0;
            }else{
                return [sectionCountSubwayFromAirPort count];
            }
        }
        
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if ([sectionCountTaxi count] == 0) {
                return 0;
            }else{
                return [sectionCountTaxi count];
            }
        }else{
            if ([sectionCountTaxiFromAirPort count] == 0) {
                return 0;
            }else{
                return [sectionCountTaxiFromAirPort count];
            }
        }
        
    }
    return 0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (segmented.selectedIndex == 0) {
        if (orientationCoach == 0) {
            if (flagOpenOrCloseCoach[section]) {
                return 1;
            } else {
                return 0;
            }
        }else{
            if (flagOpenOrCloseCoachFromAirPort[section]) {
                return 1;
            } else {
                return 0;
            }
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            if (flagOpenOrCloseSubway[section]) {
                return 1;
            } else {
                return 0;
            }
        }else{
            if (flagOpenOrCloseSubwayFromAirPort[section]) {
                return 1;
            }else{
                return 0;
            }
        }
        
        
    }else if(segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if (flagOpenOrCloseTaxi[section]) {
                return 2;
            } else {
                return 0;
            }
        }else{
            if (flagOpenOrCloseTaxiFromAirPort[section]) {
                return 2;
            } else {
                return 0;
            }
        }
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == coachTableView) {
        if (orientationCoach == 0) {
            double height = [[coachCellHeightArray objectAtIndex:indexPath.row]doubleValue];
            return 90 + height;
        }else{
            double height = [[coachCellHeightArray1 objectAtIndex:indexPath.row]doubleValue];
            return 90 + height;
        }
    }else if (tableView == subwayTableView){
        if (orientationSubway == 0) {
            double height = [[subwayCellHeightArray objectAtIndex:indexPath.row]doubleValue];
            return 90 + height;
        }else{
            double height = [[subwayCellHeightArray1 objectAtIndex:indexPath.row]doubleValue];
            return 90 + height;
        }
    }else if (tableView == taxiTableView){
        if (orientationTaxi == 0) {
            if (indexPath.section == 0) {
                
                return 80;
            }else if (indexPath.section == 1){
                return 30;
            }else if (indexPath.section == 2){
                return 30;
            }
        }else{
            if (indexPath.section == 0) {
               
                return 80;
            }else if (indexPath.section == 1){
                return 30;
            }else if (indexPath.section == 2){
                return 30;
            }
        }
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * titleView = [[UIView alloc]init];

    if (tableView == taxiTableView) {
        [titleView setFrame:CGRectMake(0, 0, 320, 44)];        
        
    }else if (tableView == subwayTableView){
        [titleView setFrame:CGRectMake(0, 0, 320, 100)];
        
    }else if (tableView == coachTableView){
        [titleView setFrame:CGRectMake(0, 0, 320, 44)];
    }
    
    
    titleView.backgroundColor = FOREGROUND_COLOR;
    
    //底边
    UIImageView * bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42,320, 2)];
    bottomImageView.backgroundColor = [UIColor colorWithRed:232/255.0 green:226/255.0 blue:221/255.0 alpha:1];
    [titleView addSubview:bottomImageView];
    [bottomImageView release];

    
    
    if (segmented.selectedIndex == 0) {
#pragma mark - 机场大巴headview 
        //1.起点：方庄
        UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 114, 33)];
        lineNameLabel.font = [UIFont boldSystemFontOfSize:15];
        lineNameLabel.backgroundColor = [UIColor clearColor];
        [titleView addSubview:lineNameLabel];
        [lineNameLabel release];
        
        //运营时间
        UILabel * lineOperationTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 15, 100, 17)];
        lineOperationTimeLabel.font = [UIFont systemFontOfSize:13];
        lineOperationTimeLabel.backgroundColor = [UIColor clearColor];
        [titleView addSubview:lineOperationTimeLabel];
        [lineOperationTimeLabel release];
        
        
        //价格
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 13, 42, 21)];
        priceLabel.font = [UIFont systemFontOfSize:15];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = FONT_COLOR_RED;
        [titleView addSubview:priceLabel];
        [priceLabel release];
        
        if (orientationCoach == 0) {
            if (sectionCountCoach) {
                lineNameLabel.text = @"";
                lineNameLabel.text = [[sectionCountCoach objectAtIndex:section]objectForKey:@"lineName"];
                lineOperationTimeLabel.text = [[sectionCountCoach objectAtIndex:section]objectForKey:@"lineOperationTime"];
                priceLabel.text = [[sectionCountCoach objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }else{
        
            if (sectionCountCoachFromAirPort) {
                lineNameLabel.text = @"";
                
                lineNameLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineName"];
                NSLog(@"=======%@",[[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineName"]);
                lineOperationTimeLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineOperationTime"];
                priceLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = section;
        btn.frame = CGRectMake(0, 0, 320, 44);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(298, 16, 10, 10)];
        
        if (orientationCoach == 0) {
            if(flagOpenOrCloseCoach[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }else{
            if(flagOpenOrCloseCoachFromAirPort[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }
       
        [btn addSubview:image];
        [image release];
        
        [btn addTarget:self action:@selector(cellOftitleTap:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
    }else if (segmented.selectedIndex == 1){
#pragma mark - 机场快轨headview
        //1.起点：方庄
        UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 114, 33)];
        lineNameLabel.font = [UIFont boldSystemFontOfSize:15];
        lineNameLabel.backgroundColor = [UIColor clearColor];
        [titleView addSubview:lineNameLabel];
        [lineNameLabel release];
        
        //运营时间
        UILabel * lineOperationTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 15, 100, 17)];
        lineOperationTimeLabel.font = [UIFont systemFontOfSize:13];
        lineOperationTimeLabel.backgroundColor = [UIColor clearColor];
        [titleView addSubview:lineOperationTimeLabel];
        [lineOperationTimeLabel release];
        
        
        //价格
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 13, 42, 21)];
        priceLabel.font = [UIFont systemFontOfSize:15];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = FONT_COLOR_RED;
        [titleView addSubview:priceLabel];
        [priceLabel release];

        
        if (orientationSubway == 0) {
            if (sectionCountSubway) {
                lineNameLabel.text = @"";
                lineNameLabel.text = [[sectionCountSubway objectAtIndex:section]objectForKey:@"lineName"];
                lineOperationTimeLabel.text = [[sectionCountSubway objectAtIndex:section]objectForKey:@"lineOperationTime"];
                priceLabel.text = [[sectionCountSubway objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }else{
            
            if (sectionCountSubwayFromAirPort) {
                lineNameLabel.text = @"";
                lineNameLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:section]objectForKey:@"lineName"];
                lineOperationTimeLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:section]objectForKey:@"lineOperationTime"];
                priceLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = section;
        btn.frame = CGRectMake(0, 0, 320, 44);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(298, 16, 10, 10)];
        
        if (orientationSubway == 0) {
            if(flagOpenOrCloseSubway[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }else{
            if(flagOpenOrCloseSubwayFromAirPort[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }
        
        [btn addSubview:image];
        [image release];
        
        [btn addTarget:self action:@selector(cellOftitleTap:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];

        
        
    }else if (segmented.selectedIndex == 2){
#pragma mark - 出租车headview
        //1.起点：方庄
        UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 280, 33)];
        lineNameLabel.font = [UIFont boldSystemFontOfSize:15];
        lineNameLabel.backgroundColor = [UIColor clearColor];
        lineNameLabel.textColor = FONT_COLOR_BIG_GRAY;
        [titleView addSubview:lineNameLabel];
        [lineNameLabel release];
        
//        //运营时间
//        UILabel * lineOperationTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 15, 100, 17)];
//        lineOperationTimeLabel.font = [UIFont systemFontOfSize:13];
//        lineOperationTimeLabel.backgroundColor = [UIColor clearColor];
//        [titleView addSubview:lineOperationTimeLabel];
//        [lineOperationTimeLabel release];
//        
//        
//        //价格
//        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 13, 42, 21)];
//        priceLabel.font = [UIFont systemFontOfSize:15];
//        priceLabel.backgroundColor = [UIColor clearColor];
//        priceLabel.textColor = FONT_COLOR_RED;
//        [titleView addSubview:priceLabel];
//        [priceLabel release];
        
        if (orientationTaxi == 0) {
            if (sectionCountTaxi) {
                lineNameLabel.text = @"";
                lineNameLabel.text = [[sectionCountTaxi objectAtIndex:section]objectForKey:@"lineName"];
//                lineOperationTimeLabel.text = [[sectionCountTaxi objectAtIndex:section]objectForKey:@"lineOperationTime"];
//                priceLabel.text = [[sectionCountTaxi objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }else{
            
            if (sectionCountTaxiFromAirPort) {
                lineNameLabel.text = @"";
                
                lineNameLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:section]objectForKey:@"lineName"];
//                NSLog(@"=======%@",[[sectionCountTaxiFromAirPort objectAtIndex:section]objectForKey:@"lineName"]);
//                lineOperationTimeLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:section]objectForKey:@"lineOperationTime"];
//                priceLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = section;
        btn.frame = CGRectMake(0, 0, 320, 44);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(298, 16, 10, 10)];
        
        if (orientationTaxi == 0) {
            if(flagOpenOrCloseTaxi[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }else{
            if(flagOpenOrCloseTaxiFromAirPort[section]){
                image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
            }else{
                image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
            }
        }
        
        [btn addSubview:image];
        [image release];
        
        [btn addTarget:self action:@selector(cellOftitleTap:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        
    }
    return titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == coachTableView) {
#pragma mark - coachTableViewCell
        static NSString *CellIdentifier = @"coachTableViewCell";
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil) {
            cell1 = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            lineNameLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 280, 17)];
            lineNameLabelOne.font = [UIFont systemFontOfSize:12];
            lineNameLabelOne.backgroundColor = [UIColor clearColor];
            [cell1 addSubview:lineNameLabelOne];
            [lineNameLabelOne release];
            
            //首班车
            firstBusOne = [[UILabel alloc]initWithFrame:CGRectMake(90, 23, 280, 17)];
            firstBusOne.backgroundColor = [UIColor clearColor];
            firstBusOne.font = [UIFont systemFontOfSize:12];
            firstBusOne.textColor = FONT_COLOR_GRAY;
            [cell1 addSubview:firstBusOne];
            [firstBusOne release];
            
            UILabel * firstBus1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 23, 280, 17)];
            firstBus1.backgroundColor = [UIColor clearColor];
            firstBus1.font = [UIFont systemFontOfSize:12];
            firstBus1.text = @"首 班 车：";
            [cell1 addSubview:firstBus1];
            [firstBus1 release];
            
            //末班车
            UILabel * lastBusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 43, 280, 17)];
            lastBusLabel1.backgroundColor = [UIColor clearColor];
            lastBusLabel1.text = @"末 班 车：";
            lastBusLabel1.font = [UIFont systemFontOfSize:12];
            [cell1 addSubview:lastBusLabel1];
            [lastBusLabel1 release];
            
            lastBusLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(90, 43, 280, 17)];
            lastBusLabelOne.backgroundColor = [UIColor clearColor];
            lastBusLabelOne.font = [UIFont systemFontOfSize:12];
            lastBusLabelOne.textColor = FONT_COLOR_GRAY;
            [cell1 addSubview:lastBusLabelOne];
            [lastBusLabelOne release];
            
            //间隔时间
            lineIntervalTimeLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(90, 63, 280, 17)];
            lineIntervalTimeLabelOne.backgroundColor = [UIColor clearColor];
            lineIntervalTimeLabelOne.font = [UIFont systemFontOfSize:11];
            lineIntervalTimeLabelOne.textColor = FONT_COLOR_GRAY;
            [cell1 addSubview:lineIntervalTimeLabelOne];
            [lineIntervalTimeLabelOne release];
            
            UILabel * lineIntervalTimeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 280, 17)];
            lineIntervalTimeLabel1.font = [UIFont systemFontOfSize:11];
            lineIntervalTimeLabel1.backgroundColor = [UIColor clearColor];
            lineIntervalTimeLabel1.text = @"时间间隔：";
            [cell1 addSubview:lineIntervalTimeLabel1];
            [lineIntervalTimeLabel1 release];
            
            
            //经停站点
            
            //初始化label
            stopsLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            //设置自动行数与字符换行
            [stopsLabelOne setNumberOfLines:0];
            stopsLabelOne.backgroundColor = [UIColor clearColor];
            stopsLabelOne.font = [UIFont systemFontOfSize:11];
            stopsLabelOne.lineBreakMode = UILineBreakModeWordWrap;
            stopsLabelOne.textColor = FONT_COLOR_GRAY;
            stopsLabelOne.text = @"";
            [cell1 addSubview:stopsLabelOne];
            [stopsLabelOne release];
            
            UILabel * stopLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 83, 280, 17)];
            stopLabel1.font = [UIFont systemFontOfSize:11];
            stopLabel1.backgroundColor = [UIColor clearColor];
            stopLabel1.text = @"停靠车站：";
            [cell1 addSubview:stopLabel1];
            [stopLabel1 release];
            
               
        }
        
        if (orientationCoach == 0) {
            if (sectionCountCoach) {
             
                //线路名称
                lineNameLabelOne.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                firstBusOne.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                lastBusLabelOne.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                lineIntervalTimeLabelOne.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                
                
                // 测试字串
                NSString * s = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                
                //设置一个行高上限
                CGSize size = CGSizeMake(320 - 110,2000);
                
                UIFont * myFont = [UIFont systemFontOfSize:11];
                //计算实际frame大小，并将label的frame变成实际大小
                CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [stopsLabelOne setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                stopsLabelOne.text = s;
                
            }
        }else{
                if (sectionCountCoachFromAirPort) {
                   
                    //线路名称
                    lineNameLabelOne.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                    firstBusOne.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                    lastBusLabelOne.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                    lineIntervalTimeLabelOne.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                    
                    
                    // 测试字串
                    NSString * s = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                    NSString * tempString = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
                    NSLog(@"tempString : %@",tempString);
                    CGSize size = CGSizeMake(320 - 110,2000);
                    UIFont * myFont = [UIFont systemFontOfSize:11];
                    CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    
                    
                    [stopsLabelOne setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                    stopsLabelOne.text = tempString;
                }
            }
        
    return cell1;
    }else if (tableView == subwayTableView){
#pragma mark - subwayTableViewCell
        static NSString *CellIdentifier2 = @"subwayTableViewCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2]autorelease];
            lineNameLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 280, 17)];
            lineNameLabelTwo.font = [UIFont systemFontOfSize:12];
            lineNameLabelTwo.backgroundColor = [UIColor clearColor];
            [cell addSubview:lineNameLabelTwo];
            [lineNameLabelTwo release];
            
            //首班车
            firstBusTwo = [[UILabel alloc]initWithFrame:CGRectMake(90, 23, 280, 17)];
            firstBusTwo.backgroundColor = [UIColor clearColor];
            firstBusTwo.font = [UIFont systemFontOfSize:12];
            firstBusTwo.textColor = FONT_COLOR_GRAY;
            [cell addSubview:firstBusTwo];
            [firstBusTwo release];
            
            UILabel * firstBus1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 23, 280, 17)];
            firstBus1.backgroundColor = [UIColor clearColor];
            firstBus1.font = [UIFont systemFontOfSize:12];
            firstBus1.text = @"首 班 车：";
            [cell addSubview:firstBus1];
            [firstBus1 release];
            
            //末班车
            UILabel * lastBusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 43, 280, 17)];
            lastBusLabel1.backgroundColor = [UIColor clearColor];
            lastBusLabel1.text = @"末 班 车：";
            lastBusLabel1.font = [UIFont systemFontOfSize:12];
            [cell addSubview:lastBusLabel1];
            [lastBusLabel1 release];
            
            lastBusLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(90, 43, 280, 17)];
            lastBusLabelTwo.backgroundColor = [UIColor clearColor];
            lastBusLabelTwo.font = [UIFont systemFontOfSize:12];
            lastBusLabelTwo.textColor = FONT_COLOR_GRAY;
            [cell addSubview:lastBusLabelTwo];
            [lastBusLabelTwo release];
            
            //间隔时间
            lineIntervalTimeLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(90, 63, 280, 17)];
            lineIntervalTimeLabelTwo.backgroundColor = [UIColor clearColor];
            lineIntervalTimeLabelTwo.font = [UIFont systemFontOfSize:11];
            lineIntervalTimeLabelTwo.textColor = FONT_COLOR_GRAY;
            [cell addSubview:lineIntervalTimeLabelTwo];
            [lineIntervalTimeLabelTwo release];
            
            UILabel * lineIntervalTimeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 280, 17)];
            lineIntervalTimeLabel1.font = [UIFont systemFontOfSize:11];
            lineIntervalTimeLabel1.backgroundColor = [UIColor clearColor];
            lineIntervalTimeLabel1.text = @"时间间隔：";
            [cell addSubview:lineIntervalTimeLabel1];
            [lineIntervalTimeLabel1 release];
            //经停站点
            
            //初始化label
            stopsLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            //设置自动行数与字符换行
            [stopsLabelTwo setNumberOfLines:0];
            stopsLabelTwo.backgroundColor = [UIColor clearColor];
            stopsLabelTwo.font = [UIFont systemFontOfSize:11];
            stopsLabelTwo.lineBreakMode = UILineBreakModeWordWrap;
            stopsLabelTwo.textColor = FONT_COLOR_GRAY;
            stopsLabelTwo.text = @"";
            [cell addSubview:stopsLabelTwo];
            [stopsLabelTwo release];
            
            UILabel * stopLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 83, 280, 17)];
            stopLabel1.font = [UIFont systemFontOfSize:11];
            stopLabel1.backgroundColor = [UIColor clearColor];
            stopLabel1.text = @"停靠车站：";
            [cell addSubview:stopLabel1];
            [stopLabel1 release];

        }
        
         NSLog(@"orientationSubway ========  %d",orientationSubway);
        if (orientationSubway == 0) {
            if (sectionCountSubway) {
                NSLog(@"1 0");
                //线路名称
                lineNameLabelTwo.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                NSLog(@"%@",[[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineName"]);
                firstBusTwo.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                lastBusLabelTwo.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                lineIntervalTimeLabelTwo.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                // 测试字串
                NSString * s = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
               
                //设置一个行高上限
                CGSize size = CGSizeMake(320 - 110,2000);
                
                UIFont * myFont = [UIFont systemFontOfSize:11];
                //计算实际frame大小，并将label的frame变成实际大小
                CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [stopsLabelTwo setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                stopsLabelTwo.text = s;
                
            }
        }else{
                NSLog(@"before 1 1");
                if (sectionCountSubwayFromAirPort) {
                     NSLog(@"1 1");
                    //线路名称
                    lineNameLabelTwo.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                    NSLog(@"%@",[[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"]);
                    firstBusTwo.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                    lastBusLabelTwo.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                    lineIntervalTimeLabelTwo.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                    // 测试字串
                    NSString * s = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                    //设置一个行高上限
                    CGSize size = CGSizeMake(320 - 110,2000);
                    UIFont * myFont = [UIFont systemFontOfSize:11];
                    //计算实际frame大小，并将label的frame变成实际大小
                    CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    [stopsLabelTwo setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                    stopsLabelTwo.text = s;
                }
        }
    return cell;
    }else if (tableView == taxiTableView){
#pragma mark - taxiTableViewCell
        static NSString *CellIdentifier3 = @"taxiTableViewCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3]autorelease];
            
            if (indexPath.section == 0) {
                //初始化label
                stopsLabelThree = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                //设置自动行数与字符换行
                [stopsLabelThree setNumberOfLines:0];
                stopsLabelThree.backgroundColor = [UIColor clearColor];
                stopsLabelThree.font = [UIFont systemFontOfSize:11];
                stopsLabelThree.lineBreakMode = UILineBreakModeWordWrap;
                stopsLabelThree.textColor = FONT_COLOR_DEEP_GRAY;
                stopsLabelThree.text = @"";
                [cell addSubview:stopsLabelThree];
                [stopsLabelThree release];
            }else if (indexPath.section == 1){
                //地点
                addressName = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 140, 17)];
                addressName.font = [UIFont systemFontOfSize:12];
                addressName.backgroundColor = [UIColor clearColor];
                addressName.textColor = FONT_COLOR_DEEP_GRAY;
                addressName.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:addressName];
                [addressName release];
                
                //公里
                journey = [[UILabel alloc]initWithFrame:CGRectMake(160, 3, 140, 17)];
                journey.backgroundColor = [UIColor clearColor];
                journey.font = [UIFont systemFontOfSize:12];
                journey.textAlignment = NSTextAlignmentLeft;
                journey.textColor = FONT_COLOR_DEEP_GRAY;
                [cell addSubview:journey];
                [journey release];
                
                
                price = [[UILabel alloc]initWithFrame:CGRectMake(260, 3, 140, 17)];
                price.backgroundColor = [UIColor clearColor];
                price.font = [UIFont systemFontOfSize:12];
                price.textAlignment = NSTextAlignmentRight;
                price.textColor = FONT_COLOR_RED;
                [cell addSubview:price];
                [price release];
            }else if (indexPath.section == 2){
                myT = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 140, 17)];
                myT.backgroundColor = [UIColor clearColor];
                myT.textAlignment = NSTextAlignmentLeft;
                myT.textColor = FONT_COLOR_DEEP_GRAY;
                [cell addSubview:myT];
                [myT release];
                
                place = [[UILabel alloc]initWithFrame:CGRectMake(260, 3, 140, 17)];
                place.backgroundColor = [UIColor clearColor];
                place.font = [UIFont systemFontOfSize:12];
                place.textAlignment = NSTextAlignmentRight;
                place.textColor = FONT_COLOR_DEEP_GRAY;
                [cell addSubview:place];
                [place release];
            }
            
        }
            if (orientationTaxi == 0) {
                    NSLog(@"2 0");
                if (sectionCountTaxi) {
                        //线路名称
                    if (indexPath.section == 2) {
                        if (indexPath.row == 0) {
                            addressName.text = @"地点";
                            journey.text = @"公里";
                            price.text = @"价格";
                        }else{
                            addressName.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                            journey.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                            price.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineFares"];
                        }

                    }else if (indexPath.section == 1){
                        if (indexPath.row == 0) {
                            myT.text = @"航站楼";
                            place.text = @"位置";
                        }else{
                            myT.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                            place.text = @"";
                           
                        }
                    }else if (indexPath.section == 0){
                        // 测试字串
                        NSString * s = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                        NSString * tempString = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
                        NSLog(@"tempString  : %@",tempString);
                        //设置一个行高上限
                        CGSize size = CGSizeMake(300,2000);
                        
                        UIFont * myFont = [UIFont systemFontOfSize:11];
                        //计算实际frame大小，并将label的frame变成实际大小
                        CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        [stopsLabelThree setFrame:CGRectMake(0,3,labelsize.width,labelsize.height)];
                        stopsLabelThree.text = tempString;
                    }
    
                    }else{
                        NSLog(@"2 1");
                      if (sectionCountTaxiFromAirPort) {
                          if (indexPath.section == 0) {
                              // 测试字串
                              NSString * s = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                              NSString * tempString = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
                              NSLog(@"tempString  : %@",tempString);
                              //设置一个行高上限
                              CGSize size = CGSizeMake(300,2000);
                              
                              UIFont * myFont = [UIFont systemFontOfSize:11];
                              //计算实际frame大小，并将label的frame变成实际大小
                              CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                              [stopsLabelThree setFrame:CGRectMake(0,3,labelsize.width,labelsize.height)];
                              stopsLabelThree.text = tempString;
                              
                          }else if (indexPath.section == 1){
                              if (indexPath.row == 0) {
                                  myT.text = @"航站楼";
                                  place.text = @"位置";
                              }else{
                                  myT.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                                  place.text = @"";
                                  
                              }

                          }else if (indexPath.section == 2){
                              if (indexPath.row == 0) {
                                  addressName.text = @"地点";
                                  journey.text = @"公里";
                                  price.text = @"价格";
                              }else{
                                  addressName.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                                  journey.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                                  price.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineFares"];
                              }
                          }
                        }
                    }
                
            }
        
        return cell;
    
    }
#pragma mark -  over
#pragma mark -
        static NSString * CellIdentifier = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
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

//点击展开
-(void)cellOftitleTap:(UIButton *)btn{
    
    if (segmented.selectedIndex == 0) {
        int sectionIndex = btn.tag;
        if (orientationCoach == 0) {

            flagOpenOrCloseCoach[sectionIndex] = !flagOpenOrCloseCoach[sectionIndex];
            [coachTableView beginUpdates];
            [coachTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            
            [coachTableView endUpdates];
            [coachTableView reloadData];
        }else{

            flagOpenOrCloseCoachFromAirPort[sectionIndex] = !flagOpenOrCloseCoachFromAirPort[sectionIndex];
            [coachTableView beginUpdates];
            [coachTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            [coachTableView endUpdates];
            [coachTableView reloadData];
        }
        
    }else if (segmented.selectedIndex == 1){
        int sectionIndex = btn.tag;
        if (orientationSubway == 0) {

            flagOpenOrCloseSubway[sectionIndex] = !flagOpenOrCloseSubway[sectionIndex];
            [subwayTableView beginUpdates];
            [subwayTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            
            [subwayTableView endUpdates];
            [subwayTableView reloadData];
        }else{

            NSLog(@"%d",flagOpenOrCloseSubwayFromAirPort[sectionIndex]);
            flagOpenOrCloseSubwayFromAirPort[sectionIndex] = !flagOpenOrCloseSubwayFromAirPort[sectionIndex];
            NSLog(@"%d",flagOpenOrCloseSubwayFromAirPort[sectionIndex]);
            [subwayTableView beginUpdates];
            [subwayTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            
            [subwayTableView endUpdates];
            [subwayTableView reloadData];
        }
       
    }else if (segmented.selectedIndex == 2){
        int sectionIndex = btn.tag;
        if (orientationTaxi == 0) {
            flagOpenOrCloseTaxi[sectionIndex] = !flagOpenOrCloseTaxi[sectionIndex];
            [taxiTableView beginUpdates];
            [taxiTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];

            [taxiTableView endUpdates];
            [taxiTableView reloadData];
            
        }else{
            flagOpenOrCloseTaxiFromAirPort[sectionIndex] = !flagOpenOrCloseTaxiFromAirPort[sectionIndex];
            [taxiTableView beginUpdates];
            [taxiTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            [taxiTableView reloadData];
            [taxiTableView endUpdates];
            
        }
        
    }
    
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
