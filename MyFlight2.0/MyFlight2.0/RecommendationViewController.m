//
//  RecommendationViewController.m
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "RecommendationViewController.h"

@interface RecommendationViewController ()

@end

@implementation RecommendationViewController

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
    NSURL *url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/recommend.jsp"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [request setPostValue:@"iphone" forKey:KEY_source];
    [request setPostValue:@"01" forKey:@"type"];
    
    [request setPostValue:HWID_VALUE forKey:KEY_hwId];
//    [request setPostValue:SOURCE_VALUE forKey:KEY_source];
    [request setPostValue:SERVICECode_VALUE forKey:KEY_serviceCode];
    [request setPostValue:EDITION_VALUE forKey:KEY_edition];
    
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
                [table reloadData];
                
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
                alertMessage = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"resultCode"] message:[result objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertMessage show];
                [alertMessage release];
            }
        }
    }];
    
    [request setFailedBlock:^(void){
        alertMessage = [[UIAlertView alloc] initWithTitle:@"" message:@"网络无响应，请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertMessage show];
        [alertMessage release];
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self requestForData];
    
    self.navigationItem.title = @"推荐软件";
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain];
    
    table.rowHeight = 70.0f;
    table.backgroundColor = FOREGROUND_COLOR;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    
    [self.view addSubview:table];
    [table release];
    
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
    if(responseDictionary != nil)
    {
        return [[responseDictionary objectForKey:@"recommend"] count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    
    NSDictionary *recommend = [[responseDictionary objectForKey:@"recommend"] objectAtIndex:indexPath.row];
    
    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[recommend objectForKey:@"logoPath"]]]];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:icon];
    
    image.frame = CGRectMake(7.5, 7.5, 55, 55);
    
    [cell addSubview:image];
    [image release];
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(80, 14, 210, 16)];
    
    label.text = [recommend objectForKey:@"name"];
    label.textColor = FONT_COLOR_DEEP_GRAY;
    label.font = [UIFont systemFontOfSize:16.0f];
    
    label.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(80, 44, 210, 12)];
    
    label.text = [recommend objectForKey:@"detail"];
    label.textColor = FONT_COLOR_DEEP_GRAY;
    label.font = [UIFont systemFontOfSize:12.0f];
    
    label.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:label];
    [label release];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
    
    arrow.frame = CGRectMake(296, 29, 9, 12);
    
    [cell addSubview:arrow];
    [arrow release];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return [cell autorelease];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *recommend = [[responseDictionary objectForKey:@"recommend"] objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[recommend objectForKey:@"path"]];
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
