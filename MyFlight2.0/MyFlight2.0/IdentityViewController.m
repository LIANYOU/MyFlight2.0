//
//  IdentityViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "IdentityViewController.h"

@interface IdentityViewController ()

@end

@implementation IdentityViewController

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
    self.arr = [NSArray arrayWithObjects:@"成人",@"儿童", nil];
    self.identityCardArr = [NSArray arrayWithObjects:@"身份证",@"护照",@"其他", nil];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.flag == 0) {
        return 2;
    }
    else
    {
         return 3;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (self.flag == 0) {
        cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [self.identityCardArr objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (blocks) {
        if (self.flag == 0) {
            blocks([self.arr objectAtIndex:indexPath.row]);
        }
        else{
            blocks([self.identityCardArr objectAtIndex:indexPath.row]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getDate:(void (^) (NSString * idntity))string{
    [blocks release];
    blocks = [string copy];
}
@end
