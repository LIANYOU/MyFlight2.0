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
#import "UIButton+BackButton.h"
@interface ShowFligthConditionController ()

@end

@implementation ShowFligthConditionController
@synthesize deptAirPortCode = _deptAirPortCode,arrAirPortCode = _arrAirPortCode;
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
    self.title = @"航班动态";
    UIButton * cusBtn = [UIButton backButtonType:0 andTitle:@""];
    [cusBtn addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:cusBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    _myBlueColor = [[UIColor alloc]initWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1.0];
    _myGreenColor = [[UIColor alloc]initWithRed:81/255.0 green:147/255.0 blue:55/255.0 alpha:1.0];
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    self.showTableView.separatorColor = [UIColor clearColor];
    self.showTableView.backgroundColor = FOREGROUND_COLOR;
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
    
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 46 - 20 -40, 320, 46)];
    UIImageView * bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar.png"]];
    bottomImageView.frame = CGRectMake(0, 0, 320, 46);
    [bottomView addSubview:bottomImageView];
    [self.view addSubview:bottomView];
    
    
    //按时间排序 145 * 30
    sortBtnByTime = [[UIButton alloc]initWithFrame:CGRectMake(10, 6, 145, 30)];
    [sortBtnByTime setImage:[UIImage imageNamed:@"btn_black.png"] forState:UIControlStateNormal];
    [sortBtnByTime setImage:[UIImage imageNamed:@"btn_black_click.png"] forState:UIControlStateHighlighted];
    UILabel * sortByTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 125, 30)];
    sortByTimeLabel.textColor = [UIColor whiteColor];
    sortByTimeLabel.font = [UIFont systemFontOfSize:14];
    sortByTimeLabel.backgroundColor = [UIColor clearColor];
    sortByTimeLabel.textAlignment = NSTextAlignmentCenter;
    sortByTimeLabel.text = @"按时间排序";
    [sortBtnByTime addSubview:sortByTimeLabel];
    [sortByTimeLabel release];
    [sortBtnByTime addTarget:self action:@selector(sortByTime) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sortBtnByTime];
    
    //按状态排序
    sortBtnByState = [[UIButton alloc]initWithFrame:CGRectMake(165, 6, 145, 30)];
    [sortBtnByState setImage:[UIImage imageNamed:@"btn_black.png"] forState:UIControlStateNormal];
    [sortBtnByState setImage:[UIImage imageNamed:@"btn_black_click.png"] forState:UIControlStateHighlighted];
    UILabel * sortLabelByState = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 125, 30)];
    sortLabelByState.textColor = [UIColor whiteColor];
    sortLabelByState.font = [UIFont systemFontOfSize:14];
    sortLabelByState.backgroundColor = [UIColor clearColor];
    sortLabelByState.textAlignment = NSTextAlignmentCenter;
    sortLabelByState.text = @"按状态排序";
    [sortBtnByState addSubview:sortLabelByState];
    [sortLabelByState release];
    [sortBtnByState addTarget:self action:@selector(sortByState) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sortBtnByState];

    
}

-(void)sortByTime{
    NSLog(@"按时间排序");
 
    NSArray *resultArray = [self.dateArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [obj1 objectForKey:@"deptTime"];
        NSNumber *number2 = [obj2 objectForKey:@"deptTime"];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
    }];
    NSLog(@"[resultArray count] : %d",[resultArray count]);
    [self.dateArr removeAllObjects];
    [self.dateArr addObjectsFromArray:resultArray];
    NSLog(@"self.dateArr count : %d",[self.dateArr count]);
    [self.showTableView reloadData];
    
}
-(void)sortByState{
    NSLog(@"按状态排序");
    if (tempDataArray) {
        //计划
        NSMutableArray * array1 = [[NSMutableArray alloc]initWithCapacity:0];
        //起飞
        NSMutableArray * array2 = [[NSMutableArray alloc]initWithCapacity:0];
        //到达
        NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
        //延误
        NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
        //取消
        NSMutableArray * array5 = [[NSMutableArray alloc]initWithCapacity:0];
        for (int i = 0 ; i < [tempDataArray count]; i++) {
            NSDictionary * dic = [tempDataArray objectAtIndex:i];
            if ([[dic objectForKey:@"flightState"]isEqualToString:@"计划"]) {
                [array1 addObject:dic];
            }else if ([[dic objectForKey:@"flightState"]isEqualToString:@"起飞"]){
                [array2 addObject:dic];
            }else if ([[dic objectForKey:@"flightState"]isEqualToString:@"到达"]){
                [array3 addObject:dic];
            }else if ([[dic objectForKey:@"flightState"]isEqualToString:@"延误"]){
                [array4 addObject:dic];
            }else if ([[dic objectForKey:@"flightState"]isEqualToString:@"取消"]){
                [array5 addObject:dic];

            }
        }
        
        [tempDataArray removeAllObjects];
        [tempDataArray addObjectsFromArray:array1];
        [tempDataArray addObjectsFromArray:array2];
        [tempDataArray addObjectsFromArray:array3];
        [tempDataArray addObjectsFromArray:array4];
        [tempDataArray addObjectsFromArray:array5];
        [self.dateArr removeAllObjects];
        [self.dateArr addObjectsFromArray:tempDataArray];
        [self.showTableView reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [sortBtnByState release];
    [sortBtnByTime release];
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
    
//    self.dateArr = [[NSMutableArray alloc]initWithCapacity:0];
    NSDictionary *dic=[not userInfo];
    self.dateArr = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"arr"]];
    tempDataArray = [[NSMutableArray alloc]initWithArray:self.dateArr];
    
//    tempDataArray = [[NSMutableArray alloc]initWithArray:(NSArray *)[not userInfo]];
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
    return 50;
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
        
//        
//        UIView * backView = [[UIView alloc]initWithFrame:cell.bounds];
//        backView.backgroundColor = BACKGROUND_COLOR;
//        cell.selectedBackgroundView = backView;
//        [backView release];
        
        UIImageView * bottom1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, 320, 1)];
        bottom1.backgroundColor = LINE_COLOR;
        [cell addSubview:bottom1];
        [bottom1 release];
        
        UIImageView * bottom2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
        [cell addSubview:bottom2];
        bottom2.backgroundColor = [UIColor whiteColor];
        [bottom2 release];
        cell.highlighted = NO;
    }
    
    NSDictionary * dic = [self.dateArr objectAtIndex:indexPath.row];
    

    cell.flightCompany.text = [dic objectForKey:@"flightCompany"];
    cell.flightNum.text = [dic objectForKey:@"flightNum"];
    cell.deptAirport.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"deptAirport"],[dic objectForKey:@"flightHTerminal"]];
    cell.arrAirport.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"arrAirport"],[dic objectForKey:@"flightTerminal"]];
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
        cell.flightState.textColor = _myBlueColor;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [self.dateArr objectAtIndex:indexPath.row];
    DetailFlightConditionViewController * detail = [[DetailFlightConditionViewController alloc]init];
    detail.deptAirPortCode = self.deptAirPortCode;
    detail.arrAirPortCode = self.arrAirPortCode;
    
    detail.depAirPortData = self.DetailDepAirPortData;
    detail.arrAirPortData = self.DetailArrAirPortData;
    
    detail.dic = dic;
    detail.isAttentionFlight = YES;
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


-(void)cusBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
