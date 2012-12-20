//
//  FlightCompanyDistrubuteViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightCompanyDistrubuteViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface FlightCompanyDistrubuteViewController ()

@end

@implementation FlightCompanyDistrubuteViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:215/255.0 blue:206/255.0 alpha:1];

    CGRect myRect = [[UIScreen mainScreen] bounds];
    CGSize mySize = myRect.size;
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, mySize.height-20-65)];
    myView.layer.cornerRadius = 4;
    myView.backgroundColor = [UIColor whiteColor];
    
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    myTitleLabel.backgroundColor = [UIColor clearColor];
    myTitleLabel.text = @"北京首都机场";
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.font = [UIFont systemFontOfSize:17];
    [myView addSubview:myTitleLabel];
    [myTitleLabel release];
   
    UITextView * myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 51, myView.bounds.size.width, myView.bounds.size.height - 55-40)];
    myTextView.text = @"    北京首都国际机场是“中国第一国门”，是中国最重要、规模最大、设备最先进、运输生产最繁忙的大型国际航空港。是中国的空中门户和对外交流的重要窗口。北京首都国际机场建成于1958年，运营50多年来，伴随着历史的脚步，始终昂首向前。尤其是改革开放以来，随着中国经济的快速发展，并得益于北京得天独厚的政治、经济、文化和地理位置优势，北京首都国际机场的年旅客吞吐量从1978年的103万人次增长到2010年的7395万人次，目前排名全球第2位。";
    [myView addSubview:myTextView];
    [myTextView release];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, myView.bounds.size.height - 40, myView.bounds.size.width, 40)];
    bottomView.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];

    
    UIImageView * line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_one.png"]];
    line.frame = CGRectMake(0, myView.bounds.size.height - 41, myView.bounds.size.width, 1);
    [myView addSubview:line];
    [line release];
    
    UIButton * btnLoc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLoc setImage:[UIImage imageNamed:@"icon_location.png"] forState:UIControlStateNormal];
    [btnLoc addTarget:self action:@selector(btnLocClick:) forControlEvents:UIControlEventTouchUpInside];
    btnLoc.frame = CGRectMake(230, 9, 20, 25);
    [bottomView addSubview:btnLoc];
  
    
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"icon_travel_more.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.frame = CGRectMake(265, 9, 17, 24);
    [bottomView addSubview:moreBtn];
    
    
    [myView addSubview:bottomView];
    [bottomView release];
    
    
    [self.view addSubview:myView];
    [myView release];
}

-(void)btnLocClick:(id)sender{
    //地图
    NSLog(@"地图");
}

-(void)moreBtnClick:(id)sender{
    //更多
    NSLog(@"更多");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
