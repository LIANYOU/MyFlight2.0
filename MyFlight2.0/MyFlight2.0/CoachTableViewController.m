//
//  CoachTableViewController.m
//  MyFlight2.0
//
//  Created by apple on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "CoachTableViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
@interface CoachTableViewController ()

@end

@implementation CoachTableViewController
@synthesize orientationCoach;
@synthesize subAirPortData = _subAirPortData;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([sectionCount count] == 0) {
        return 0;
    }else{
        return [sectionCount count];
    }
    return 0;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (flagOpenOrClose[section]) {
		return 1;
	} else {
		return 0;
	}
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
    
    //1.起点：方庄
    UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 114, 33)];
    lineNameLabel.font = [UIFont systemFontOfSize:15];
    lineNameLabel.backgroundColor = [UIColor clearColor];
    [titleView addSubview:lineNameLabel];
    [lineNameLabel release];
    
    //运营时间
    UILabel * lineOperationTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 15, 100, 17)];
    lineOperationTimeLabel.font = [UIFont systemFontOfSize:13];
    lineOperationTimeLabel.backgroundColor = [UIColor clearColor];
    [titleView addSubview:lineOperationTimeLabel];
    [lineOperationTimeLabel release];
    
    
    //价格
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 13, 42, 21)];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textColor = FONT_COLOR_RED;
    [titleView addSubview:priceLabel];
    [priceLabel release];
    
    if (sectionCount) {
//        NSString * tempStr = [[sectionCount objectAtIndex:section]objectForKey:@"lineName"]compare:<#(NSString *)#> options:<#(NSStringCompareOptions)#>;
        lineNameLabel.text = @"";
        lineNameLabel.text = [[sectionCount objectAtIndex:section]objectForKey:@"lineName"];
        lineOperationTimeLabel.text = [[sectionCount objectAtIndex:section]objectForKey:@"lineOperationTime"];
        priceLabel.text = [[sectionCount objectAtIndex:section]objectForKey:@"lineFares"];
    }
    
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        UILabel * lineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 280, 17)];
        lineNameLabel.font = [UIFont systemFontOfSize:12];
        lineNameLabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:lineNameLabel];
        [lineNameLabel release];
        
        //首班车
        UILabel * firstBus = [[UILabel alloc]initWithFrame:CGRectMake(90, 23, 280, 17)];
        firstBus.backgroundColor = [UIColor clearColor];
        firstBus.font = [UIFont systemFontOfSize:12];
        firstBus.textColor = FONT_COLOR_GRAY;
        [cell addSubview:firstBus];
        [firstBus release];
        
        UILabel * firstBus1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 23, 280, 17)];
        firstBus1.backgroundColor = [UIColor clearColor];
        firstBus1.font = [UIFont systemFontOfSize:12];
        firstBus1.text = @"首 班 车：";
        [cell addSubview:firstBus1];
        [firstBus1 release];
        
        //末班车
        UILabel * lastBusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 43, 280, 17)];
        lastBusLabel1.backgroundColor = [UIColor clearColor];
        lastBusLabel1.text = @"末 班 车：";
        lastBusLabel1.font = [UIFont systemFontOfSize:12];
        [cell addSubview:lastBusLabel1];
        [lastBusLabel1 release];
        
        UILabel * lastBusLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 43, 280, 17)];
        lastBusLabel.backgroundColor = [UIColor clearColor];
        lastBusLabel.font = [UIFont systemFontOfSize:12];
        lastBusLabel.textColor = FONT_COLOR_GRAY;
        [cell addSubview:lastBusLabel];
        [lastBusLabel release];
        
        //间隔时间
        UILabel * lineIntervalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 63, 280, 17)];
        lineIntervalTimeLabel.backgroundColor = [UIColor clearColor];
        lineIntervalTimeLabel.font = [UIFont systemFontOfSize:11];
        lineIntervalTimeLabel.textColor = FONT_COLOR_GRAY;
        [cell addSubview:lineIntervalTimeLabel];
        [lineIntervalTimeLabel release];
        
        UILabel * lineIntervalTimeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 280, 17)];
        lineIntervalTimeLabel1.font = [UIFont systemFontOfSize:11];
        lineIntervalTimeLabel1.backgroundColor = [UIColor clearColor];
        lineIntervalTimeLabel1.text = @"时间间隔：";
        [cell addSubview:lineIntervalTimeLabel1];
        [lineIntervalTimeLabel1 release];
        
        
        //经停站点
        
        //初始化label
        UILabel *stopsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //设置自动行数与字符换行
        [stopsLabel setNumberOfLines:0];
        stopsLabel.backgroundColor = [UIColor clearColor];
        stopsLabel.font = [UIFont systemFontOfSize:11];
        stopsLabel.lineBreakMode = UILineBreakModeWordWrap;
        stopsLabel.textColor = FONT_COLOR_GRAY;
        stopsLabel.text = @"";
        [cell addSubview:stopsLabel];
        [stopsLabel release];

        if (sectionCount) {
            //线路名称
            lineNameLabel.text = [[sectionCount objectAtIndex:indexPath.section]objectForKey:@"lineName"];
            firstBus.text = [[sectionCount objectAtIndex:indexPath.section]objectForKey:@"firstBus"];
            lastBusLabel.text = [[sectionCount objectAtIndex:indexPath.section]objectForKey:@"lastBus"];
            lineIntervalTimeLabel.text = [[sectionCount objectAtIndex:indexPath.section]objectForKey:@"lineIntervalTime"];
            
            
            // 测试字串
            NSString * s = [[sectionCount objectAtIndex:indexPath.section]objectForKey:@"lineStops"];
            //设置一个行高上限
            CGSize size = CGSizeMake(320 - 110,2000);
            
            UIFont * myFont = [UIFont systemFontOfSize:11];
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [s sizeWithFont:myFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            [stopsLabel setFrame:CGRectMake(90,83,labelsize.width,labelsize.height)];
            stopsLabel.text = s;
        }

        
    }
    
    // Configure the cell...
        
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

-(void)getData{
    myData = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *  url = [NSURL URLWithString:@"http://223.202.36.172:8380/3gWeb/api/traffic.jsp"];
    
    //请求
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:@"1" forKey:@"edition"];
    [request setPostValue:self.subAirPortData.apCode forKey:@"ArilineCode"];
    
    
    [request setPostValue:@"0" forKey:@"TrafficType"];
    
    [request setPostValue:[NSString stringWithFormat:@"%d",self.orientationCoach] forKey:@"DrivingDirection"];
    NSLog(@"方向 : %d",self.orientationCoach);
    [request setPostValue:CURRENT_DEVICEID_VALUE forKey:@"hwId"];
    [request setPostValue:@"01" forKey:@"serviceCode"];
    [request setPostValue:@"v1.0" forKey:@"source"];
    
    //请求完成
    [request setCompletionBlock:^{
        NSString * str = [request responseString];
        
        NSDictionary * myDic = [str objectFromJSONString];
        NSLog(@"coachDic : %@",myDic);
        sectionCount = [[NSArray alloc]initWithArray:[myDic objectForKey:@"TrafficTools"]];
        
        NSLog(@"sectionCount : %d",[sectionCount count]);
        //判断开关状态
        int size = sizeof(BOOL *) * [sectionCount count];
        flagOpenOrClose = (BOOL *)malloc(size);
        memset(flagOpenOrClose, NO, size);
        
        [self.tableView reloadData];
        //填数据
//        [self fillData:myDic];
        
    }];
    //请求失败
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error : %@", error.localizedDescription);
    }];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}
-(void)refreshGetData{
    [self getData];
}
-(void)fillData:(NSDictionary *)dic{
    
}

//点击展开
-(void)cellOftitleTap:(UIButton *)btn{
    
    int sectionIndex = btn.tag;
	flagOpenOrClose[sectionIndex] = !flagOpenOrClose[sectionIndex];
    [self.tableView beginUpdates];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self.tableView endUpdates];
    
}
@end
