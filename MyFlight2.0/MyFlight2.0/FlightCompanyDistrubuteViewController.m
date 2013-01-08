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
#import "UIButton+BackButton.h"

@interface FlightCompanyDistrubuteViewController ()

@end

@implementation FlightCompanyDistrubuteViewController
//@synthesize airPortCode = _airPortCode;
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
    [super viewDidLoad];
    self.title  = @"机场简介";
    // Do any additional setup after loading the view from its nib.
    mapIsFullScreen = NO;
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    
    self.view.backgroundColor = FOREGROUND_COLOR;

    CGRect myRect = [[UIScreen mainScreen] bounds];
    CGSize mySize = myRect.size;
//    myView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, mySize.height-20-170)];
//    myView.layer.cornerRadius = 4;
    
    myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, mySize.height - 20 - 160)];
    myView.backgroundColor = [UIColor clearColor];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, myView.bounds.size.height - 25)];
    scrollView.backgroundColor = [UIColor clearColor];
    CGSize myContentSize;
    myContentSize.width = 320;
    myContentSize.height = 3000;
    scrollView.contentSize = myContentSize;
    myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 300, 50)];
    myTitleLabel.backgroundColor = [UIColor clearColor];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.font = [UIFont systemFontOfSize:20];
    myTitleLabel.textColor = FONT_COLOR_BIG_GRAY;
    myTitleLabel.userInteractionEnabled = YES;
//    [myView addSubview:myTitleLabel];
    [scrollView addSubview:myTitleLabel];
   
   
    myTextView = [[UILabel alloc]initWithFrame:CGRectMake(20, 51, 280, myView.bounds.size.height - 55-30)];
    myTextView.backgroundColor = [UIColor clearColor];
    [myTextView setNumberOfLines:0];
    myTextView.lineBreakMode = UILineBreakModeWordWrap;
    myTextView.font = [UIFont systemFontOfSize:12];
//    myTextView.editable = NO;
    myTextView.textColor = FONT_COLOR_GRAY;

    [scrollView addSubview:myTextView];
    [myView addSubview:scrollView];
    
    goToWebViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, myView.bounds.size.height - 30, 320, 15)];
    goToWebViewBtn.hidden = YES;
    UILabel * btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 18)];
    btnLabel.font = [UIFont systemFontOfSize:13];
    btnLabel.text = @"查看更多 >";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.textColor = [UIColor redColor];
    [goToWebViewBtn addSubview:btnLabel];
    [btnLabel release];
    [goToWebViewBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btnLabel.backgroundColor = [UIColor clearColor];
    [myView addSubview:goToWebViewBtn];
    [goToWebViewBtn release];
    
    //myView手势
    UITapGestureRecognizer * myViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapChangeToBottom)];
    myViewTap.numberOfTapsRequired = 1;
    myViewTap.numberOfTouchesRequired = 1;
    [myTitleLabel addGestureRecognizer:myViewTap];
    
    //地图
//    [self addMap];
    
/*
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, myView.bounds.size.height - 40, myView.bounds.size.width, 40)];
    bottomView.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];

    
    UIImageView * line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_one.png"]];
    line.frame = CGRectMake(0, myView.bounds.size.height - 41, myView.bounds.size.width, 1);
    [myView addSubview:line];
    [line release];
    
    //地图按钮(改需求--不要了)
    UIButton * btnLoc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLoc setImage:[UIImage imageNamed:@"icon_location.png"] forState:UIControlStateNormal];
    [btnLoc addTarget:self action:@selector(btnLocClick:) forControlEvents:UIControlEventTouchUpInside];
    btnLoc.frame = CGRectMake(230, 9, 20, 25);
//    [bottomView addSubview:btnLoc];
  
    //更多按钮（改需求--变样式，连接到网页）
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"icon_travel_more.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.frame = CGRectMake(265, 9, 17, 24);
//    [bottomView addSubview:moreBtn];
    
    
    [myView addSubview:bottomView];
    [bottomView release];
*/    
    
    [self.view addSubview:myView];
    [myView release];
    
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"AirportGuide" forKey:@"RequestType"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{

        NSError * myError=nil;
        NSString * str = [request responseString];
        NSString * temp1= [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"aaaaa"];
        NSString * temp2= [temp1 stringByReplacingOccurrencesOfString:@"\r" withString:@"aaaaa"];
        NSString * temp3= [temp2 stringByReplacingOccurrencesOfString:@"\n" withString:@"aaaaa"];


        NSLog(@"str:%@",str);
        
        NSDictionary * dic = [temp3 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&myError];
        if (!myError) {
            CCLog(@"无错误");
            goToWebViewBtn.hidden = NO;
        } else{
            
            NSLog(@"*******");
        }
        NSLog(@"字典：%@",dic);
        
    
        NSDictionary * dic1 = [dic valueForKey:@"AirportGuide"];
        NSArray * array = [dic1 valueForKey:@"airportIntro" ];
        NSString * tempMystr1 = [array lastObject];
        NSString * tempMystr2 = [tempMystr1 stringByReplacingOccurrencesOfString:@"    " withString:@"\r"];
        NSString * tempMystr3 = [NSString stringWithFormat:@"        %@",tempMystr2];
        NSString * mystr = [tempMystr3 stringByReplacingOccurrencesOfString:@"aaaaa" withString:@"\r        "];
        
        
        NSArray * nameArray = [dic1 valueForKey:@"airportName"];
        NSString * name = [nameArray lastObject];
        
//        NSArray * rootArray = [dic valueForKey:@"AirportGuide"];
//        NSDictionary * subDic = [rootArray objectAtIndex:0];
//  
        myTextView.text = mystr;
        
        //设置一个行高上限
        CGSize size = CGSizeMake(280,2000);
        CGSize newSize;
        UIFont * myFont = [UIFont systemFontOfSize:13];
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [mystr sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [myTextView setFrame:CGRectMake(20,63,labelsize.width,labelsize.height)];
        newSize.width = 320;
        newSize.height = labelsize.height + 60;
        scrollView.contentSize = newSize;
        
        myTitleLabel.text = name;
        

        //机场坐标
//        airportCoordinateArray = [[NSMutableArray alloc]initWithArray:[[[dic1 valueForKey:@"airportCoordinate"]objectAtIndex:0]componentsSeparatedByString:@","]];
         [self addMap];
//        airportCoordinateArray = [[NSMutableArray alloc]initWithArray:tempArray];
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
    myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(10, 10, 300, [[UIScreen mainScreen] bounds].size.height-20-65)];
    
    CLLocationCoordinate2D center;
    center.latitude = 40;
    center.longitude = 117;
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    
    MKCoordinateRegion region = {
        center,span
    };
    
    myMapView.region = region;
    
    myMapManager = [[MapManager alloc]initMyManager];
    myMapView.showsUserLocation = YES;
    
    NSLog(@"%@,%@",self.subAirPortData.air_x,self.subAirPortData.air_y);
    NSLog(@"%f,%f",[self.subAirPortData.air_x doubleValue], [self.subAirPortData.air_y doubleValue]);
    
    [UIView transitionFromView:myView toView:myMapView duration:1.2 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
        
    }];
  
    
    
}

-(void)addMap{
    myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen] bounds].size.height - 180 , 320, 180)];
    CLLocationCoordinate2D center;

    UITapGestureRecognizer * mapTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapTapClick:)];
    mapTap.numberOfTapsRequired = 1;
    mapTap.numberOfTouchesRequired = 1;
    [myMapView addGestureRecognizer:mapTap];
    
    [mapTap release];
//    center.latitude = [[airportCoordinateArray objectAtIndex:0]doubleValue];
//    center.longitude = [[airportCoordinateArray objectAtIndex:1]doubleValue];
    NSLog(@"center :%f,%f",[[airportCoordinateArray objectAtIndex:0]doubleValue],[[airportCoordinateArray objectAtIndex:1]doubleValue]);
    center.latitude = 40;
    center.longitude = 117;
    
    
    MKCoordinateSpan span;
    span.latitudeDelta = .4;
    span.longitudeDelta = .4;
    
    MKCoordinateRegion region = {
        center,span
    };
    myMapView.region = region;
//    myMapView.showsUserLocation = YES;

    [self.view addSubview:myMapView];

}

-(void)mapTapClick:(UITapGestureRecognizer *)tap{
//    if (mapIsFullScreen == NO) {
//        [self mapChangeToFullScreen];
//        mapIsFullScreen = YES;
//    }else{
//        [self mapChangeToBottom];
//        mapIsFullScreen = NO;
//    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    myMapView.frame = CGRectMake(0, 60, 320, [[UIScreen mainScreen] bounds].size.height - 64 - 60);
    [UIView commitAnimations];
}

-(void)mapChangeToFullScreen{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    myMapView.frame = CGRectMake(0, 60, 320, [[UIScreen mainScreen] bounds].size.height - 64 - 60);
    [UIView commitAnimations];
}
-(void)mapChangeToBottom{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    myMapView.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height - 180 , 320, 180);
    [UIView commitAnimations];
}
-(void)moreBtnClick:(id)sender{
    //更多
    NSLog(@"更多");
   myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,[[UIScreen mainScreen]bounds].size.height - 64)];
    myWebView.scalesPageToFit = YES;
    [UIView transitionFromView:self.view toView:myWebView duration:.75 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL isFinish){
        isWebView = YES;
    }];
    
    
    NSString * tempStr = [NSString stringWithFormat:@"%@",myTitleLabel.text];
    
     
    NSString * str = [NSString stringWithFormat:@"http://wapbaike.baidu.com/search?word=%@",tempStr];
    NSLog(@"str :  %@",str);
    NSString * myRealStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"realStr : %@",myRealStr);
    NSURL * url = [NSURL URLWithString:myRealStr];
    NSURLRequest * myRequest = [NSURLRequest requestWithURL:url];
  
    myWebView.delegate = self;
    myWebView.scalesPageToFit = YES;
    [myWebView loadRequest:myRequest];
                             
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cusBtnClick{
    if (isWebView == YES) {
   
        [UIView transitionFromView:myWebView toView:self.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL isFinish){
            isWebView = NO;
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request:%@",request);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

-(void)dealloc{
    [myMapView release];
    self.subAirPortData = nil;
    [myTitleLabel release];
    [myTextView release];
    [myData release];
    [super dealloc];
}
@end
