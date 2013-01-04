//
//  SettingForAppViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "SettingForAppViewController.h"
#import "SettingCell.h"
#import "SettingSecondCell.h"
@interface SettingForAppViewController ()
{
    
    NSArray *nameArray;
    
}
@end

@implementation SettingForAppViewController

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
    nameArray =[[NSArray alloc] initWithObjects:@"默认出发机场",@"默认到达机场", nil];
    
    
    // Do any additional setup after loading the view from its nib.
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    } else{
        
        return 1;
    }

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        static NSString *CellIdentifier = @"Cell";
        SettingCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil];
            cell = [array objectAtIndex:0];
            
            
        }
        
        cell.nameLabel.text =[nameArray objectAtIndex:indexPath.row];
 
        return cell;
        
        
    } else if(indexPath.section==4){
        
        
        static NSString *CellIdentifier = @"Cell1";
        
    
        
        
        SettingCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil];
            cell = [array objectAtIndex:0];
            
            
        }
        
        cell.nameLabel.text =[nameArray objectAtIndex:indexPath.row];
        return cell;

    } else{
        
        
        static NSString *CellIdentifier = @"cell1";
        SettingSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil){
            NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"SettingSecondCell" owner:nil options:nil];
            cell =[array objectAtIndex:0];
            
        }
        
        
        
        if(indexPath.section==1){
            cell.nameLabel.text = @"接收推送通知";
            
        } else if(indexPath.section==2){
            
            cell.nameLabel.text = @"接收短信通知";
            
        } else{
            
            cell.nameLabel.text = @"允许将信息加入passBook";
        }
        
        
        return  cell;

        
        
        
    }
    
        
      
    // Configure the cell...
    
    return nil;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}




@end
