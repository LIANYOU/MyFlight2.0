//
//  PostCityViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-13.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "PostCityViewController.h"
#import "CityDataBase_David.h"
#import "CityData_David.h"
#import "TraveController.h"
@interface PostCityViewController ()

@end

@implementation PostCityViewController

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
    
    
    self.provinceDic = [CityDataBase_David findAllCitiesSortedInKeys];
    
    self.derectDic = [CityDataBase_David findAllDerectCities];
    
    
    self.scetionTitleArr = [NSMutableArray arrayWithObject:@"直辖市"];
    for (NSString * str in [self.provinceDic allKeys]) {
        [self.scetionTitleArr addObject:str];
    }

    self.siftArr = [NSMutableArray arrayWithCapacity:10];
 
    self.showPostcityTableView.delegate = self;
    self.showPostcityTableView.dataSource = self;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_showPostcityTableView release];
    [_searchBar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowPostcityTableView:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.showPostcityTableView) {
        if (section == 0) {
            return @"直辖市";
        }
        else{
            return [[self.provinceDic allKeys] objectAtIndex:section-1];
        }
    }
    else{
        return nil;
    }
    
    
}


- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.scetionTitleArr;
        
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.showPostcityTableView) {
        return [[self.provinceDic allKeys] count] +1;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.showPostcityTableView) {
        if (section == 0) {
            return 4;
        }
        else{
            return [[self.provinceDic objectForKey:[[self.provinceDic allKeys] objectAtIndex:section-1]] count];
        }
    }
    
    else{
       
            self.siftArr = [CityDataBase_David findCityBySiftBy:self.searchBar.text];
            return self.siftArr.count;
   
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (tableView == self.showPostcityTableView) {
        if (indexPath.section == 0) {
            NSArray * arr1 = [self.derectDic objectForKey:@"直辖市"];
            
            CityData_David* city1 = [arr1 objectAtIndex:indexPath.row];
            
            cell.textLabel.text = city1.name;
            
        }
        else {
            
            NSArray * allkeys = [self.provinceDic allKeys] ;
            NSString * key = [allkeys objectAtIndex:indexPath.section-1];
            NSArray * objectArr = [self.provinceDic objectForKey:key];
            CityData_David * city = [objectArr objectAtIndex:indexPath.row];
            
            
            cell.textLabel.text = city.name;
            
        }
        return cell;

    }
    else{
        CityData_David * city = [self.siftArr objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        
        return cell;
    }

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityData_David * city = nil;
    
    if (tableView == self.showPostcityTableView) {
        if (indexPath.section == 0) {
            NSArray * arr = [self.derectDic objectForKey:@"直辖市"];
           city = [arr objectAtIndex:indexPath.row];

        }
        else{
          
            NSArray * allKeys = [self.provinceDic allKeys];
            NSString * key = [allKeys objectAtIndex:indexPath.section-1];
            NSArray * object = [self.provinceDic objectForKey:key];
           city = [object objectAtIndex:indexPath.row];
            
  
        }
       
    }
    else{
           city = [self.siftArr objectAtIndex:indexPath.row];
        
    }
    
    NSLog(@"------------  %@",city.name);
    
    blocks(city.name);
   
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)getDate:(void (^) (NSString * idntity))string{
    [blocks release];
    blocks = [string copy];
}



@end
