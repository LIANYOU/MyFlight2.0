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
#import "UIButton+BackButton.h"
@interface BaggageViewController ()

@end

@implementation BaggageViewController
@synthesize myAirPortCode = _myAirPortCode;
@synthesize subAirPortData = _subAirPortData;
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
    self.title = @"行李规定";
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];

    
    
    array_section_open = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = BACKGROUND_COLOR;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height  -44) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.backgroundColor = [UIColor clearColor];
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
    NSLog(@"sectionCount : %d",[sectionCount count]);
    if ([sectionCount count] == 0) {
        return 0;
    }else{
        return [sectionCount count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flagOpenOrClose[section]) {
		return 1;
	} else {
		return 0;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];

    titleView.backgroundColor = FOREGROUND_COLOR;
    UIImageView * bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42,320, 2)];
    bottomImageView.backgroundColor = [UIColor colorWithRed:232/255.0 green:226/255.0 blue:221/255.0 alpha:1];
    [titleView addSubview:bottomImageView];
    [bottomImageView release];
    
    UILabel * companyNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 20)];
    companyNameLabel.backgroundColor = [UIColor clearColor];
    companyNameLabel.font = [UIFont systemFontOfSize:20];
    if (dataDic) {
        companyNameLabel.text = [[[dataDic objectForKey:@"provision"]objectAtIndex:section]objectForKey:@"arilineName"];
    }else{
        companyNameLabel.text = @"";
    }
    
    [titleView addSubview:companyNameLabel];
    [companyNameLabel release];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = section;
    btn.frame = CGRectMake(293, 6, 20, 20);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 10, 10)];
	
	if(flagOpenOrClose[section]){
		image.image = [UIImage imageNamed:@"triangle_icon_up.png"];
    }else{
		image.image = [UIImage imageNamed:@"triangle_icon_down.png"];
    }
	[btn addSubview:image];
	[image release];

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
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 320, 15)];
    [cell addSubview:label1];
    label1.textColor = FONT_COLOR_GRAY;
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:14];
    [label1 release];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 320, 15)];
    label2.textColor = FONT_COLOR_GRAY;
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont systemFontOfSize:14];
    [cell addSubview:label2];
    [label2 release];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 320, 15)];
    label3.textColor = FONT_COLOR_GRAY;
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:14];
    [cell addSubview:label3];
    [label3 release];
    
    
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 320, 15)];
    label4.textColor = FONT_COLOR_GRAY;
    label4.backgroundColor = [UIColor clearColor];
    label4.font = [UIFont systemFontOfSize:14];
    [cell addSubview:label4];
    [label4 release];
    
    UILabel * label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 85, 320, 15)];
    label5.textColor = FONT_COLOR_GRAY;
    label5.backgroundColor = [UIColor clearColor];
    label5.font = [UIFont systemFontOfSize:14];
    [cell addSubview:label5];
    [label5 release];
    
    if (dataDic) {
        
        NSLog(@"luggage : %@",[[[dataDic objectForKey:@"provision"]objectAtIndex:indexPath.section]objectForKey:@"luggage"]);
        NSArray * luggageArray = [NSArray arrayWithArray:[[[[dataDic objectForKey:@"provision"]objectAtIndex:indexPath.section]objectForKey:@"luggage"] componentsSeparatedByString:@" "]];
        NSMutableArray * afterLuggageArray = [[NSMutableArray alloc]initWithCapacity:0];
        for (int i = 0; i < [luggageArray count]; i++) {
            NSLog(@"%d -->:  %@",i,[luggageArray objectAtIndex:i]);
            if (i%2 == 1) {
                NSLog(@"kong");
            }else{
                [afterLuggageArray addObject:[luggageArray objectAtIndex:i]];
            }
        }
        NSLog(@"after : %d",[afterLuggageArray count]);
        label1.text = [afterLuggageArray objectAtIndex:0];
        label2.text = [afterLuggageArray objectAtIndex:1];
        label3.text = [afterLuggageArray objectAtIndex:2];
        label4.text = [afterLuggageArray objectAtIndex:3];
        label5.text = [afterLuggageArray objectAtIndex:4];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.userInteractionEnabled = NO;
    return cell;
}



-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSString * myUrl = [NSString stringWithFormat:@"%@3gWeb/api/provision.jsp",BASE_DOMAIN_URL];
//    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/provision.jsp"];
    
    NSURL * url = [NSURL URLWithString:myUrl];
    
    
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"iphone" forKey:@"source"];
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"1" forKey:@"edition"];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    NSLog(@"request :%@",request);
    
    [request setCompletionBlock:^{
        
        NSData * jsonData = [request responseData] ;
        
        NSString * temp = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * temp1= [temp stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        NSLog(@"temp : %@",temp);
        dataDic = [[NSMutableDictionary alloc]initWithDictionary:[temp1 objectFromJSONString]];
        NSLog(@"dic : %@",dataDic);
        sectionCount = [[NSArray alloc]initWithArray:[dataDic objectForKey:@"provision"]];
        NSLog(@"array : %d",[sectionCount count]);
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCount count];
        flagOpenOrClose = (BOOL *)malloc(size);
        memset(flagOpenOrClose, NO, size);

       
        [myTableView reloadData];
        
    }];

    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)cellOftitleTap:(UIButton *)btn{
    NSLog(@"btn click %d",btn.tag);
   	int sectionIndex = btn.tag;
	flagOpenOrClose[sectionIndex] = !flagOpenOrClose[sectionIndex];
    [myTableView beginUpdates];
	[myTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
	[myTableView endUpdates];

}


-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    self.subAirPortData = nil;
    self.myAirPortCode = nil;
    [dataDic release];
    [sectionCount release];
    [super dealloc];
}

@end
