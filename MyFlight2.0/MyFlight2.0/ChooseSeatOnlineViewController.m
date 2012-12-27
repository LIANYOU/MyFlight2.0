//
//  ChooseSeatOnlineViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChooseSeatOnlineViewController.h"
#import "CheckInViewController.h"

@interface ChooseSeatOnlineViewController ()

@end

@implementation ChooseSeatOnlineViewController

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
    // Do any additional setup after loading the view from its nib.
    
    titleArray = [[NSArray alloc] initWithObjects:@"海南航空值机", @"中国国航值机", @"南方航空值机", nil];
    imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"l_GS.png"], [UIImage imageNamed:@"l_CA.png"], [UIImage imageNamed:@"l_SC.png"], nil];
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 132) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.rowHeight = 44.0f;
    [self.view addSubview:myTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:indexPath.row]];
    icon.frame = CGRectMake(10, 14, 16, 16);
    [cell addSubview:icon];
    [icon release];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(31, 14, 140, 16)];
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:16.0f];
    title.textAlignment = UITextAlignmentLeft;
    title.backgroundColor = [UIColor clearColor];
    [cell addSubview:title];
    [title release];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    arrow.frame = CGRectMake(293, 14, 12, 16);
    [cell addSubview:arrow];
    [arrow release];
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCLog(@"Choosed airport No.%d\n", indexPath.row + 1);
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
            
        default:
            break;
    }
    
    CheckInViewController *checkIn = [[CheckInViewController alloc] init];
    [self.navigationController pushViewController:checkIn animated:YES];
    [checkIn release];
}

@end
