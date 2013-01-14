//
//  MyOrderListViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "MyOrderListCell.h"
#import "MyOrderListCell.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
#import "LoginBusiness.h"
#import "OrderListModelData.h"
#import "DetailsOrderViewController.h"
#import "OrderDetaile.h"
#import "UIButton+BackButton.h"

#import "OrderDatabase.h"
#import "AppConfigure.h"

#import "MyLocalOrderListViewController.h"

#import "MyOrderListSingleDataSave.h"
@interface MyOrderListViewController ()


{
    NSArray *tmpArray;
}


@end

@implementation MyOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void) viewWillDisappear:(BOOL)animated{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewWillDisappear:animated];
}


- (void) initThisView{
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"未支付",@"待出行",@"全部", nil];
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
    [self.customView addSubview:segmented];
    
    //    [self.view addSubview:segmented];
    
    
}



-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSInteger index = sender.selectedIndex;
    switch (index) {
        case 0:
           
           
             tmpArray = self.noPaylistArray;
            
            
            [self.thisTableView reloadData];
            break;
        case 1:
            tmpArray =self.alreadlyListArray;
            [self.thisTableView reloadData];
            break;
        case 2:
            
            
            
            tmpArray = self.allOrderListArray;
            [self.thisTableView reloadData];
            break;
        default:
            break;
    }
    
    
    
}



- (void) setNav{
    
    UIButton * backBtn = [UIButton  backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
}

- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    CCLog(@"订单列表项目：%d",[tmpArray count]);
    
    
    BOOL flag1 =[[NSUserDefaults standardUserDefaults] boolForKey:KEY_IsHaveLocalOrderList];
    flag1 =true;
    
    if (flag1) {
        CCLog(@"存在本地订单");
        self.thisTableView.tableFooterView = self.thisFuckFootView;
        
    } 
    
    
    
    [self setNav];
    
    [self initThisView];
    
    
    
    
    MyOrderListSingleDataSave *single =[MyOrderListSingleDataSave shareMyOrderListSingleDataSave];
    
    self.noPaylistArray =single.noPayList;
    self.alreadlyListArray =single.alradyPayList;
    self.allOrderListArray =single.allPayList;
    
    
    tmpArray =self.noPaylistArray;

    CCLog(@"在订单列表界面 count = %d",[tmpArray count]);
    
    self.thisTableView.tableHeaderView = self.thisHeadView;
    [self.thisTableView reloadData];
    
//    LoginBusiness *bis = [[LoginBusiness alloc] init];
//    [bis getOrderListWithCurrentPage:@"1" rowsOfPage:@"100" andDelegate:self];
//    
//    [bis release];
    
    
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
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    // Return the number of rows in the section.
    return [tmpArray count];
}




- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    static NSString *CellIdentifier = @"Cell";
    
    MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyOrderListCell" owner:nil options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    OrderListModelData *data = [tmpArray objectAtIndex:indexPath.row];
    
    
    cell.totalMoney.text =data.totalMoney;
    cell.orderState.text = data.payStsCH;
    
    cell.areaInfo.text = [NSString stringWithFormat:@"%@-%@",data.depAirportName,data.arrAirportName];
    
    
    if ([data.payStsCH isEqualToString:@"未支付"]) {
       
        [cell.orderState setTextColor:FONT_Orange_Color];
        [cell.orderState setHighlightedTextColor:FONT_Orange_Color];
        
    }
    
    [UIQuickHelp setTableViewCellBackGroundColorAndHighLighted:cell];
    
    NSString *time = [data.createTime substringWithRange:NSMakeRange(0, 10)];
    
    
    
    cell.orderTime.text = time;
    
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderListModelData *data = [tmpArray objectAtIndex:indexPath.row];
    
    NSString *orderId =data.orderId;
    NSString *code = data.code;
    NSString *createTime =data.createTime;
    
    NSString *memberId = Default_UserMemberId_Value;
    NSString *token =Default_Token_Value;
    
    NSString *signTmp =[NSString stringWithFormat:@"%@%@%@",memberId,SOURCE_VALUE,token];
    
    NSString *sign =GET_SIGN(signTmp);
    
    CCLog(@"用户选择的订单号为%@",code);
    CCLog(@"订单日期 ;%@",createTime);
    CCLog(@"日期长度为：%d",[createTime length]);
    
    OrderDetaile *detail =[[OrderDetaile alloc] initWithOrderId:orderId andMemberId:memberId andCheckCode:code sndSign:sign sndSource:SOURCE_VALUE andHwId:HWID_VALUE andEdition:EDITION_VALUE andDelegate:nil];
    
    
    
    DetailsOrderViewController *con  =[[DetailsOrderViewController alloc] init];
    
    con.controllerFlag = @"orderListViewController";
    
    con.detaile = detail;
    
    
    [self.navigationController pushViewController:con animated:YES];
    
    
    
}



- (void)dealloc {
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [_thisTableView release];
    [_customView release];
    [_thisHeadView release];
    //    [_thisTableView release];
    [_thisFuckFootView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisTableView:nil];
    [self setCustomView:nil];
    [self setThisHeadView:nil];
    [self setThisTableView:nil];
    [self setThisFuckFootView:nil];
    [super viewDidUnload];
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
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self.noPaylistArray =[info objectForKey:@"noPayList"];
    
    self.alreadlyListArray =[info objectForKey:@"alreadyPayList"];
    self.allOrderListArray =[info objectForKey:@"allOrderList"];
    
    
    tmpArray =self.noPaylistArray;
    
    [self.thisTableView reloadData];
    
    
    
}


- (IBAction)lookForLocalOrderList:(id)sender {
    
    MyLocalOrderListViewController *controller =[[MyLocalOrderListViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
    
}
@end
