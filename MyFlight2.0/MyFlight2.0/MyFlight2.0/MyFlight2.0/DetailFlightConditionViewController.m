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
    self.fromFirstTime.text = myFlightConditionDetailData.deptTime;
    self.fromSceTimeName.text = @"实际：";
    self.fromSceTime.text = myFlightConditionDetailData.realDeptTime;
    self.fromResult.text = @"";
    self.arriveFirstTimeName.text = @"计划：";
    self.arriveFirstTime.text = myFlightConditionDetailData.arrTime;
    self.arriveSecTimeName.text = @"实际：";
    self.arriveSecTime.text = myFlightConditionDetailData.realArrTime;
    self.arriveResult.text = @"";    
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
    UIActionSheet * moreShare = [[UIActionSheet alloc]initWithTitle:@"更多分享" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到新浪微博",@"分享到短信",@"发邮件", nil];
    [moreShare showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
