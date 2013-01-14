//
//  PostViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-21.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
     cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"快递         北京10元,其他地区20元 (推荐)";
       
        cell.detailTextLabel.text = @"北京10元,其他地区20元 (推荐)";
        
    }
    else
    {
        cell.textLabel.text = @"平信           全国免费";
        cell.detailTextLabel.text = @"全国免费";
    }
    return cell;
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (blocks) {
        if (indexPath.row == 0) {
            blocks(@"快递");
        }
        else{
            blocks(@"平信");
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getDate:(void (^) (NSString * idntity))string{
    [blocks release];
    blocks = [string copy];
}

@end
