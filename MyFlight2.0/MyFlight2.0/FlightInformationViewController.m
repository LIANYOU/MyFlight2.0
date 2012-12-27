//
//  FlightInformationViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightInformationViewController.h"

@interface FlightInformationViewController ()

@end

@implementation FlightInformationViewController

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
    
    detailedTitleArray = [[NSArray alloc] initWithObjects:@"票    号", @"值机状态", @"航班号", @"座位号", @"乘机人", nil];
    detailedValueArray = [[NSArray alloc] initWithObjects:@"999-85854411", @"已值机", @"hu2397", @"6A", @"降枫", nil];
    
    flightNumber = @"海航HU7141";
    
    departCity = @"北京";
    departTime = @"17:15";
    departDate = @"2012-8-20";
    departAirport = @"北京首都  T1";
    
    arrivalCity = @"成都";
    arrivalTime = @"17:15";
    arrivalDate = @"2012-8-20";
    arrivalAirport = @"北京首都  T1";
    
    detailedInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 220)];
    
    detailedInfoTable.rowHeight = 44.0f;
    detailedInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    detailedInfoTable.layer.borderWidth = 1.0f;
    detailedInfoTable.layer.cornerRadius = 5.0f;
    
    detailedInfoTable.delegate = self;
    detailedInfoTable.dataSource = self;
    detailedInfoTable.scrollEnabled = NO;
    
    flightInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 240, 300, 88)];
    
    flightInfoTable.rowHeight = 44.0f;
    flightInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    flightInfoTable.layer.borderWidth = 1.0f;
    flightInfoTable.layer.cornerRadius = 5.0f;
    
    flightInfoTable.delegate = self;
    flightInfoTable.dataSource = self;
    flightInfoTable.scrollEnabled = NO;
    
    [self.view addSubview:detailedInfoTable];
    [detailedInfoTable release];
    
    [self.view addSubview:flightInfoTable];
    [flightInfoTable release];
    
    cancelCheckInButtom.frame = CGRectMake(10, self.view.frame.size.height - 1100, self.view.frame.size.width - 20, 45);
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == detailedInfoTable)
    {
        return 5;
    }
    else
    {
        return 2;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(tableView == detailedInfoTable)
    {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 48, 10)];
        
        title.text = [detailedTitleArray objectAtIndex:indexPath.row];
        title.font = [UIFont systemFontOfSize:10.0f];
        title.textAlignment = UITextAlignmentCenter;
        title.textColor = [UIColor grayColor];
        title.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:title];
        [title release];
        
        UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(80, 16, 210, 12)];
        
        value.text = [detailedValueArray objectAtIndex:indexPath.row];
        value.font = [UIFont systemFontOfSize:12.0f];
        value.textAlignment = UITextAlignmentRight;
        value.textColor = [UIColor blackColor];
        value.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:value];
        [value release];
    }
    else
    {
        if(indexPath.row == 0)
        {
            UILabel *label;
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 14)];
            
            label.text = [NSString stringWithFormat:@"%@ - %@", departCity, arrivalCity];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 120, 14)];
            
            label.text = flightNumber;
            label.font = [UIFont systemFontOfSize:14.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
        }
        else
        {
            UILabel *label;
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, 80, 16)];
            
            label.text = departTime;
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(45, 11, 80, 10)];
            
            label.text = departDate;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(45, 25, 80, 10)];
            
            label.text = departAirport;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(175, 14, 80, 16)];
            
            label.text = departTime;
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(210, 11, 80, 10)];
            
            label.text = departDate;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(210, 25, 80, 10)];
            
            label.text = departAirport;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_airplane.png"]];
            
            image.frame = CGRectMake(129, 15, 42, 13);
            
            [cell addSubview:image];
            [image release];
        }
    }
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}

- (IBAction) cancelCheckIn:(UIButton *) sender
{
}

- (void) dealloc
{
    [detailedTitleArray release];
    [detailedValueArray release];
    
    [departCity release];
    [arrivalCity release];
    [flightNumber release];
    
    [departTime release];
    [departDate release];
    [departAirport release];
    [arrivalTime release];
    [arrivalDate release];
    [arrivalAirport release];
    
    [cancelCheckInButtom release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [cancelCheckInButtom release];
    cancelCheckInButtom = nil;
    [super viewDidUnload];
}

@end
