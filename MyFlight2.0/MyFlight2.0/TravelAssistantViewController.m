//
//  TravelAssistantViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TravelAssistantViewController.h"
#import "FlightCompanyDistrubuteViewController.h"
#import "AppConfigure.h"
@interface TravelAssistantViewController ()

@end

@implementation TravelAssistantViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 270) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:myTableView];
    
    // Do any additional setup after loading the view from its nib.
    imageArray  = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"icon_Orders.png"],[UIImage imageNamed:@"icon_luggage.png"], [UIImage imageNamed:@"icon_Traffic.png"], [UIImage imageNamed:@"icon_checkin.png"], [UIImage imageNamed:@"icon_telphone.png"], [UIImage imageNamed:@"icon_Distributed.png"],  nil];
    NSLog(@"image count : %d",[imageArray count]);
    titleArray = [[NSArray alloc]initWithObjects:@"机场介绍",@"行李规定",@"机场交通",@"值机柜台",@"常用电话",@"航空公司分布", nil];
    
    
    //导航栏rightItem
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, 76, 30);
    [myBtn setImage:[UIImage imageNamed:@"clean_histroy_4words.png"] forState:UIControlStateNormal];
    [myBtn setImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:UIControlStateHighlighted];
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(7, 2, 70, 26)];
    titleLable.font = [UIFont systemFontOfSize:13];
    titleLable.text = @"选择机场";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    [myBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn addSubview:titleLable];
    [titleLable release];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:myBtn];
    [myBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
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
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[imageArray objectAtIndex:indexPath.row]];
    imageView.frame = CGRectMake(9, 8, 27, 27);
    [cell addSubview:imageView];
    [imageView release];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(54, 8, 139, 27)];
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.backgroundColor = [UIColor clearColor];
    [cell addSubview:title];
    [title release];
    
    UIImageView * accessView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    accessView.frame = CGRectMake(292, 15, 12, 15);
    [cell addSubview:accessView];
    [accessView release];
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        NSLog(@"机场介绍");
        //需要传机场三字码，子控制器中要用（还没传）
        FlightCompanyDistrubuteViewController * fcd = [[FlightCompanyDistrubuteViewController alloc]init];
        [self.navigationController pushViewController:fcd animated:YES];
        [fcd release];
    }else if (indexPath.row == 1){
        NSLog(@"行李规定");
    }else if (indexPath.row == 2){
        NSLog(@"机场交通");
    }else if (indexPath.row == 3){
        NSLog(@"值机柜台");
    }else if (indexPath.row == 4){
        NSLog(@"常用电话");
    }else if (indexPath.row == 5){
        NSLog(@"航空公司分布");
    }
}

-(void)rightItemClick:(id)arg{
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    //默认出发机场
    controller.startAirportName = @"";
    //默认到达机场
    controller.endAirPortName = @"";
    //选择的类型
    controller.choiceTypeOfAirPort = START_AIRPORT_TYPE;
    controller.delegate =self;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)dealloc{
    [myTableView release];
    [titleArray release];
    [imageArray release];
    [super dealloc];
}
@end
