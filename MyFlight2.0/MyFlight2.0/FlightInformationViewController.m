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

@synthesize org;
@synthesize passName;
@synthesize idNo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) requestForData
{
    NSURL *url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/huet/getCussQueryHandler.jsp"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:self.org forKey:@"org"];
    [request setPostValue:@"HUAIRNEW" forKey:@"orgId"];
    [request setPostValue:self.passName forKey:@"passName"];
    [request setPostValue:self.idNo forKey:@"idNo"];
    [request setPostValue:@"1" forKey:@"currentPageNo"];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
        NSError *error = nil;
        
        [responseDictionary release];
        
        responseDictionary = [[response objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:&error] retain];
        
        if(error != nil)
        {
            NSLog(@"JSON Parse Failed\n");
        }
        else
        {
            NSLog(@"JSON Parse Succeeded\n");
            
            NSDictionary *result = [responseDictionary objectForKey:@"result"];
            
            if([[result objectForKey:@"resultCode"] isEqualToString:@""])
            {
                [detailedInfoTable reloadData];
                [flightInfoTable reloadData];
                
                for(NSString *string in [responseDictionary allKeys])
                {
                    NSLog(@"%@\n",string);
                }
                for(NSString *string in [responseDictionary allValues])
                {
                    NSLog(@"%@\n",string);
                }
            }
            else
            {
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        NSLog(@"JSON Request Failed\n");
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestForData];
    
    detailedTitleArray = [[NSArray alloc] initWithObjects:@"电子票号", @"值机状态", @"乘机人", @"座位号", @"登机号", @"登机时间", nil];
    
    detailedInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 264)];
    
    detailedInfoTable.rowHeight = 44.0f;
    detailedInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    detailedInfoTable.layer.borderWidth = 1.0f;
    detailedInfoTable.layer.cornerRadius = 5.0f;
    
    detailedInfoTable.delegate = self;
    detailedInfoTable.dataSource = self;
    detailedInfoTable.scrollEnabled = NO;
    
    flightInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 284, 300, 88)];
    
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
    
    UIButton *cancelCheckInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancelCheckInButton.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 370:450, 300, 40);
    
    cancelCheckInButton.backgroundColor = [UIColor orangeColor];
    cancelCheckInButton.layer.borderColor = [[UIColor grayColor] CGColor];
    cancelCheckInButton.layer.borderWidth = 1.0;
    cancelCheckInButton.layer.cornerRadius = 5.0;
    
    [cancelCheckInButton setTitle:@"取消值机" forState:UIControlStateNormal];
    [cancelCheckInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelCheckInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    cancelCheckInButton.titleLabel.font = [UIFont systemFontOfSize:20];
    cancelCheckInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [cancelCheckInButton addTarget:self action:@selector(cancelCheckIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelCheckInButton];
    
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
        return 6;
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
    else
    {
        for(UIView *view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary *cussInfo = [[responseDictionary objectForKey:@"cussInfo"] objectAtIndex:0];
    
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
        
        switch (indexPath.row) {
            case 0:
                value.text = [cussInfo objectForKey:@"etNo"];
                break;
            case 1:
                if([[cussInfo objectForKey:@"result"] isEqualToString:@"1"])
                {
                    value.text = @"已值机";
                    value.textColor = [UIColor greenColor];
                }
                break;
            case 2:
                value.text = [cussInfo objectForKey:@"name_ch"];
                break;
            case 3:
                value.text = [cussInfo objectForKey:@"seatNo"];
                break;
            case 4:
                value.text = [cussInfo objectForKey:@"bordingNo"];
                break;
            case 5:
                value.text = [NSString stringWithFormat:@"%@:%@", [[cussInfo objectForKey:@"bdt"] stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@""], [[cussInfo objectForKey:@"bdt"] stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""]];
                break;
            default:
                break;
        }
        
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
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 120, 14)];
            
            label.text = [NSString stringWithFormat:@"%@ - %@", [cussInfo objectForKey:@"departure_cn"], [cussInfo objectForKey:@"arrival_cn"]];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 120, 14)];
            
            label.text = [NSString stringWithFormat:@"%@%@", [cussInfo objectForKey:@"airlinecode"], [cussInfo objectForKey:@"airlineNo"]];
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
            
            label.text = [NSString stringWithFormat:@"%@:%@", [[cussInfo objectForKey:@"deptime"] stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@""], [[cussInfo objectForKey:@"deptime"] stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""]];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(45, 11, 80, 10)];
            
//            label.text = departDate;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(45, 25, 80, 10)];
            
//            label.text = departAirport;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(175, 14, 80, 16)];
            
//            label.text = departTime;
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(210, 11, 80, 10)];
            
//            label.text = departDate;
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = UITextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(210, 25, 80, 10)];
            
//            label.text = departAirport;
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

- (void) cancelCheckIn
{
    NSURL *url = [NSURL URLWithString:@"http://223.202.36.179:9580/web/phone/prod/flight/huet/getPwHandler.jsp"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    NSDictionary *cussInfo = [[responseDictionary objectForKey:@"cussInfo"] objectAtIndex:0];
    
    [request setPostValue:[cussInfo objectForKey:@"recNo"] forKey:@"recNo"];
    [request setPostValue:[cussInfo objectForKey:@"pwId"] forKey:@"pwId"];
    [request setPostValue:[cussInfo objectForKey:@"org"] forKey:@"org"];
    [request setPostValue:[cussInfo objectForKey:@"orgId"] forKey:@"orgId"];
    [request setPostValue:[responseDictionary objectForKey:@"passName"] forKey:@"passName"];
    [request setPostValue:[responseDictionary objectForKey:@"idNo"] forKey:@"idNo"];
    [request setPostValue:[cussInfo objectForKey:@"etNo"] forKey:@"etNo"];
    
    [request setCompletionBlock:^(void){
        
        NSData *response = [request responseData];
        
        NSError *error = nil;
        
        NSDictionary *responseDict = [response objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:&error];
        
        if(error != nil)
        {
            NSLog(@"JSON Parse Failed\n");
        }
        else
        {
            NSLog(@"JSON Parse Succeeded\n");
            
            NSDictionary *result = [responseDict objectForKey:@"result"];
            
            if([[result objectForKey:@"resultCode"] isEqualToString:@""])
            {
                for(NSString *string in [responseDict allKeys])
                {
                    NSLog(@"%@\n",string);
                }
                for(NSString *string in [responseDict allValues])
                {
                    NSLog(@"%@\n",string);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        NSLog(@"JSON Request Failed\n");
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void) dealloc
{
    [detailedTitleArray release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end
