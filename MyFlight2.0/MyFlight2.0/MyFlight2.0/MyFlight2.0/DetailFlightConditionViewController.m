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
    NSLog(@"%@",self.dic);
    
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
    
   
    
    
    /*
     arrAirport = "\U4e0a\U6d77\U8679\U6865";
     arrTime = "09:34";
     deptAirport = "\U5317\U4eac\U9996\U90fd";
     deptDate = "2012-12-16";
     deptTime = "06:35";
     expectedArrTime = "09:34";
     expectedDeptTime = "06:35";
     flightArrcode = SHA;
     flightCompany = "\U4e0a\U6d77\U5409\U7965\U822a\U7a7a\U516c\U53f8";
     flightDepcode = PEK;
     flightHTerminal = T3;
     flightNum = HO1252;
     flightState = "\U5230\U8fbe";
     flightTerminal = T2;
     realArrTime = "09:32";
     realDeptTime = "07:46";
     */    
}

-(void)btnMessageClick:(id)sender{
    CCLog(@"btnMessageClick");
    SMSViewController * sendMessange = [[SMSViewController alloc]init];
    [self.navigationController pushViewController:sendMessange animated:YES];
    [sendMessange release];
}
-(void)btnPhoneClick:(id)sender{
    CCLog(@"btnPhoneClick");
}
-(void)btnShareClick:(id)sender{
    CCLog(@"btnShareClick");
}
-(void)btnMoreShareClick:(id)sender{
    CCLog(@"btnMoreShareClick");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
