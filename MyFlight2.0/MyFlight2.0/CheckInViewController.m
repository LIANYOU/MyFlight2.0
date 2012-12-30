//
//  CheckInViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController

- (id)initWithNibNameAndChoice:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    // Do any additional setup after loading the view from its nib.
    
    titleArray = [[NSArray alloc] initWithObjects:@"姓      名", @"证件类型", @"证件号码", @"出发机场", nil];
    
    passengerName = @"降枫";
    passportType = @"身份证";
    passportNumber = @"123456789012345678";
    departureAirport = @"北京首都机场";
    
    checkInInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 200) style:UITableViewStylePlain];
    
    checkInInfoTable.delegate = self;
    checkInInfoTable.dataSource = self;
    checkInInfoTable.scrollEnabled = NO;
    checkInInfoTable.rowHeight = 50.0f;
    checkInInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    checkInInfoTable.layer.borderWidth = 1.0;
    checkInInfoTable.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:checkInInfoTable];
    [checkInInfoTable release];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
}

- (void) leftNavigationBarItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) rightNavigationBarItemClicked
{
    return;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 64, 16)];
    
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:16.0f];
    title.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    [cell addSubview:title];
    [title release];
    
    UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
    
    switch (indexPath.row) {
        case 0:
            value.text = passengerName;
            break;
        case 1:
            value.text = passportType;
            break;
        case 2:
            value.text = passportNumber;
            break;
        case 3:
            value.text = departureAirport;
            break;
        default:
            break;
    }
    
    value.font = [UIFont systemFontOfSize:16.0f];
    value.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
    value.textAlignment = NSTextAlignmentRight;
    value.backgroundColor = [UIColor clearColor];
    [cell addSubview:value];
    [value release];
    
    if(indexPath.row == 1 || indexPath.row == 3)
    {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
        arrow.frame = CGRectMake(278, 15, 12, 16);
        [cell addSubview:arrow];
        [arrow release];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [registerforCheckIn release];
    [checkforProgress release];
    
    [titleArray release];
    [passengerName release];
    [passportType release];
    [passportNumber release];
    [departureAirport release];
    
    [super dealloc];
}
- (void)viewDidUnload
{
    [registerforCheckIn release];
    registerforCheckIn = nil;
    [checkforProgress release];
    checkforProgress = nil;
    [super viewDidUnload];
}

- (IBAction)checkIn:(UIButton *)sender
{
    CCLog(@"Ready to Check In\n");
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    chooseFlight.isQuery = NO;
    [self.navigationController pushViewController:chooseFlight animated:YES];
    [chooseFlight release];
}

- (IBAction) progressQuery:(UIButton *)sender
{
    CCLog(@"Query Check In Progress\n");
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    chooseFlight.isQuery = YES;
    [self.navigationController pushViewController:chooseFlight animated:YES];
    [chooseFlight release];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 1:
            CCLog(@"Change Passport Type\n");
            break;
        case 3:
            CCLog(@"Change Departure Airport\n");
            break;
        default:
            break;
    }
}

@end
