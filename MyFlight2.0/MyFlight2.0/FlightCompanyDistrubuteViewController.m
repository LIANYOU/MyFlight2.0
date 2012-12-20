//
//  FlightCompanyDistrubuteViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightCompanyDistrubuteViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"
#import "AppConfigure.h"
#import "JSONKit.h"
@interface FlightCompanyDistrubuteViewController ()

@end

@implementation FlightCompanyDistrubuteViewController
@synthesize airPortCode = _airPortCode;
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
    
    myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    myTitleLabel.backgroundColor = [UIColor clearColor];
//    myTitleLabel.text = @"北京首都机场";
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.font = [UIFont systemFontOfSize:17];
    [myView addSubview:myTitleLabel];
   
   
    myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 51, myView.bounds.size.width, myView.bounds.size.height - 55-40)];
    myTextView.editable = NO;

    [myView addSubview:myTextView];
    
    
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
    
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"AirportGuide" forKey:@"RequestType"];
    [request setPostValue:self.airPortCode forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{

        NSError * myError=nil;
        NSString * str = [request responseString];
        NSLog(@"str:%@",str);
        NSDictionary * dic = [str objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&myError];
        if (!myError) {
            CCLog(@"无错误");
        } else{
            
            NSLog(@"*******");
        }
        NSLog(@"字典：%@",dic);

    
        NSDictionary * dic1 = [dic valueForKey:@"AirportGuide"];
        NSArray * array = [dic1 valueForKey:@"airportIntro" ];
        NSString * mystr = [array lastObject];
        NSArray * nameArray = [dic1 valueForKey:@"airportName"];
        NSString * name = [nameArray lastObject];
        
//        NSArray * rootArray = [dic valueForKey:@"AirportGuide"];
//        NSDictionary * subDic = [rootArray objectAtIndex:0];
//
        myTextView.text = mystr;
        myTitleLabel.text = name;
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
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

-(void)dealloc{
    [myTitleLabel release];
    [myTextView release];
    [myData release];
    [super dealloc];
}
@end
