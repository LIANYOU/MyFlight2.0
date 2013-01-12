//
//  ChackInNavgationViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChackInNavgationViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "UIButton+BackButton.h"
#import <QuartzCore/QuartzCore.h>
@interface ChackInNavgationViewController ()

@end

@implementation ChackInNavgationViewController
@synthesize airPortCode = _airPortCode,myTitle = _myTitle;
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
    self.title = @"值机柜台";
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUND_COLOR;
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    
    
    rootArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIImageView * titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.textColor = FONT_COLOR_BLUE;
    myTitleLabel.text = self.myTitle;
    myTitleLabel.font = [UIFont systemFontOfSize:14];
    myTitleLabel.backgroundColor = [UIColor clearColor];
    [titleView addSubview:myTitleLabel];
    [myTitleLabel release];
    [self.view addSubview:titleView];
    titleView.backgroundColor = [UIColor colorWithRed:212/255.0 green:218/255.0 blue:228/255.0 alpha:1];
    [titleView release];
    UIImageView * bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 320, 1)];
    bottomImageView.backgroundColor = LINE_COLOR_BLUE;
    [self.view addSubview:bottomImageView];
    [bottomImageView release];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/3GPlusPlatform/Web/AirportGuide.json",BASE_DOMAIN_URL];
//    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    NSURL * url = [NSURL URLWithString:urlStr];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"CUSS" forKey:@"RequestType"];
    [request setPostValue:self.airPortCode forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSDictionary * dic = [str objectFromJSONString];
        NSLog(@"dic : %@",dic);
        NSArray * array = [dic objectForKey:@"CUSS"];
        [rootArray addObjectsFromArray:array];
        NSLog(@"array count : %d",[array count]);
        NSLog(@"rootarray count :%d",[rootArray count]);
        
        for (int i = 0; i < [rootArray count]; i++) {
            NSLog(@"before : %@",[[rootArray objectAtIndex:i]objectForKey:@"airlineAirway"]);
            NSDictionary * myDic = [rootArray objectAtIndex:i];
            UIButton * myBtn = [self createBtnWithImage:[myDic objectForKey:@"pic"] companyName:[myDic objectForKey:@"airlineAirway"] terminal:[myDic objectForKey:@"terminal"] counter:[myDic objectForKey:@"counter"] index:i];
            [self.view addSubview:myBtn];
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

-(UIButton *)createBtnWithImage:(NSString *)imageName companyName:(NSString *)name terminal:(NSString *)myTerminal counter:(NSString *)myCounter index:(NSInteger)index{
    NSLog(@"name : %@,  terminal : %@,  phone : %@ ,imagename :%@",name,myTerminal,myCounter,imageName);
    NSInteger indexRow = index % 3;
    NSInteger indexCol = index / 3;
    UIColor * btnTitCol = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    
   
    
    myButton.frame = CGRectMake(indexRow * 95 + 10 *indexRow + 10,  indexCol * 74 + 10 * indexCol + 40, 95, 74);
    
    //给button加个前景色(代替tintcolor)
    UIView * forView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,95, 74)];
    forView.layer.cornerRadius = 10;
    forView.layer.masksToBounds = YES;
    forView.backgroundColor = btnTitCol;
    forView.alpha = 0.4;
    [myButton addSubview:forView];
    [forView release];
    
    //加图标(航空公司图片)
    NSString * realImageName = [NSString stringWithFormat:@"l_%@.png",imageName];
    UIImage * myImage = [UIImage imageNamed:realImageName];
    UIImageView * myView = [[UIImageView alloc]initWithImage:myImage];
    myView.frame = CGRectMake(8, 8, 16, 16);
    [myButton addSubview:myView];   
    [myView release];
    
//    myButton.tintColor = btnTitCol;
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 60, 15)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = FONT_COLOR_DEEP_GRAY;
    nameLabel.text = name;
    [myButton addSubview:nameLabel];
    [nameLabel release];
    
    
    
    
    
    UILabel * terLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 35, 60, 12)];
    terLabel.font = [UIFont systemFontOfSize:12];
    terLabel.backgroundColor = [UIColor clearColor];
    terLabel.textAlignment = NSTextAlignmentRight;
    terLabel.text = myTerminal;
    terLabel.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:terLabel];
    [terLabel release];
    
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 52, 80, 12)];
    phoneLabel.text = myCounter;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textAlignment = NSTextAlignmentRight;
    phoneLabel.font = [UIFont systemFontOfSize:12];
    phoneLabel.textColor = FONT_COLOR_DEEP_GRAY;
    [myButton addSubview:phoneLabel];
    [phoneLabel release];
    
    return myButton;
}


-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc{
    self.myTitle = nil;
    self.airPortCode = nil;
    self.subAirPortData = nil;
    
    [rootArray release];
    [super dealloc];
}
@end
