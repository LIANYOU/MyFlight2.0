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
    array_section_open = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:215/255.0 blue:206/255.0 alpha:1];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-20-44) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([sectionCount count] == 0) {
        return 0;
    }else{
        return [sectionCount count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([[array_section_open objectAtIndex:indexPath.row] isEqualToString:@"open"]) {
//        return 44;
//    }else{
//        return 0;
//    }
//    return 0;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [UIColor redColor];
    UIImageView * bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42,320, 2)];
    bottomImageView.backgroundColor = [UIColor colorWithRed:232/255.0 green:226/255.0 blue:221255.0 alpha:1];
    [titleView addSubview:bottomImageView];
    [bottomImageView release];
    
    UILabel * companyNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 120, 20)];
    companyNameLabel.backgroundColor = [UIColor clearColor];
    companyNameLabel.font = [UIFont systemFontOfSize:17];
    companyNameLabel.text = @"compayName";
    [titleView addSubview:companyNameLabel];
    [companyNameLabel release];
//    UIImageView * accImageView = [[UIImageView alloc]initWithFrame:CGRectMake(293, 16, 10, 10)];
//    [accImageView setImage:[UIImage imageNamed:@"triangle_icon_down.png"]];
//    [titleView addSubview:accImageView];
//    [accImageView release];
    
//    UITapGestureRecognizer * tapOfCellTitle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellOftitleTap:)];
    
//    [titleView addGestureRecognizer:tapOfCellTitle];
//    [tapOfCellTitle release];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"triangle_icon_down.png"] forState:UIControlStateNormal];
    btn.tag = section;
    btn.frame = CGRectMake(293, 16, 10, 10);
    [btn addTarget:self action:@selector(cellOftitleTap:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn];
    
    return titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
//    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}



-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/provision.jsp"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"iphone" forKey:@"source"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v3.0" forKey:@"edition"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    NSLog(@"request :%@",request);
    
    //请求完成
    [request setCompletionBlock:^{
        
//        NSString * str = [request responseString] ;
//        NSLog(@"str: %@",str);
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * temp1= [temp stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        
        NSDictionary * dic = [temp1 objectFromJSONString];
        
        NSLog(@"dic : %@",dic);
        sectionCount = [dic objectForKey:@"provision"];
        NSLog(@"array : %d",[sectionCount count]);
        for (int i = 0; i < [sectionCount count]; i++) {
            if (i == 0) {
                NSString * string = [NSString stringWithFormat:@"%d",i];
                [array_section_open addObject:string];
            }else{
                NSString * string = [NSString stringWithFormat:@"%d",i];
                [array_section_open addObject:string];
            }
            NSLog(@"state array : %d",[array_section_open count]);
        }
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

-(void)cellOftitleTap:(UIButton *)btn{
    NSLog(@"btn click %d",btn.tag);
    for (NSString * str in array_section_open) {
//        str isEqualToString:<#(NSString *)#>
    }
    
    [myTableView reloadData];
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
}
@end
