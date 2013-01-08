//
//  MyCheapViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyCheapViewController.h"
#import "MyCheapCell.h"
#import "SVSegmentedControl.h"
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
#import "MyCheapCouponHelper.h"
#import "CouponsInfo.h"
@interface MyCheapViewController (){
    
    NSArray *tmpArray;
    //    NSArray *uselistArray;
    //    NSArray *noUseListArray;
    //    NSArray *outOfDateListArray;
}

@end

@implementation MyCheapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
//    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonSystemItemSave target:self action:@selector(loginOut)];
//    
//    right.tintColor = [UIColor colorWithRed:35/255.0 green:103/255.0 blue:188/255.0 alpha:1];
//    
//    self.navigationItem.rightBarButtonItem = right;
//    
//    [right release];
    
    
}


- (void) initThisView{
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"未使用",@"已使用",@"已过期", nil];
    segmented = [[SVSegmentedControl alloc]initWithSectionTitles:titleNameArray];
    [titleNameArray release];
    segmented.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    segmented.textColor = myFirstColor;
    segmented.center = CGPointMake(160, 23);
    
    //segmented.thumb.backgroundImage = [UIImage imageNamed:@"tab.png"];
    
    segmented.height = 38;
    segmented.LKWidth = 100;
    
    segmented.thumb.textColor = mySceColor;
    segmented.thumb.tintColor = [UIColor whiteColor];
    segmented.thumb.textShadowColor = [UIColor clearColor];
    segmented.crossFadeLabelsOnDrag = YES;
    
    segmented.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    
    [segmented addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.headerView addSubview:segmented];
    
    
}


-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    NSInteger index = sender.selectedIndex;
    switch (index) {
        case 0:
            tmpArray = self.uselistArray;
            
            [self.thisTableView reloadData];
            break;
        case 1:
            tmpArray =self.noUseListArray;
            [self.thisTableView reloadData];
            break;
        case 2:
            
            
            
            tmpArray = self.outOfDateListArray;
            [self.thisTableView reloadData];
            break;
        default:
            break;
    }
    
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
    [self setNav];
    
    self.thisTableView.tableFooterView = self.tableFoot;
    
    //    uselistArray = [[NSArray alloc] init];
    //    noUseListArray = [[NSArray alloc] init];
    //    outOfDateListArray =[[NSArray alloc] init];
    //
    //    tmpArray = uselistArray;
    
    //    LoginBusiness *bis = [[LoginBusiness alloc] init];
    
    
    
    NSString *memberId =Default_UserMemberId_Value;
    
    [MyCheapCouponHelper getCouponInfoListWithMemberId:memberId andDelegate:self];
    
    //    [bis getCouponListWithMemberId:memberId andDelegate:self];
    
    
    
    // Do any additional setup after loading the view from its nib.
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
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    // Return the number of rows in the section.
    return [tmpArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyCheapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCheapCell" owner:nil options:nil];
        
        cell = [array objectAtIndex:0];
    }
    
    
    
    CouponsInfo *data = [tmpArray objectAtIndex:indexPath.row];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",data.price];
    
    
    NSString *string = [NSString stringWithFormat:@"有效期至%@至%@",data.dateStart,data.dateEnd];
    
    cell.youHuiQuanName.text = data.name;
    cell.moneyLabel.text= price;
    cell.timeLabel.text =string;
    if ([cell.timeLabel.text isEqualToString:@""]) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    } else{
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    [UIQuickHelp showAlertViewWithTitle:@"优惠券使用规则" message:@"本优惠券，只限单人单次单张使用，过期不侯，谢谢！！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}




#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    
    
    self.uselistArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfUse];
    self.noUseListArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfNoUse];
    self.outOfDateListArray = [[info objectForKey:@"resultDic"] objectForKey:KEY_CouponListOfOutOfDate];
    
    
    tmpArray = self.uselistArray;
    [self.thisTableView reloadData];
    
    CCLog(@"网络返回的数据count = %d",[tmpArray count]);
    
    
    
    
}



- (void)dealloc {
    [_thisTableView release];
    [_headerView release];
    [_tableFoot release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisTableView:nil];
    [self setHeaderView:nil];
    [self setTableFoot:nil];
    [super viewDidUnload];
}
@end
