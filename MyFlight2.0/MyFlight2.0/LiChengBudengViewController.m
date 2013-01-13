//
//  LiChengBudengViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "LiChengBudengViewController.h"
#import "LiChengBuDengCell.h"
@interface LiChengBudengViewController ()
{
    

    
    
}
@end

@implementation LiChengBudengViewController

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
    
    self.thisTableView.tableFooterView = self.footFuckView;
    self.navigationController.navigationBarHidden = YES;
    
    
    
//    _nameArray =[[NSArray alloc] initWithObjects:@"旅客姓名",@"航班日期", @"航班号",@"出发机场",nil];
    
    
    
    _nameArray = [[NSArray alloc] initWithObjects:@"旅客姓名",@"航班日期",@"航班号",@"出发机场",@"到达机场",@"票号",@"舱位", nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_footFuckView release];
    [_thisTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFootFuckView:nil];
    [self setThisTableView:nil];
    [super viewDidUnload];
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
    return [self.nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    LiChengBuDengCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (cell==nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LiChengBuDengCell" owner:nil options:nil];
        cell =[array objectAtIndex:0];
        
    }
    // Configure the cell...
    cell.nameLabel.text =[_nameArray objectAtIndex:indexPath.row];
    
   
    
    if (indexPath.row==0||indexPath.row==2||indexPath.row==5) {
        
        cell.userInteractionEnabled = YES;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
    } else{
         cell.thisTextField.userInteractionEnabled = NO;
        cell.selectionStyle =UITableViewCellSelectionStyleGray;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    
    
    
    
    
    
    return cell;
}


//- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row==0||indexPath.row==2||indexPath.row==5) {
//        
//       
//        return nil;
//    }else{
//        
//        return  indexPath;
//    }
//
//    
//    
//}

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
