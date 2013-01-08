//
//  AddPersonViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/27/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "AddPersonViewController.h"

#import "AddPersonCell0.h"
@interface AddPersonViewController ()
{
    NSArray *name1Array;
    
    NSArray *name2Array;
    
    NSArray *placeHold1Array;
    NSArray *placeHold2Array;
    
    NSArray *tempNameArray;
    
    BOOL isPersonHigh;
    
}
@end

@implementation AddPersonViewController

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
    isPersonHigh = true;
    
    name2Array =[[NSArray alloc] initWithObjects:@"身份",@"姓名",@"证件类型",@"证件号码",@"生日",@"保存常用联系人",nil];
    
    name1Array = [[NSArray alloc] initWithObjects:@"身份",@"姓名",@"证件类型",@"证件号码",@"保存常用联系人",nil];
    placeHold1Array = [[NSArray alloc] initWithObjects:@"身份类型",@"请输入姓名",@"请选择证件类型",@"请填写证件号码",@"请选择生日",nil];
    
    placeHold2Array =[[NSArray alloc] initWithObjects:@"身份类型",@"请输入姓名",@"请选择证件类型",@"请填写证件号码",nil];
    
    tempNameArray = name1Array;
    
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
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    
    if (isPersonHigh) {
        
        if (indexPath.row==0||indexPath.row==2) {
            
            static NSString *CellIdentifier = @"Cell0";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AddPersonCell" owner:self options:nil];
                
                cell  = [array objectAtIndex:0];
    
            }
            
            
            AddPersonCell0 *thisCell = (AddPersonCell0 *) cell;
            
            if (indexPath.row==0) {
                
                
                thisCell.nameLabel.text = @"身份";
                thisCell.detailLabel.text =@"成人";
                
                
            } else{
                
                thisCell.nameLabel.text = @"证件类型";
                thisCell.detailLabel.text =@"身份证";
                
            }
             
            
                 
        }

        
        
        
        
        
        
        
        
        
        
    }
    
    
        
    
    
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
       
    
    
}



@end
