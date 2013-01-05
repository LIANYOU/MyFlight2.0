//
//  ChooseAirPortCompanyViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "ChooseAirPortCompanyViewController.h"
#import "AirPortCompanyData.h"
#import "AirCompanyDataBase.h"
@interface ChooseAirPortCompanyViewController ()

{
    
    NSArray *allCompannyArray;
    NSArray *tmpArray;

    NSInteger selectedIndex;
    
}


@end

@implementation ChooseAirPortCompanyViewController

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
    
    AirPortCompanyData *data = [[AirPortCompanyData alloc] init];
    data.shortName = @"";
    data.longName =@"";
    data.code = @"";
    
//    allCompannyArray = [[NSArray alloc] initWithObjects:@"深航",@"海航",@"国航",@"香港",@"东航",@"成都",@"南航", nil];
    
    allCompannyArray = [[AirCompanyDataBase findAllAirCompany] retain];
    
    tmpArray = allCompannyArray;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_thisTableView release];
    [allCompannyArray release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisTableView:nil];
    [super viewDidUnload];
}




#pragma mark -
#pragma mark TableViewDataSource
//设置每个分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
       
    return [tmpArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
  
    //重用机制
    static NSString *cellIdentity=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell==nil) {
        NSLog(@"新建一个cell");
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:cellIdentity];
    }
    
    AirPortCompanyData *data = [tmpArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = data.shortName;
    
    
    //具体定制每个列表项
//    cell.textLabel.text= [tmpArray objectAtIndex:indexPath.row];
    
    
    
    
    if ([cell.textLabel.text isEqualToString:self.selectedCompany]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedIndex = indexPath.row;
    } else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    //    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
    
}

//以上两个方法是必须的



//返回有几个分区，每个分区包含之前设置的行数
- (NSInteger ) numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

#pragma mark -
#pragma mark TableViewDelegate

//选择列表项时，需要的进行的操作
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (selectedIndex!=NSNotFound) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
    }
    
    
    
    selectedIndex = indexPath.row;
    
    UITableViewCell *thiscell = [tableView cellForRowAtIndexPath:indexPath];
    
    thiscell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    AirPortCompanyData *data = [[AirPortCompanyData alloc] init];
    
   AirPortCompanyData *data = [tmpArray objectAtIndex:indexPath.row];
    
//    data.shortName = [tmpArray objectAtIndex:indexPath.row];
    
      if (_delegate&&[_delegate respondsToSelector:@selector(ChooseAirPortCompanyViewController:DidChooseCompany:)]) {
        
        [_delegate ChooseAirPortCompanyViewController:self DidChooseCompany:data];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
           
}





@end
