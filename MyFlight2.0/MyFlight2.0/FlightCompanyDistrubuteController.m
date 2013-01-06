//
//  FlightCompanyDistrubuteController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightCompanyDistrubuteController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "UIButton+BackButton.h"
#import <QuartzCore/QuartzCore.h>

@interface FlightCompanyDistrubuteController ()

@end

@implementation FlightCompanyDistrubuteController
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
    self.title = @"航空公司分布";
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    // Do any additional setup after loading the view from its nib.
    rootArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:215/255.0 blue:206/255.0 alpha:1];
    UIImageView * titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.text = self.myTitle;
    myTitleLabel.font = [UIFont systemFontOfSize:14];
    myTitleLabel.textColor = FONT_COLOR_BLUE;
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
//    190 * 148

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"AirlineAirway" forKey:@"RequestType"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        NSLog(@"str : %@",str);
        NSDictionary * dic = [str objectFromJSONString];
        NSLog(@"dic : %@",dic);
        NSArray * array = [dic objectForKey:@"AirlineAirway"];
        [rootArray addObjectsFromArray:[dic objectForKey:@"AirlineAirway"]];
//        NSLog(@"root count :  %d",[rootArray count]);
        NSLog(@"%d",[array count]);
//        [myTableView reloadData];
   
        for (int i = 0; i < [rootArray count]; i++) {
            NSLog(@"before : %@",[[rootArray objectAtIndex:i]objectForKey:@"serviceTel"]);
            NSDictionary * myDic = [rootArray objectAtIndex:i];
            UIButton * myBtn = [self createBtnWithImage:[myDic objectForKey:@"pic"] companyName:[myDic objectForKey:@"airlineAirwayName"] terminal:[myDic objectForKey:@"terminal"] phone:[myDic objectForKey:@"serviceTel"] index:i];
            myBtn.tag = i;
            [myBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

-(UIButton *)createBtnWithImage:(NSString *)imageName companyName:(NSString *)name terminal:(NSString *)myTerminal phone:(NSString *)myPhone index:(NSInteger)index{
    NSLog(@"name : %@,  terminal : %@,  phone : %@ ,imagename :%@",name,myTerminal,myPhone,imageName);
    NSInteger indexRow = index % 3;
    NSInteger indexCol = index / 3;
    UIColor * btnTitCol = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];

    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(indexRow * 95 + 10 *indexRow + 8,  indexCol * 74 + 10 * indexCol + 40, 95, 74);
    //给button加个前景色(代替tintcolor)
    UIView * forView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,95, 74)];
    forView.layer.cornerRadius = 10;
    forView.layer.masksToBounds = YES;
    forView.backgroundColor = btnTitCol;
    forView.alpha = 0.4;
    forView.userInteractionEnabled = NO;
    [myButton addSubview:forView];
    [forView release];
    
    
    
    //航空公司图标
    NSString * realImageName = [NSString stringWithFormat:@"l_%@.png",imageName];
    UIImage * myImage = [UIImage imageNamed:realImageName];
    UIImageView * myView = [[UIImageView alloc]initWithImage:myImage];
    myView.frame = CGRectMake(8, 8, 16, 16);
    [myButton addSubview:myView];
    [myView release];
    
//    myButton.tintColor = btnTitCol;
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 60, 15)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = FONT_COLOR_BIG_GRAY;
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = name;
    [myButton addSubview:nameLabel];
    [nameLabel release];
    
    UILabel * terLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 35, 60, 12)];
    terLabel.font = [UIFont systemFontOfSize:12];
    terLabel.textColor = FONT_COLOR_BIG_GRAY;
    terLabel.backgroundColor = [UIColor clearColor];
    terLabel.textAlignment = NSTextAlignmentRight;
    terLabel.text = myTerminal;
    [myButton addSubview:terLabel];
    [terLabel release];
    
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 52, 80, 12)];
    phoneLabel.text = myPhone;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = FONT_COLOR_BIG_GRAY;
    phoneLabel.textAlignment = NSTextAlignmentRight;
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [myButton addSubview:phoneLabel];
    [phoneLabel release];
    
    return myButton;
}

-(void)detailBtnClick:(UIButton *)btn {
    
}


-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    self.subAirPortData = nil;
    [rootArray release];
    [super dealloc];
}
@end
