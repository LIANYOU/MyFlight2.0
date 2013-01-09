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
     
        
        [taxiCellHeightArray removeAllObjects];
        for (int i = 0; i < [sectionCountTaxi count]; i++) {
            NSString * s = [[sectionCountTaxi objectAtIndex:i]objectForKey:@"lineStops"];
            NSString * tempS = [s stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r"];
            CGSize size = CGSizeMake(320 - 110,2000);
            UIFont * myFont = [UIFont systemFontOfSize:11];
            CGSize labelsize = [tempS sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [taxiCellHeightArray addObject:[NSString stringWithFormat:@"%f",labelsize.height]];
        }
       
        
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == coachTableView) {
        if (orientationCoach == 0) {
            return [sectionCountCoach count];
        }else{
            return [sectionCountCoachFromAirPort count];
        }
    }else if (tableView == subwayTableView){
        if (orientationSubway == 0) {
            return [sectionCountSubway count];
        }else{
            return [sectionCountSubwayFromAirPort count];
        }
    }
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    TrafficCell *cell = [coachTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TrafficCell" owner:self options:nil];
        cell = self.myTrafficCell;
        
    }
    if (tableView == coachTableView) {
        if (tableView == coachTableView) {
            if (orientationCoach == 0) {
                cell.lineName = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                cell.firstBusTime = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                cell.lastBusTime = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                cell.lineIndex = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                cell.lineFares = [[sectionCountCoach objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }else{
                cell.lineName = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                cell.firstBusTime = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                cell.lastBusTime = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                cell.lineIndex = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                cell.lineFares = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }
        }else if (tableView == subwayTableView){
            if (orientationSubway == 0) {
                cell.lineName = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                cell.firstBusTime = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                cell.lastBusTime = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                cell.lineIndex = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                cell.lineFares = [[sectionCountSubway objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
            }else{
                cell.lineName = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineName"];
                cell.firstBusTime = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"firstBus"];
                cell.lastBusTime = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lastBus"];
                cell.lineIndex = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"trafficLine"];
                cell.lineFares = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.row]objectForKey:@"lineFares"];
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
