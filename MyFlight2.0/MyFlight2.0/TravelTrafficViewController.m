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
@interface TravelTrafficViewController ()

@end

@implementation TravelTrafficViewController
@synthesize airPortCode = _airPortCode,airPortName = _airPortName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{//tableView x=0 y=64
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    arrRect = CGRectMake(0, 64, 320, 370);
//    fromRect = CGRectMake(0, 0, 320, 370);
    
    
    //导航栏view
    UIView * navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    
    navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont systemFontOfSize:14];
    navLabel.textAlignment = NSTextAlignmentRight;
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
    
    
    //title高 18
//    UIView * myTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 128, 40)];
//    navgaitionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 128-35, 40)];
//    navgaitionLabel.textColor = [UIColor whiteColor];
//    navgaitionLabel.backgroundColor = [UIColor clearColor];
//    myTitleView.backgroundColor = [UIColor clearColor];
//    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle_white_down.png"]];
//    imageView.frame = CGRectMake(128-20, 16, 7, 7);
//    [myTitleView addSubview:imageView];
//    [imageView release];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithChangeWay:)];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    [myTitleView addGestureRecognizer:tap];
//    [tap release];
    
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
    
    //机场大巴
    
    
    //机场快线
  
    
    //出租车
  
    
}

-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    if (segmented.selectedIndex == 0) {
        trfficType = 0;//机场大巴
        
    }else if (segmented.selectedIndex == 1){
        trfficType = 2;//机场快轨
        
    }else if (segmented.selectedIndex == 2){
        trfficType = 1;//出租车
    }
    
    
    //根据选择的方式发送请求
    if (segmented.selectedIndex == 0) {
        if (coachDic == nil) {
            [self getData];
        }else{
            NSLog(@"coachDic is not nil");
        }
    }else if (segmented.selectedIndex == 1){
        if (subwayDic == nil) {
            [self getData];
        }else{
            NSLog(@"subwayDic is not nil");
        }
    }else if (segmented.selectedIndex == 2){
        if (taxiDic == nil) {
            [self getData];
        }else{
            NSLog(@"taxiDic is not nil");
        }
    }
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"TrafficTools" forKey:@"RequestType"];
    [request setPostValue:self.airPortCode forKey:@"ArilineCode"];

    
    [request setPostValue:[NSString stringWithFormat:@"%d",mySegValue] forKey:@"TrafficType"];
    
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
        NSLog(@"str : %@",str);
        NSDictionary * myDic = [str objectFromJSONString];
        NSLog(@"dic : %@",myDic);
        NSArray * array = [myDic objectForKey:@"TrafficTools"];
        NSLog(@"%d",[array count]);
        //填数据
        [self fillData];
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    /*
     {"result": {"resultCode":"","message":""},"TrafficTools":[{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"20分钟","lineName":"方庄-->机场","lineOperationTime":"首班车：7:00 末班车 次日1:00","lineStops":"方庄（紫芳路） -- 大北窑（南航明珠商务酒店） -- 首都机场2号航站楼 -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"40088 51666","trafficLine":"1线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"间隔15分钟一班","lineName":"公主坟→首都机场","lineOperationTime":"4：50～22：00","lineStops":"公主坟（新兴宾馆） -- 友谊宾馆（北门航空售票处） -- 北太平庄（路口东50米） -- 安贞站（木偶剧院东侧天桥下） -- 西坝河（平安京忆栈酒店） -- 首都机场2号航站楼 -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"","trafficLine":"4线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"间隔20分钟一班","lineName":"中关村→首都机场","lineOperationTime":"5：30～21：00","lineStops":"中关村（四号桥） -- 北航（北门） -- 惠新西街（9号院门口，物美大卖场北侧20米） -- 惠新东街（天水壹阁酒店） -- 首都机场2号航站楼 -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"","trafficLine":"5线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"每30分钟一班","lineName":"通州→首都机场","lineOperationTime":"5:30～19：30","lineStops":"首都机场 -- 北京南站（北广场）","phone":"","trafficLine":"9线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"间隔30分钟一班","lineName":"奥运村→首都机场","lineOperationTime":"5：30～20：30","lineStops":"亚奥国际酒店（原劳动大厦） -- 南沟泥河公交站 -- 大屯 -- 北苑路大屯 -- 望京西园四区A门 -- 望京花园西区 -- T2航站楼 -- T1航站楼 -- T3航站楼","phone":"","trafficLine":"6线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"20分钟","lineName":"北京站→首都机场","lineOperationTime":"首班车：7:00 末班车 次日1:00","lineStops":"西单（民航营业大厦） -- 首都机场2号航站楼 -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"40088 51666","trafficLine":"3线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"","lineName":"上地→首都机场","lineOperationTime":"5：10～21：00","lineStops":"上地信息产业区（上地快捷假日酒店） -- 清河小营（桥北东侧辅路50米） -- 龙泽城铁站（城铁13号线） -- 龙华园（回龙观西大街路南龙华\345\233\255公交站旁） -- 矩阵小区 -- 天通苑西三区北门（门前路边） -- 天通苑北（地铁5号线终点） -- 名佳花园 -- 东三旗兰苑（名佳花园正门对面） -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"","trafficLine":"8线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"间隔30分钟一班","lineName":"北京南站→首都机场","lineOperationTime":"7：30-19：30","lineStops":"首都机场（T2、T1、T3）-- 东四环 -- 十八里店南桥 -- 博大路 -- 北环西路 -- 泰河停车场","phone":"","trafficLine":"10线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"一小时一班","lineName":"亦庄→首都机场","lineOperationTime":"6：00～18：00","lineStops":"南苑机场 -- 福海公园 -- 天坛 -- 前门-- 西单","phone":"","trafficLine":"11线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"","lineName":"西单→南苑机场","lineOperationTime":"6：10～15：00","lineStops":"西单→南苑机场","phone":"","trafficLine":"专线","trafficType":"0"},{"airportCode":"PEK","drivingDirection":"0","hints":"","lineFares":"16元","lineIntervalTime":"20分钟","lineName":"西单→首都机场","lineOperationTime":"首班车：7:00 末班车 次日1:00","lineStops":"北京站（国际饭店） -- 东直门（桥东50米路南报亭） -- 亮马大厦（西门） -- 首都机场2号航站楼 -- 首都机场1号航站楼 -- 首都机场3号航站楼","phone":"40088 51666","trafficLine":"2线","trafficType":"0"}]}
     */
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)tapWithChangeWay:(UITapGestureRecognizer *)tap{
//    
//}

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
    }else if (segmented.selectedIndex == 1){
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

-(void)dealloc{
    [navImageView release];
    [navgaitionLabel release];
    [navImageView release];
    self.airPortCode = nil;
    [super dealloc];
}
@end
