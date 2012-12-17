//
//  AddLinkManViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AddLinkManViewController.h"
#import "GetLinkManInfo.h"
@interface AddLinkManViewController ()

@end

@implementation AddLinkManViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    linkMan = [[GetLinkManInfo alloc]init];
    linkManArray = [[NSMutableArray alloc]initWithCapacity:1];
    linkManArray = [linkMan getAllPersonNameAndPhone];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    [self.view addSubview:myTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [linkManArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 60, 30)];
    nameLabel.text = [[linkManArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    [cell addSubview:nameLabel];
    [nameLabel release];
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 3, 80, 30)];
    phoneLabel.text = [[linkManArray objectAtIndex:indexPath.row]objectForKey:@"phone"];
    [cell addSubview:phoneLabel];
    [phoneLabel release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)dealloc{
    [linkMan release];
    [myTableView release];
    [linkManArray release];
    [super dealloc];
}
@end
