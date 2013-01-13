//
//  FrequentMainViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "FrequentMainViewController.h"
#import "LoginForFrequentFlayer.h"
#import "AppConfigure.h"
#import "FrequentMainPageCell.h"
@interface FrequentMainViewController ()
{
    NSArray *imageArray;
    NSArray *nameArray;
    
}
@end

@implementation FrequentMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"l_HU.png"],[UIImage imageNamed:@"l_CA.png"],[UIImage imageNamed:@"l_MU.png"],nil];
    nameArray =[[NSArray alloc] initWithObjects:@"海南航空 金鹏俱乐部会员专区",@"中国国航 知音俱乐部会员专区",@"南方航空 XX俱乐部会员专区",nil];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FrequentMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       
        NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"FrequentMainPageCell" owner:nil options:nil];
        cell =[array objectAtIndex:0];
    } 
    
    cell.thisImageView.image =[imageArray objectAtIndex:indexPath.row];
    cell.thisNameLabel.text = [nameArray objectAtIndex:indexPath.row];
    
    
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    
//    cell.imageView.image =[imageArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    cell.highlighted = NO;
    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;

    
    return cell; 
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSInteger selectIndex = indexPath.row;
    
    id controller = nil;
    
    switch (selectIndex) {
        case 0:
            controller =[[LoginForFrequentFlayer alloc] init];
            
            break;
            
        default:
            break;
    }
    
    
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
