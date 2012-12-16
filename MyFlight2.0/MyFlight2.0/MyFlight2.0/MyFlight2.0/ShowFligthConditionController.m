//
//  ShowFligthConditionController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-8.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ShowFligthConditionController.h"
#import "SearchFlightConditionCell.h"
#import "DetailFlightConditionViewController.h"
@interface ShowFligthConditionController ()

@end

@implementation ShowFligthConditionController

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
    _myBlueColor = [[UIColor alloc]initWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1.0];
    _myGreenColor = [[UIColor alloc]initWithRed:81/255.0 green:147/255.0 blue:55/255.0 alpha:1.0];
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 39.0f - self.showTableView.bounds.size.height, self.view.frame.size.width, self.showTableView.bounds.size.height)];
        view.delegate = self;
        [self.showTableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    
    [self.searchCondition searchFlightCondition];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_HeadView release];
    [_showTableView release];
    [_flightConditionCell release];
    [_myBlueColor release];
    [_myGreenColor release];
    [super dealloc];
}
- (void)viewDidUnload {
    _refreshHeaderView = nil;
    [_myBlueColor release];
    [_myGreenColor release];
    [self setHeadView:nil];
    [self setShowTableView:nil];
    [self setFlightConditionCell:nil];
    [super viewDidUnload];
}


-(void)receive:(NSNotification *)not //通过通知接收初始数据
{
    self.dateArr = [NSArray array];
    NSDictionary *dic=[not userInfo];
    self.dateArr = [dic objectForKey:@"arr"];
    
    [self.showTableView reloadData];
    
    _reloading = NO;
    
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.showTableView];
   
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section //设置不同section的header的高度
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * myView =[[[UIView alloc] init] autorelease];
    
    self.HeadView.frame = CGRectMake(0, 0, 320, 40);
    [myView addSubview:self.HeadView];
    
    return myView;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SearchFlightConditionCell *cell = (SearchFlightConditionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SearchFlightConditionCell" owner:self options:nil];
        cell = self.flightConditionCell;
    }
    
    NSDictionary * dic = [self.dateArr objectAtIndex:indexPath.row];
    
    cell.flightCompany.text = [dic objectForKey:@"flightCompany"];
    cell.flightNum.text = [dic objectForKey:@"flightNum"];
    cell.deptAirport.text = [dic objectForKey:@"deptAirport"];
    cell.arrAirport.text = [dic objectForKey:@"arrAirport"];
    cell.expectedDeptTime.text = [dic objectForKey:@"expectedDeptTime"];
    cell.expectedArrTime.text = [dic objectForKey:@"expectedArrTime"];
    cell.deptTime.text = [dic objectForKey:@"deptTime"];
    cell.arrTime.text = [dic objectForKey:@"arrTime"];
    cell.flightState.text = [dic objectForKey:@"flightState"];
    

    if ([[dic objectForKey:@"flightState"]isEqualToString:@"到达"]) {
        cell.flightState.textColor = _myGreenColor;
    }else if ([[dic objectForKey:@"flightState"]isEqualToString:@"延误"]){
        cell.flightState.textColor = [UIColor redColor];
    }else if([[dic objectForKey:@"flightState"]isEqualToString:@"取消"]){
        cell.flightState.textColor = [UIColor redColor];
    }else if([[dic objectForKey:@"flightState"]isEqualToString:@"起飞"]){
        cell.flightState.textColor = _myBlueColor;
    }else{
        cell.flightState.textColor = [UIColor blackColor];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [self.dateArr objectAtIndex:indexPath.row];
    DetailFlightConditionViewController * detail = [[DetailFlightConditionViewController alloc]init];
    detail.dic = dic;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

-(void)loadMore
{
    _reloading = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    
    [self.searchCondition searchFlightCondition];
}



- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self loadMore];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
