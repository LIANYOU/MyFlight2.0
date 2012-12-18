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
@synthesize delegate = _delegate;
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
    linkManArray = [NSArray arrayWithArray:[linkMan getAllPersonNameAndPhone]];
    //linkManArray = [linkMan getAllPersonNameAndPhone];
    NSLog(@"linkManArray : %d",[linkManArray count]);
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
    return [[linkMan getAllPersonNameAndPhone] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 60, 30)];
    nameLabel.text = [[[linkMan getAllPersonNameAndPhone] objectAtIndex:indexPath.row]valueForKey:@"name"];
    nameLabel.font = [UIFont systemFontOfSize:13];
    [cell addSubview:nameLabel];
    [nameLabel release];
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 3, 80, 30)];
    phoneLabel.text = [[[linkMan getAllPersonNameAndPhone] objectAtIndex:indexPath.row]valueForKey:@"phone"];
    phoneLabel.font = [UIFont systemFontOfSize:13];
    [cell addSubview:phoneLabel];
    [phoneLabel release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * chose = [[linkMan getAllPersonNameAndPhone] objectAtIndex:indexPath.row];
    [self.delegate oneManWasChosed:chose];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [linkMan release];
   // [myTableView release];
    [linkManArray release];
    [super dealloc];
}
@end
