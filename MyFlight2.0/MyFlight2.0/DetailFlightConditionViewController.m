//
//  DetailFlightConditionViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-13.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "DetailFlightConditionViewController.h"

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
  
}

-(void)btnMessageClick:(id)sender{
    CCLog(@"btnMessageClick");
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
