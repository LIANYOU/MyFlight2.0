//
//  BaggageViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "BaggageViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
@interface BaggageViewController ()

@end

@implementation BaggageViewController
@synthesize myAirPortCode = _myAirPortCode;
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
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:215/255.0 blue:206/255.0 alpha:1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    //定义section字体
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    return cell;
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3GPlusPlatform/Web/AirportGuide.json"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"AirportCommonlyPhone" forKey:@"RequestType"];
    [request setPostValue:self.myAirPortCode forKey:@"ArilineCode"];
    [request setPostValue:CURRENT_DEVICEID forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        
        NSDictionary * dic = [str objectFromJSONString];
        NSLog(@"dic : %@",dic);
        [myTableView reloadData];
        
        
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}


@end
