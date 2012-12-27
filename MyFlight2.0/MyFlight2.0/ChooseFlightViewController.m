//
//  ChooseFlightViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChooseFlightViewController.h"
#import "FlightInformationViewController.h"
#import "PickSeatViewController.h"

@interface ChooseFlightViewController ()

@end

@implementation ChooseFlightViewController

@synthesize isQuery;

- (id) initWithNameAndID:(NSString *)name :(NSString *)ID
{
    self = [super init];
    if(self)
    {
        passengerName = [name retain];
        passengerID = [ID retain];
    }
    return self;
}

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
    
    passengerName = @"降枫";
    passengerID = @"123456789012345678";
    passengerTitleArray = [[NSArray alloc] initWithObjects:@"姓   名", @"身份证", nil];
    flightCount = 2;
    currentSelection = -1;
    
    NSArray *tempArray = [[NSArray alloc] initWithObjects:@"HU2345", @"x舱", @"北京首都-上海虹桥", @"票号:8888-88878", @"2012-09-23", @"09:03-10:23", nil];
    
    flightInfoArray = [[NSArray alloc] initWithObjects:tempArray, tempArray, nil];
    
    passengerInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 100) style:UITableViewStylePlain];
    
    passengerInfoTable.delegate = self;
    passengerInfoTable.dataSource = self;
    passengerInfoTable.scrollEnabled = NO;
    
    passengerInfoTable.rowHeight = 50.0f;
    passengerInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    passengerInfoTable.layer.borderWidth = 1.0f;
    passengerInfoTable.layer.cornerRadius = 5.0f;
    
    flightInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 70 * (flightCount + 1)) style:UITableViewStylePlain];
    
    flightInfoTable.delegate = self;
    flightInfoTable.dataSource = self;
    
    flightInfoTable.rowHeight = 70.0f;
    flightInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    flightInfoTable.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
    
    [self.view addSubview:passengerInfoTable];
    [self.view addSubview:flightInfoTable];
    
    [passengerInfoTable release];
    [flightInfoTable release];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(tableView == passengerInfoTable)
    {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 48, 16)];
        title.text = [passengerTitleArray objectAtIndex:indexPath.row];
        title.font = [UIFont systemFontOfSize:16.0f];
        title.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:title];
        [title release];
        
        UILabel *value = [[UILabel alloc]initWithFrame:CGRectMake(100, 17, 190, 16)];
        
        switch (indexPath.row) {
            case 0:
                value.text = passengerName;
                break;
            case 1:
                value.text = passengerID;
            default:
                break;
        }
        
        value.font = [UIFont systemFontOfSize:16.0f];
        value.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
        value.textAlignment = NSTextAlignmentRight;
        value.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:value];
        [value release];
        
        cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    }
    else
    {
        if(indexPath.row != flightCount)
        {
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *flightInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
            
            flightInfo.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
            flightInfo.layer.borderColor = [[UIColor grayColor] CGColor];
            flightInfo.layer.borderWidth = 1.0f;
            flightInfo.layer.cornerRadius = 5.0f;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:0];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 50, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:1];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 120, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:2];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, 120, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:3];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(190, 15, 75, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:4];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(190, 35, 75, 10)];
            label.text = [[flightInfoArray objectAtIndex:indexPath.row] objectAtIndex:5];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentLeft;
            
            [flightInfo addSubview:label];
            [label release];
            
            UIImageView *selectIcon;
            
            if(indexPath.row == currentSelection)
            {
                selectIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Selected.png"]];
            }
            else
            {
                selectIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Default"]];
            }
            
            selectIcon.frame = CGRectMake(270, 20, 20, 20);
            
            [flightInfo addSubview:selectIcon];
            [selectIcon release];
            
            [cell addSubview:flightInfo];
            [flightInfo release];
        }
        else
        {
            UIView *confirm = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            
            confirm.backgroundColor = [UIColor orangeColor];
            confirm.layer.borderColor = [[UIColor grayColor] CGColor];
            confirm.layer.borderWidth = 1.0f;
            confirm.layer.cornerRadius = 5.0f;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            
            if(isQuery)
            {
                label.text = @"查询值机进度";
            }
            else
            {
                label.text = @"确定";
            }
            
            label.font = [UIFont systemFontOfSize:20];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            
            [confirm addSubview:label];
            [label release];
            
            [cell addSubview:confirm];
            [confirm release];
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == passengerInfoTable)
    {
        return;
    }
    else
    {
        if(indexPath.row == flightCount)
        {
            if(currentSelection != -1)
            {
                CCLog(@"picked flight number %d\n", currentSelection + 1);
                if([self isQuery])
                {
                    FlightInformationViewController *flightInformation = [[FlightInformationViewController alloc] init];
                    [self.navigationController pushViewController:flightInformation animated:YES];
                    [flightInformation release];
                }
                else
                {
                    PickSeatViewController *pickSeat = [[PickSeatViewController alloc] init];
                    [self.navigationController pushViewController:pickSeat animated:YES];
                    [pickSeat release];
                }
            }
            else
            {
                CCLog(@"Warning: no flight picked\n");
                return;
            }
        }
        else if(indexPath.row == currentSelection)
        {
            currentSelection = -1;
            [tableView reloadData];
        }
        else
        {
            currentSelection = indexPath.row;
            [tableView reloadData];
        }
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == passengerInfoTable)
    {
        return 2;
    }
    else
    {
        return flightCount + 1;
    }
}

- (void) dealloc
{
    [passengerTitleArray release];
    [passengerName release];
    [passengerID release];
    
    [flightInfoArray release];
    
    [super dealloc];
}

@end
