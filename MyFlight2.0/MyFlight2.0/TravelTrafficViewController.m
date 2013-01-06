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
    [self getData];
    
    
  
}

#pragma mark - segment值改变
-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    if (segmented.selectedIndex == 0) {
        trfficType = 0;//机场大巴
        coachTableView.hidden = NO;
        if (currTableView != coachTableView) {
            [UIView transitionFromView:currTableView toView:coachTableView duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL isFinish){
                currTableView = coachTableView;
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
            [UIView transitionFromView:currTableView toView:subwayTableView duration:0.75 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL isFinish){
                currTableView = subwayTableView;
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
            [UIView transitionFromView:currTableView toView:taxiTableView duration:0.75 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL isFinish){
                currTableView = taxiTableView;
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
                [self getData];
            }
        }else{
            if (coachDicFromAirPort == nil) {
                [self getData];
            }
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            if (subwayDic == nil) {
                [self getData];
            }
        }else{
            if (subwayDicFromAirPort == nil) {
                [self getData];
            }
        }
        
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if (taxiDic == nil) {
                [self getData];
            }
        }else{
            if (taxiDicFromAirPort == nil) {
                [self getData];
            }
        }
        
    }
}

-(void)getDataWithType:(NSInteger)trafficType sendOrientation:(NSInteger)sendOrientation{
    
}
-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
   
    
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];

    
    [request setPostValue:[NSString stringWithFormat:@"%d",trfficType] forKey:@"TrafficType"];
    
    if (segmented.selectedIndex == 0) {
        orientation = orientationCoach;
    }else if (segmented.selectedIndex == 1){
        orientation = orientationSubway;
    }else if (segmented.selectedIndex == 2){
        orientation = orientationTaxi;
    }
    [request setPostValue:[NSString stringWithFormat:@"%d",orientation] forKey:@"DrivingDirection"];
    
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"str :%@",str);

        if (segmented.selectedIndex == 0) {
            if (orientationCoach == 0) {
                coachDic = [str objectFromJSONString];
                sectionCountCoach = [[NSArray alloc]initWithArray:[coachDic objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountCoach count];
                flagOpenOrCloseCoach = (BOOL *)malloc(size);
                memset(flagOpenOrCloseCoach, NO, size);
                [coachTableView reloadData];
            }else{
                coachDicFromAirPort = [str objectFromJSONString];
                sectionCountCoachFromAirPort = [[NSArray alloc]initWithArray:[coachDicFromAirPort objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountCoachFromAirPort count];
                flagOpenOrCloseCoachFromAirPort = (BOOL *)malloc(size);
                memset(flagOpenOrCloseCoachFromAirPort, NO, size);
                [coachTableView reloadData];
            }
            

        }else if (segmented.selectedIndex == 1){
            if (orientationSubway) {
                subwayDic = [str objectFromJSONString];
                sectionCountSubway = [[NSArray alloc]initWithArray:[subwayDic objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountSubway count];
                flagOpenOrCloseSubway = (BOOL *)malloc(size);
                memset(flagOpenOrCloseSubway, NO, size);
                [subwayTableView reloadData];
            }else{
                subwayDicFromAirPort = [str objectFromJSONString];
                sectionCountSubwayFromAirPort = [[NSArray alloc]initWithArray:[subwayDicFromAirPort objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountSubwayFromAirPort count];
                flagOpenOrCloseSubwayFromAirPort = (BOOL *)malloc(size);
                memset(flagOpenOrCloseSubwayFromAirPort, NO, size);
                [subwayTableView reloadData];
            }
            

        }else if (segmented.selectedIndex == 2){
            if (orientationTaxi == 0) {
                taxiDic = [str objectFromJSONString];
                sectionCountTaxi = [[NSArray alloc]initWithArray:[taxiDic objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountTaxi count];
                flagOpenOrCloseTaxi = (BOOL *)malloc(size);
                memset(flagOpenOrCloseTaxi, NO, size);
                [taxiTableView reloadData];
            }else{
                taxiDicFromAirPort = [str objectFromJSONString];
                sectionCountTaxiFromAirPort = [[NSArray alloc]initWithArray:[taxiDicFromAirPort objectForKey:@"TrafficTools"]];
                //判断开关状态
                int size = sizeof(BOOL *) * [sectionCountTaxiFromAirPort count];
                flagOpenOrCloseTaxiFromAirPort = (BOOL *)malloc(size);
                memset(flagOpenOrCloseTaxiFromAirPort, NO, size);
                [taxiTableView reloadData];
            }
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
            [self getData];
        }else{
            orientationCoach = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            [self getData];
        }
        
    }else if (segmented.selectedIndex == 1){
        if (orientationSubway == 0) {
            orientationSubway = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            [self getData];

        }else{
            orientationSubway = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            [self getData];

        }
    }else if (segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            orientationTaxi = 1;
            navLabel.text = [NSString stringWithFormat:@"%@机场-市区",self.airPortName];
            [self getData];

        }else{
            orientationTaxi = 0;
            navLabel.text = [NSString stringWithFormat:@"%@市区-机场",self.airPortName];
            [self getData];

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
//        if (flagOpenOrCloseSubway[section]) {
//            return 1;
//        } else {
//            return 0;
//        }
        return 0;
    }else if(segmented.selectedIndex == 2){
        if (orientationTaxi == 0) {
            if (flagOpenOrCloseTaxi[section]) {
                return 1;
            } else {
                return 0;
            }
        }else{
            if (flagOpenOrCloseTaxiFromAirPort[section]) {
                return 1;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * titleView = [[UIView alloc]init];

    if (tableView == taxiTableView) {
        [titleView setFrame:CGRectMake(0, 0, 320, 44)];
    
    }else if (tableView == subwayTableView){
        [titleView setFrame:CGRectMake(0, 0, 320, 44)];
        
    }else if (tableView == coachTableView){
        [titleView setFrame:CGRectMake(0, 0, 320, 44)];
    }
    
    
    titleView.backgroundColor = FOREGROUND_COLOR;
    UIImageView * bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42,320, 2)];
    bottomImageView.backgroundColor = [UIColor colorWithRed:232/255.0 green:226/255.0 blue:221/255.0 alpha:1];
    [titleView addSubview:bottomImageView];
    [bottomImageView release];
    if (segmented.selectedIndex == 0) {
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
                lineOperationTimeLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineOperationTime"];
                priceLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:section]objectForKey:@"lineFares"];
            }
        }
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = section;
        btn.frame = CGRectMake(293, 6, 20, 20);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 10, 10)];
        
        if(flagOpenOrCloseCoach[section]){
            image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
        }else{
            image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
        }
        [btn addSubview:image];
        [image release];
        
        [btn addTarget:self action:@selector(cellOftitleTap:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
    }else if (segmented.selectedIndex == 1){
        
    }else if (segmented.selectedIndex == 2){

        
    }
    return titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 280, 17)];
        lineNameLabel.font = [UIFont systemFontOfSize:12];
        lineNameLabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:lineNameLabel];
        [lineNameLabel release];
        
        //首班车
        UILabel * firstBus = [[UILabel alloc]initWithFrame:CGRectMake(90, 23, 280, 17)];
        firstBus.backgroundColor = [UIColor clearColor];
        firstBus.font = [UIFont systemFontOfSize:12];
        firstBus.textColor = FONT_COLOR_GRAY;
        [cell addSubview:firstBus];
        [firstBus release];
        
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
        
        UILabel * lastBusLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 43, 280, 17)];
        lastBusLabel.backgroundColor = [UIColor clearColor];
        lastBusLabel.font = [UIFont systemFontOfSize:12];
        lastBusLabel.textColor = FONT_COLOR_GRAY;
        [cell addSubview:lastBusLabel];
        [lastBusLabel release];
        
        //间隔时间
        UILabel * lineIntervalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 63, 280, 17)];
        lineIntervalTimeLabel.backgroundColor = [UIColor clearColor];
        lineIntervalTimeLabel.font = [UIFont systemFontOfSize:11];
        lineIntervalTimeLabel.textColor = FONT_COLOR_GRAY;
        [cell addSubview:lineIntervalTimeLabel];
        [lineIntervalTimeLabel release];
        
        UILabel * lineIntervalTimeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 280, 17)];
        lineIntervalTimeLabel1.font = [UIFont systemFontOfSize:11];
        lineIntervalTimeLabel1.backgroundColor = [UIColor clearColor];
        lineIntervalTimeLabel1.text = @"时间间隔：";
        [cell addSubview:lineIntervalTimeLabel1];
        [lineIntervalTimeLabel1 release];
        
        
        //经停站点
        
        //初始化label
        UILabel *stopsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //设置自动行数与字符换行
        [stopsLabel setNumberOfLines:0];
        stopsLabel.backgroundColor = [UIColor clearColor];
        stopsLabel.font = [UIFont systemFontOfSize:11];
        stopsLabel.lineBreakMode = UILineBreakModeWordWrap;
        stopsLabel.textColor = FONT_COLOR_GRAY;
        stopsLabel.text = @"";
        [cell addSubview:stopsLabel];
        [stopsLabel release];
        
        UILabel * stopLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 83, 280, 17)];
        stopLabel1.font = [UIFont systemFontOfSize:11];
        stopLabel1.backgroundColor = [UIColor clearColor];
        stopLabel1.text = @"停靠车站：";
        [cell addSubview:stopLabel1];
        [stopLabel1 release];
        
        
        if (segmented.selectedIndex == 0) {
            if (orientationCoach == 0) {
                
                
                NSLog(@"0 0");
                
                
                if (sectionCountCoach) {
                    //线路名称
                    lineNameLabel.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                    firstBus.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                    lastBusLabel.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                    lineIntervalTimeLabel.text = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                    
                    
                    // 测试字串
                    NSString * s = [[sectionCountCoach objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                    //设置一个行高上限
                    CGSize size = CGSizeMake(320 - 110,2000);
                    
                    UIFont * myFont = [UIFont systemFontOfSize:11];
                    //计算实际frame大小，并将label的frame变成实际大小
                    CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                    stopsLabel.text = s;
                    
                }else{
                    
                    
                    NSLog(@"0 1");
                    
                    

                    if (sectionCountCoachFromAirPort) {
                        //线路名称
                        lineNameLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                        firstBus.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                        lastBusLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                        lineIntervalTimeLabel.text = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                        
                        
                        // 测试字串
                        NSString * s = [[sectionCountCoachFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                        //设置一个行高上限
                        CGSize size = CGSizeMake(320 - 110,2000);
                        
                        UIFont * myFont = [UIFont systemFontOfSize:11];
                        //计算实际frame大小，并将label的frame变成实际大小
                        CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                        stopsLabel.text = s;
                    }
                }
            }
        }else if (segmented.selectedIndex == 1){
            if (orientationSubway == 0) {
                
                
                NSLog(@"1 0");
                
                

                if (sectionCountSubway) {
                    //线路名称
                    lineNameLabel.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                    firstBus.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                    lastBusLabel.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                    lineIntervalTimeLabel.text = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                    
                    
                    // 测试字串
                    NSString * s = [[sectionCountSubway objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                    //设置一个行高上限
                    CGSize size = CGSizeMake(320 - 110,2000);
                    
                    UIFont * myFont = [UIFont systemFontOfSize:11];
                    //计算实际frame大小，并将label的frame变成实际大小
                    CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                    stopsLabel.text = s;
                    
                }else{
                    
                    
                    NSLog(@"1 1");
                    
                    

                    if (sectionCountSubwayFromAirPort) {
                        //线路名称
                        lineNameLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                        firstBus.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                        lastBusLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                        lineIntervalTimeLabel.text = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                        
                        
                        // 测试字串
                        NSString * s = [[sectionCountSubwayFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                        //设置一个行高上限
                        CGSize size = CGSizeMake(320 - 110,2000);
                        
                        UIFont * myFont = [UIFont systemFontOfSize:11];
                        //计算实际frame大小，并将label的frame变成实际大小
                        CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                        stopsLabel.text = s;
                    }
                }
            }
        

        }else if (segmented.selectedIndex == 2){
            if (orientationTaxi == 0) {
                
                
                NSLog(@"2 0");
                
                

                if (sectionCountTaxi) {
                    //线路名称
                    lineNameLabel.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                    firstBus.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                    lastBusLabel.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                    lineIntervalTimeLabel.text = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                    
                    
                    // 测试字串
                    NSString * s = [[sectionCountTaxi objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                    //设置一个行高上限
                    CGSize size = CGSizeMake(320 - 110,2000);
                    
                    UIFont * myFont = [UIFont systemFontOfSize:11];
                    //计算实际frame大小，并将label的frame变成实际大小
                    CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                    stopsLabel.text = s;
                    
                }else{
                    
                    
                    NSLog(@"2 1");
                    
                    

                    if (sectionCountTaxiFromAirPort) {
                        //线路名称
                        lineNameLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineName"];
                        firstBus.text = [[sectionCountTaxiFromAirPort objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
                        lastBusLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
                        lineIntervalTimeLabel.text = [[sectionCountTaxiFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
                        
                        
                        // 测试字串
                        NSString * s = [[sectionCountTaxiFromAirPort objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
                        //设置一个行高上限
                        CGSize size = CGSizeMake(320 - 110,2000);
                        
                        UIFont * myFont = [UIFont systemFontOfSize:11];
                        //计算实际frame大小，并将label的frame变成实际大小
                        CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
                        stopsLabel.text = s;
                    }
                }
            }
        }

    }
        
    // Configure the cell...
    
    return cell;
}

-(void)refreshGetData{
    [self getData];
}
-(void)fillData:(NSDictionary *)dic{
    
}

//点击展开
-(void)cellOftitleTap:(UIButton *)btn{
    
    if (segmented.selectedIndex == 0) {
        int sectionIndex = btn.tag;
        if (orientationCoach == 0) {
            flagOpenOrCloseCoach[sectionIndex] = !flagOpenOrCloseCoach[sectionIndex];
            [coachTableView beginUpdates];
            [coachTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            [coachTableView endUpdates];
        }else{
            flagOpenOrCloseCoachFromAirPort[sectionIndex] = !flagOpenOrCloseCoachFromAirPort[sectionIndex];
            [coachTableView beginUpdates];
            [coachTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            [coachTableView endUpdates];
        }
        
    }else if (segmented.selectedIndex == 1){
        int sectionIndex = btn.tag;
        if (orientationSubway == 0) {
            flagOpenOrCloseSubway[sectionIndex] = !flagOpenOrCloseSubway[sectionIndex];
            [subwayTableView beginUpdates];
            [subwayTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            [subwayTableView endUpdates];
        }else{
            flagOpenOrCloseSubwayFromAirPort[sectionIndex] = !flagOpenOrCloseSubwayFromAirPort[sectionIndex];
            [subwayTableView beginUpdates];
            [subwayTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            [subwayTableView endUpdates];
        }
       
    }else if (segmented.selectedIndex == 2){
        int sectionIndex = btn.tag;
        if (orientationTaxi == 0) {
            flagOpenOrCloseTaxi[sectionIndex] = !flagOpenOrCloseTaxi[sectionIndex];
            [taxiTableView beginUpdates];
            [taxiTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            [taxiTableView endUpdates];
        }else{
            flagOpenOrCloseTaxiFromAirPort[sectionIndex] = !flagOpenOrCloseTaxiFromAirPort[sectionIndex];
            [taxiTableView beginUpdates];
            [taxiTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
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
