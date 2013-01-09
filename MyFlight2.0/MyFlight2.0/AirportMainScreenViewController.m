//
//  airportScreenViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-29.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AirportMainScreenViewController.h"

@interface AirportMainScreenViewController ()

@end

@implementation AirportMainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) refresh
{
    if(pageNum == 1)
    {
        [search setLeftIconInvisible];
    }
    else
    {
        [search setLeftIconVisible];
    }
    
    if(responseDictionary != nil)
    {
        if([[NSString stringWithFormat:@"%d", pageNum] isEqualToString:[responseDictionary objectForKey:@"totalPage"]])
        {
            [search setRightIconInvisible];
        }
        else
        {
            [search setRightIconVisible];
        }
    }
    else
    {
        [search setRightIconInvisible];
    }
}

- (void) requestForData:(NSString *) flightNo
{
    NSURL *url = [[NSURL alloc] initWithString:GET_RIGHT_URL_WITH_Index(@"/web/phone/prod/flight/screen.jsp")];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    [request setRequestMethod:@"POST"];
    
    [request setPostValue:titlebar.apCode forKey:@"airport"];
    
    if(titlebar.isIncoming)
    {
        [request setPostValue:@"1" forKey:@"type"];
    }
    else
    {
        [request setPostValue:@"0" forKey:@"type"];
    }
    
    [request setPostValue:[NSString stringWithFormat:@"%d", pageNum] forKey:@"pageNum"];
    [request setPostValue:EDITION_VALUE forKey:KEY_edition];
    
    if(flightNo != nil)
    {
        [request setPostValue:flightNo forKey:@"flightNo"];
    }
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setCompletionBlock:^{
        
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
                NSLog(@"Refreshing Screen");
                
                [screenTitle reloadData];
                [screenValue reloadData];
                
                if(flightNo != nil)
                {
                    [self updatePageNumber];
                }
                
                [self refresh];
            }
            else
            {
                NSLog(@"%@,%@\n", [result objectForKey:@"resultCode"], [result objectForKey:@"message"]);
            }
        }
    }];
    

    [request setFailedBlock:^{
        NSLog(@"JSON Request Failed\n");
    }];

    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pageNum = 1;

    titlebar = [[AirportMainScreenTitleView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    titlebar.delegate = self;
    titlebar.apCode = @"PEK";
    titlebar.apName = @"北京首都";
    
    [titlebar reloadApName];
    
    [self.view addSubview:titlebar];
    [titlebar release];
    
    [self requestForData:nil];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 135, 10)];
    
    header.backgroundColor = [UIColor blackColor];
    
    UILabel *title;
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 60, 10)];
    title.text = @"航班号";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 45, 10)];
    title.text = @"状态";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    [self.view addSubview:header];
    [header release];
    
    screenTitle = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, 135, [UIScreen mainScreen].bounds.size.height < 500 ? 330:390) style:UITableViewStylePlain];
    
    screenTitle.rowHeight = 30.0f;
    screenTitle.separatorStyle = UITableViewCellSeparatorStyleNone;
    screenTitle.bounces = NO;
    screenTitle.scrollEnabled = YES;
    screenTitle.showsVerticalScrollIndicator = NO;
    
    screenTitle.dataSource = self;
    screenTitle.delegate = self;
    screenTitle.allowsSelection = NO;
    
    [self.view addSubview:screenTitle];
    [screenTitle release];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(135, 80, 185, [UIScreen mainScreen].bounds.size.height < 500 ? 340:400)];
    
    scroll.clipsToBounds = YES;
    scroll.contentSize = CGSizeMake(505, [UIScreen mainScreen].bounds.size.height < 500 ? 340:400);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.bounces = NO;
    
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 505, 10)];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 10)];
    title.text = @"计划出发";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 60, 10)];
    title.text = @"实际出发";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 60, 10)];
    title.text = @"计划到达";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 60, 10)];
    title.text = @"实际到达";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 100, 10)];
    title.text = @"目的地机场";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(350, 0, 30, 10)];
    title.text = @"航站楼";
    title.textAlignment = UITextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    
    [header addSubview:title];
    [title release];
    
    header.backgroundColor = [UIColor blackColor];
    
    [scroll addSubview:header];
    [header release];
    
    screenValue = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 505, [UIScreen mainScreen].bounds.size.height < 500 ? 330:390) style:UITableViewStylePlain];
    
    screenValue.rowHeight = 30.0f;
    screenValue.separatorStyle = UITableViewCellSeparatorStyleNone;
    screenValue.bounces = NO;
    screenValue.scrollEnabled = YES;
    screenValue.showsVerticalScrollIndicator = NO;
    
    screenValue.dataSource = self;
    screenValue.delegate = self;
    screenValue.allowsSelection = NO;
    
    [scroll addSubview:screenValue];
    [screenValue release];
    
    [self.view addSubview:scroll];
    [scroll release];
    
    search = [[AirportMainScreenSearchView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 500 ? 420:480, 320, [UIScreen mainScreen].bounds.size.height < 500 ? 40:68)];
    
    search.delegate = self;
    
    [self.view addSubview:search];
    [search release];
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
    return 25;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    else
    {
        for(UIView *view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    NSArray *flightArray = [responseDictionary objectForKey:@"flight"];
    
    UIView *block;
    
    if(tableView == screenTitle)
    {
        block = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 135, 30)];
        
        switch(indexPath.row % 2)
        {
            case 0:
                block.backgroundColor = [UIColor colorWithRed:0.15f green:0.175f blue:0.2f alpha:1.0f];
                break;
            case 1:
                block.backgroundColor = [UIColor colorWithRed:0.2f green:0.225f blue:0.25f alpha:1.0f];
                break;
            default:
                break;
        }
        
        if(indexPath.row < flightArray.count)
        {
            NSDictionary *flightInfo = [flightArray objectAtIndex:indexPath.row];
            
            NSString *string = [flightInfo objectForKey:@"flightNo"];
            
            char A = [string characterAtIndex:0];
            char B = [string characterAtIndex:1];
            
            string = [NSString stringWithFormat:@"l_%c%c", A, B];
            
            UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:string]];
            
            icon.frame = CGRectMake(5, 5, 20, 20);
            icon.backgroundColor = [UIColor clearColor];
            
            [block addSubview:icon];
            [icon release];
            
            UILabel *label;
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 60, 20)];
            
            label.text = [flightInfo objectForKey:@"flightNo"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 45, 20)];
            
            label.text = [flightInfo objectForKey:@"sts"];
            label.textAlignment = UITextAlignmentLeft;
            
            if([label.text isEqualToString:@"起飞"])
            {
                label.textColor = [UIColor greenColor];
            }
            else if([label.text isEqualToString:@"延误"])
            {
                label.textColor = [UIColor orangeColor];
            }
            
            label.font = [UIFont systemFontOfSize:18.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
        }
        
        [cell addSubview:block];
        [block release];
    }
    else
    {
        block = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 505, 30)];
        
        switch(indexPath.row % 2)
        {
            case 0:
                block.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.0f];
                break;
            case 1:
                block.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
                break;
            default:
                break;
        }
        
        if(indexPath.row < flightArray.count)
        {
            NSDictionary *flightInfo = [flightArray objectAtIndex:indexPath.row];
            
            UILabel *label;
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
            
            label.text = [flightInfo objectForKey:@"planStartTime"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 60, 20)];
            
            label.text = [flightInfo objectForKey:@"realStartTime"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 60, 20)];
            
            label.text = [flightInfo objectForKey:@"planEndTime"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(190, 5, 60, 20)];
            
            label.text = [flightInfo objectForKey:@"realEndTime"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(250, 5, 100, 20)];
            
            label.text = [flightInfo objectForKey:@"arrAirport"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(350, 5, 30, 20)];
            
            label.text = [flightInfo objectForKey:@"arrTerminal"];
            label.textAlignment = UITextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            
            [block addSubview:label];
            [label release];
        }
        
        [cell addSubview:block];
        [block release];
    }
    
    return cell;
}

- (void) dealloc
{
    [responseDictionary release];
    
    [super dealloc];
}

- (void) back
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) updatePageNumber
{
    pageNum = 0;
    
    for(unsigned int i = 0; i < [[responseDictionary objectForKey:@"currentPage"] length]; i++)
    {
        pageNum = pageNum * 10 + [[responseDictionary objectForKey:@"currentPage"] characterAtIndex:i] - '0';
    }
}

- (void) nextPage
{
    pageNum ++;
    
    [self refresh];
    [self requestForData:nil];
}

- (void) previousPage
{
    pageNum --;
    
    [self refresh];
    [self requestForData:nil];
}

- (void) search:(NSString *)flightNo
{
    [self refresh];
    [self requestForData:flightNo];
}

- (void) chooseAirPort:(NSString *)apName
{
    ChooseAirPortViewController *chooseAp = [[ChooseAirPortViewController alloc] init];
    
    chooseAp.delegate = self;
    
    [self presentViewController:chooseAp
                       animated:YES
                     completion:^(void){
                         [chooseAp release];
                     }];
}

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPort
{
    titlebar.apCode = airPort.apCode;
    titlebar.apName = airPort.apName;
    
    [titlebar reloadApName];
    [self requestForData:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == screenTitle)
    {
        screenValue.contentOffset = screenTitle.contentOffset;
    }
    else if(scrollView == screenValue)
    {
        screenTitle.contentOffset = screenValue.contentOffset;
    }
}

@end
