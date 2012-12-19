//
//  TravelAssistantViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "TravelAssistantViewController.h"

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
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    // Do any additional setup after loading the view from its nib.
    imageArray  = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"icon_Orders.png"],[UIImage imageNamed:@"icon_luggage.png"], [UIImage imageNamed:@"icon_Traffic.png"], [UIImage imageNamed:@"icon_checkin.png"], [UIImage imageNamed:@"icon_telphone.png"], [UIImage imageNamed:@"icon_Distributed.png"],  nil];
    NSLog(@"image count : %d",[imageArray count]);
    titleArray = [[NSArray alloc]initWithObjects:@"机场介绍",@"行李规定",@"机场交通",@"值机柜台",@"常用电话",@"航空公司分布", nil];
    
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
    accessView.frame = CGRectMake(292, 12, 16, 20);
    [cell addSubview:accessView];
    [accessView release];
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"");
    }else if (indexPath.row == 1){
        NSLog(@"");
    }else if (indexPath.row == 1){
        NSLog(@"");
    }else if (indexPath.row == 1){
        NSLog(@"");
    }else if (indexPath.row == 1){
        NSLog(@"");
    }else if (indexPath.row == 1){
        NSLog(@"");
    }
}

-(void)dealloc{
    [myTableView release];
    [titleArray release];
    [imageArray release];
    [super dealloc];
}
@end
