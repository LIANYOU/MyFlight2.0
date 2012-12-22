//
//  DetailFlightConditionViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-13.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "DetailFlightConditionViewController.h"
#import "SMSViewController.h"
@interface DetailFlightConditionViewController ()

@end

@implementation DetailFlightConditionViewController
@synthesize btnMessage,btnMoreShare,btnPhone,btnShare,planeCode,planeCompanyAndTime,planeState,from,arrive,fromFirstTime,fromFirstTimeName,fromResult,fromSceTime,fromSceTimeName,fromT,fromWeather,arriveFirstTime,arriveFirstTimeName,arriveResult,arriveSecTime,arriveSecTimeName,arriveT,arriveWeather,attentionThisPlaneBtn,littlePlaneBtn;
@synthesize dic = _dic;
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
    // Do any additional setup after loading the view from its nib.
    
    [self.btnMessage addTarget:self action:@selector(btnMessageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPhone addTarget:self action:@selector(btnPhoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnShare addTarget:self action:@selector(btnShareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMoreShare addTarget:self action:@selector(btnMoreShareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView * myView = [self.view viewWithTag:999];
    myView.layer.cornerRadius = 6;
    myView.layer.masksToBounds = YES;
    
    
    myFlightConditionDetailData = [[FlightConditionDetailData alloc]initWithDictionary:self.dic];
  
    [flightLine setImage:[UIImage imageNamed:@"circle_green_change.png"]];
    flightLine.frame = CGRectMake(71, 111, 138, 33);
    flightLine.clipsToBounds = YES;
    flightLine.contentMode = UIViewContentModeLeft;
    
    //判断提前还是晚点
    if ([myFlightConditionDetailData.realDeptTime isEqualToString:@"-"]) {
        NSLog(@"---------------------");
        self.fromResult.text = @"";
        self.arriveResult.text = @"";
    }else{
        NSInteger firseTimeDiff = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.realDeptTime];
        firseTimeDiff = firseTimeDiff/60;
        NSInteger secTimeDiff = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedArrTime timeE:myFlightConditionDetailData.realArrTime];
        secTimeDiff = secTimeDiff/60;
        if (firseTimeDiff < 0) {
            NSString * relustFirst = [NSString stringWithFormat:@"比预计提前%d分钟",(-1)*firseTimeDiff];
            self.fromResult.text = relustFirst;
        }else{
            NSString * relustFirst = [NSString stringWithFormat:@"比预计晚点%d分钟",firseTimeDiff];
            self.fromResult.text = relustFirst;
        }
        
        if (secTimeDiff < 0) {
            NSString * relustSec = [NSString stringWithFormat:@"比预计提前%d分钟",(-1)*secTimeDiff];
            self.arriveResult.text = relustSec;
        }else{
            NSString * relustSec = [NSString stringWithFormat:@"比预计晚点%d分钟",secTimeDiff];
            self.arriveResult.text = relustSec;
        }
    }
    
    
    [self fillAllData];
  
}

-(void)fillAllData{
//    NSLog(@"%@",self.dic);
    
    self.planeCode.text = myFlightConditionDetailData.flightNum;
    self.planeCompanyAndTime.text = [NSString stringWithFormat:@"%@ %@",myFlightConditionDetailData.flightCompany,myFlightConditionDetailData.deptDate];
    self.planeState.text = myFlightConditionDetailData.flightState;
    self.from.text = myFlightConditionDetailData.deptAirport;
    self.arrive.text = myFlightConditionDetailData.arrAirport;
    self.fromWeather.text = nil;
    self.arriveWeather.text = nil;
    self.fromT.text = myFlightConditionDetailData.flightHTerminal;
    self.arriveT.text = myFlightConditionDetailData.flightTerminal;
    self.fromFirstTimeName.text = @"计划：";
    self.fromFirstTime.text = myFlightConditionDetailData.expectedDeptTime;
    self.fromSceTimeName.text = @"实际：";
    self.fromSceTime.text = myFlightConditionDetailData.realDeptTime;
//    self.fromResult.text = @"";
    self.arriveFirstTimeName.text = @"计划：";
    self.arriveFirstTime.text = myFlightConditionDetailData.expectedArrTime;
    self.arriveSecTimeName.text = @"实际：";
    self.arriveSecTime.text = myFlightConditionDetailData.realArrTime;
//    self.arriveResult.text = @"";
    if ([myFlightConditionDetailData.flightState isEqualToString:@"起飞"]) {
        double totalTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.expectedDeptTime timeE:myFlightConditionDetailData.expectedArrTime];
        
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        NSLog(@"locationString : %@",locationString);
        
    

        double curTime = [self mxGetStringTimeDiff:myFlightConditionDetailData.realDeptTime timeE:locationString];
        [dateformatter release];

        NSLog(@"起飞：%f",curTime);
        NSLog(@"total:%f",totalTime);
        NSLog(@"时间百分比：%f",curTime/totalTime);
        CGRect frame = flightLine.frame;
        frame.size.width=frame.size.width*(curTime/totalTime);
        flightLine.frame=frame;
    }
}

-(void)btnMessageClick:(id)sender{
    
    SMSViewController * sendMessange = [[SMSViewController alloc]init];
    [self.navigationController pushViewController:sendMessange animated:YES];
    [sendMessange release];
}
-(void)btnPhoneClick:(id)sender{
   
}
-(void)btnShareClick:(id)sender{
  
}
-(void)btnMoreShareClick:(id)sender{
    UIActionSheet * moreShare = [[UIActionSheet alloc]initWithTitle:@"更多分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到新浪微博",@"分享到短信",@"发邮件", nil];
    [moreShare showInView:self.view];
}
#pragma mark - actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //分享新浪微博
        
    }else if(buttonIndex == 1){
        //分享到邮件
        
    }else if(buttonIndex == 2){
        //发邮件
        
    }else if(buttonIndex == 3){
       //取消
        
    }
    
}
#pragma mark - 算时间差
- (double)mxGetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE
{
    double timeDiff = 0.0;
    
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"HH:mm"];
    NSDate *dateS = [formatters dateFromString:timeS];
    
    NSDateFormatter *formatterE = [[NSDateFormatter alloc]init];
    [formatterE setDateFormat:@"HH:mm"];
    NSDate *dateE = [formatterE dateFromString:timeE];
    
    timeDiff = [dateE timeIntervalSinceDate:dateS ];
    
    return timeDiff;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
