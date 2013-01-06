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
    
    UIButton *navigationLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    navigationLeftButton.frame = CGRectMake(10, 5, 30, 31);
    
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_.png"] forState:UIControlStateNormal];
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_click.png"] forState:UIControlStateHighlighted];
    
    [navigationLeftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navigationLeftBarItem = [[UIBarButtonItem alloc] initWithCustomView:navigationLeftButton];
    self.navigationItem.leftBarButtonItem = navigationLeftBarItem;
    [navigationLeftBarItem release];
    
    titleArray = [[NSArray alloc] initWithObjects:@"海南航空值机", @"中国国航值机", @"东方航空值机", @"南方航空值机", @"四川航空值机", @"厦门航空值机", nil];
    imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"l_HU.png"], [UIImage imageNamed:@"l_CA.png"], [UIImage imageNamed:@"l_MU.png"], [UIImage imageNamed:@"l_CZ.png"], [UIImage imageNamed:@"l_3U.png"], [UIImage imageNamed:@"l_MF.png"], nil];
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 264) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    
    myTableView.rowHeight = 44.0f;
    myTableView.backgroundColor = FOREGROUND_COLOR;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:myTableView];
    [myTableView release];
    
    self.view.backgroundColor = FOREGROUND_COLOR;
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIView *line;
    
    if(indexPath.row != 0)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
        
        line.backgroundColor = [UIColor whiteColor];
        
        [cell addSubview:line];
        [line release];
    }
    
    if(indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.rowHeight - 1, tableView.frame.size.width, 1)];
        
        line.backgroundColor = LINE_COLOR;
        
        [cell addSubview:line];
        [line release];
    }
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:indexPath.row]];
    
    icon.frame = CGRectMake(10, 14, 16, 16);
    
    [cell addSubview:icon];
    [icon release];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(31, 13.5f, 140, 17)];
    
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:17.0f];
    title.textColor = FONT_COLOR_DEEP_GRAY;
    title.textAlignment = UITextAlignmentLeft;
    title.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:title];
    [title release];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    
    arrow.frame = CGRectMake(296, 16, 9, 12);
    
    [cell addSubview:arrow];
    [arrow release];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckInViewController *checkIn;
    
    switch(indexPath.row)
    {
        case 0:
            checkIn = [[CheckInViewController alloc] init];
            
            [self.navigationController pushViewController:checkIn animated:YES];
            [checkIn release];
            break;
        default:
            break;
    }
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
