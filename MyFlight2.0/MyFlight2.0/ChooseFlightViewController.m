//
//  ChooseFlightViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChooseFlightViewController.h"

@interface ChooseFlightViewController ()

@end

@implementation ChooseFlightViewController

@synthesize isQuery;

@synthesize passName;
@synthesize idNo;
@synthesize depCity;

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
    NSURL *url = [[NSURL alloc] initWithString:GET_RIGHT_URL_WITH_Index(@"/web/phone/prod/flight/huet/getCussSegHandler.jsp")];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:self.passName forKey:@"passName"];
    [request setPostValue:self.idNo forKey:@"idNo"];
    [request setPostValue:self.depCity forKey:@"depCity"];
    [request setPostValue:SOURCE_VALUE forKey:KEY_source];
    
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
                [passengerInfoTable reloadData];
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
    
    currentSelection = -1;
    
    UIButton *navigationLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    navigationLeftButton.frame = CGRectMake(10, 5, 30, 31);
    
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_.png"] forState:UIControlStateNormal];
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_click.png"] forState:UIControlStateHighlighted];
    
    [navigationLeftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navigationLeftBarItem = [[UIBarButtonItem alloc] initWithCustomView:navigationLeftButton];
    self.navigationItem.leftBarButtonItem = navigationLeftBarItem;
    [navigationLeftBarItem release];
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
    
    label.text = @"乘机人信息";
    label.textColor = FONT_COLOR_GRAY;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
    [label release];
    
    passengerInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 100) style:UITableViewStylePlain];
    
    passengerInfoTable.delegate = self;
    passengerInfoTable.dataSource = self;
    passengerInfoTable.allowsSelection = NO;
    passengerInfoTable.scrollEnabled = NO;
    
    passengerInfoTable.rowHeight = 50.0f;
    passengerInfoTable.backgroundColor = FOREGROUND_COLOR;
    passengerInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    passengerInfoTable.layer.borderColor = [BORDER_COLOR CGColor];
    passengerInfoTable.layer.borderWidth = 1.0f;
    passengerInfoTable.layer.cornerRadius = 10.0f;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, 80, 20)];
    
    label.text = @"选择要值机的航班";
    label.textColor = FONT_COLOR_GRAY;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
    [label release];
    
    flightInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, [UIScreen mainScreen].bounds.size.height < 500 ? 210:280) style:UITableViewStylePlain];
    
    flightInfoTable.delegate = self;
    flightInfoTable.dataSource = self;
    
    flightInfoTable.rowHeight = 70.0f;
    flightInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    flightInfoTable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:passengerInfoTable];
    [self.view addSubview:flightInfoTable];
    
    [passengerInfoTable release];
    [flightInfoTable release];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirm.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 370:450, 300, 40);
    
    [confirm addTarget:self action:@selector(confirmSelection) forControlEvents:UIControlEventTouchUpInside];
    
    [confirm setBackgroundImage:[UIImage imageNamed:@"orange_btn.png"] forState:UIControlStateNormal];
    [confirm setBackgroundImage:[UIImage imageNamed:@"orange_btn_click.png"] forState:UIControlStateHighlighted];
    
    if(isQuery)
    {
        [confirm setTitle:@"查询值机进度" forState:UIControlStateNormal];
    }
    else
    {
        [confirm setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    confirm.titleLabel.font = [UIFont systemFontOfSize:20];
    confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:confirm];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
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
    
    if(tableView == passengerInfoTable)
    {
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
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 48, 16)];
        
        switch (indexPath.row) {
            case 0:
                title.text = @"姓 名";
                break;
            case 1:
                title.text = @"身份证";
                break;
            default:
                break;
        }
        
        title.font = [UIFont systemFontOfSize:16.0f];
        title.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:title];
        [title release];
        
        UILabel *value = [[UILabel alloc]initWithFrame:CGRectMake(100, 17, 190, 16)];
        
        switch (indexPath.row) {
            case 0:
                value.text = self.passName;
                break;
            case 1:
                value.text = self.idNo;
                break;
            default:
                break;
        }
        
        value.font = [UIFont systemFontOfSize:16.0f];
        value.textColor = FONT_COLOR_DEEP_GRAY;
        value.textAlignment = NSTextAlignmentRight;
        value.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:value];
        [value release];
        
        cell.backgroundColor = FOREGROUND_COLOR;
    }
    else
    {
        UIView *flightInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        
        flightInfo.backgroundColor = FOREGROUND_COLOR;
        flightInfo.layer.borderColor = [BORDER_COLOR CGColor];
        flightInfo.layer.borderWidth = 1.0f;
        flightInfo.layer.cornerRadius = 10.0f;
        
        NSDictionary *flight = [[responseDictionary objectForKey:@"segs"] objectAtIndex:indexPath.row];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 50, 12)];
        
        label.text = [flight objectForKey:@"flightNo"];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        [flightInfo addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, 50, 12)];
        
        label.text = [NSString stringWithFormat:@"%@舱", [flight objectForKey:@"cabin"]];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        [flightInfo addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(65, 12, 120, 12)];
        
        label.text = [NSString stringWithFormat:@"%@ - %@", [flight objectForKey:@"deCity"], [flight objectForKey:@"arCity"]];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        [flightInfo addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(65, 36, 120, 12)];
        
        label.text = [NSString stringWithFormat:@"票号:%@", [flight objectForKey:@"tktNo"]];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        [flightInfo addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(195, 12, 75, 12)];
        
        label.text = [[[flight objectForKey:@"takeoffDateTime"] stringByReplacingCharactersInRange:NSMakeRange(0, 11) withString:@""] stringByReplacingCharactersInRange:NSMakeRange(8, 5) withString:@""];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        [flightInfo addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(195, 36, 75, 12)];
        
        label.text = [[flight objectForKey:@"takeoffDateTime"] stringByReplacingCharactersInRange:NSMakeRange(10, 14) withString:@""];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
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
        
        selectIcon.frame = CGRectMake(260, 8, 44, 44);
        
        [flightInfo addSubview:selectIcon];
        [selectIcon release];
        
        [cell addSubview:flightInfo];
        [flightInfo release];
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView != passengerInfoTable)
    {
        if(indexPath.row == currentSelection)
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

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) confirmSelection
{
    if(currentSelection != -1)
    {
        if([self isQuery])
        {
            FlightInformationViewController *flightInformation = [[FlightInformationViewController alloc] init];
            
            flightInformation.org = [responseDictionary objectForKey:@"departure"];
            flightInformation.passName = self.passName;
            flightInformation.idNo = self.idNo;
            
            [self.navigationController pushViewController:flightInformation animated:YES];
            [flightInformation release];
        }
        else
        {
            NSURL *url = [[NSURL alloc] initWithString:GET_RIGHT_URL_WITH_Index(@"/web/phone/prod/flight/huet/cussCheckHandler.jsp")];
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            
            [request setRequestMethod:@"POST"];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            
            NSDictionary *segs = [[responseDictionary objectForKey:@"segs"] objectAtIndex:currentSelection];
            
            [request setPostValue:[segs objectForKey:@"tktNo"] forKey:@"tktno"];
            [request setPostValue:self.passName forKey:@"passName"];
            [request setPostValue:self.idNo forKey:@"id"];
            [request setPostValue:[segs objectForKey:@"segIndex"] forKey:@"segIndex"];
            [request setPostValue:SOURCE_VALUE forKey:KEY_source];
            
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
                        
                        PickSeatViewController *pickSeat = [[PickSeatViewController alloc] init];
                        
                        pickSeat.tktno = [responseDict objectForKey:@"tktNo"];
                        pickSeat.segIndex = [responseDict objectForKey:@"segIndex"];
                        pickSeat.passName = [responseDict objectForKey:@"passName"];
                        pickSeat.airline = [responseDict objectForKey:@"airline"];
                        pickSeat.orgId = [responseDict objectForKey:@"orgId"];
                        pickSeat.org = [responseDict objectForKey:@"org"];
                        pickSeat.symbols = [responseDict objectForKey:@"symbols"];
                        
                        [self.navigationController pushViewController:pickSeat animated:YES];
                        [pickSeat release];
                    }
                    else
                    {
                        NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
                        // information incorrect
                    }
                }
            }];
            
            [request setFailedBlock:^(void){
                NSLog(@"JSON Request Failed\n");
            }];
            
            [request setDelegate:self];
            [request startAsynchronous];
        }
    }
    else
    {
        // error : must pick a flight
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
        return [[responseDictionary objectForKey:@"segs"] count];
    }
}

- (void) dealloc
{
    [responseDictionary release];
    
    [super dealloc];
}

@end
