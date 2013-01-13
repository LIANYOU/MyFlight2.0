//
//  SubTrfficViewController.m
//  MyFlight2.0
//
//  Created by apple on 13-1-13.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SubTrfficViewController.h"
#import "UIButton+BackButton.h"
@interface SubTrfficViewController ()

@end

@implementation SubTrfficViewController

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
    
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    titleImageView.backgroundColor = [UIColor blackColor];
    
//蓝色    26，72，143
    
    // Do any additional setup after loading the view from its nib.
    titleLabel.text = [NSString stringWithFormat:@"%@ %@",[self.subDic objectForKey:@"trafficLine"],[self.subDic objectForKey:@"lineName"]];
    priceLabel.text = [self.subDic objectForKey:@"lineFares"];
    firstBus.text = [self.subDic objectForKey:@"firstBus"];
    lastBus.text = [self.subDic objectForKey:@"lastBus"];
    lineIntervalTime.text = [self.subDic objectForKey:@"lineIntervalTime"];
    stops.text = [self.subDic objectForKey:@"lineStops"];
    stops.backgroundColor = [UIColor clearColor];
    stops.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    self.subDic = nil;
    [super dealloc];
}
@end
