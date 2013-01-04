//
//  DetailForLichengViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DetailForLichengViewController.h"
#import "DetailForLiChengCell.h"


@interface DetailForLichengViewController ()
{
    
    NSArray *nameArray;
    NSArray *detailArray;
    
}
@end

@implementation DetailForLichengViewController

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
    nameArray = [[NSArray alloc] initWithObjects:@"金鹏卡号",@"会员级别",@"总里程余额",@"里程过期日",@"航空里程",@"非航空里程",@"升级/定级里程",@"升级/定级航段",@"过期里程",@"其他里程", nil];
    
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
    DetailForLiChengCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil){
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DetailForLiChengCell" owner:nil options:nil];

        cell = [array objectAtIndex:0];
           
    }
    
    
    cell.nameLabel.text = [nameArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
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




- (void)dealloc {
    [_thisCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisCell:nil];
    [super viewDidUnload];
}
@end
