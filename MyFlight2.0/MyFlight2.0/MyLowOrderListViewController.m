//
//  MyLowOrderListViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "MyLowOrderListViewController.h"
#import "ListCell.h"
#import "UIButton+BackButton.h"
#import "UIQuickHelp.h"
#import "PublicConstUrls.h"
#import "NoticeLow.h"
#import "AppConfigure.h"
#import "ProBookListData.h"
#import "ProBooKResultData.h"
#import "SamllCell.h"
#import "LowOrderController.h"
#import "DeleteOrderList.h"
@interface MyLowOrderListViewController ()

@end

@implementation MyLowOrderListViewController

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
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    self.showTableView.tableFooterView = self.footView;
    self.showTableView.tableHeaderView = self.headView;
    
    self.navigationItem.title = @"我预约的低价航线";
    
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    UIButton * histroyBut = [UIButton backButtonType:6 andTitle:@""];
    [histroyBut addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString * string = [NSString stringWithFormat:@"%@%@%@",Default_UserMemberId_Value,SOURCE_VALUE,Default_Token_Value];
    
    NoticeLow * notice ;
    
    if (Default_IsUserLogin_Value) {
        notice = [[NoticeLow alloc] initWithSource:SOURCE_VALUE andMemberId:Default_UserMemberId_Value andSign:GET_SIGN(string) andHwId:HWID_VALUE andDelegate:self];
    }
    else{
        notice = [[NoticeLow alloc] initWithSource:SOURCE_VALUE andMemberId:nil andSign:nil andHwId:HWID_VALUE andDelegate:self];
    }
    
    [notice getInfo];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)add{
    
    
//    if (self.dataArr.count>=5) {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您最多可预约5条航线" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//        return;
//    }
    LowOrderController * low = [[LowOrderController alloc] init];
    [self.navigationController pushViewController:low animated:YES];
    [low release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [_showTableView release];
  
    [_list release];
    [_headView release];
    [_footView release];
    [_smallCell release];
    [super dealloc];
}
- (void)viewDidUnload {

    [self setShowTableView:nil];
 
    [self setList:nil];
    [self setHeadView:nil];
    [self setFootView:nil];
    [self setSmallCell:nil];
    [super viewDidUnload];
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    ProBooKResultData *data =[self.dataArr objectAtIndex:indexPath.row];
    BOOL flag = data.flag;
    
    if (flag) {
        return 110;
    } else{
        
        return 54;
    }






}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProBooKResultData *data =[self.dataArr objectAtIndex:indexPath.row];
    
    BOOL flag = data.flag;
    
    
    UITableViewCell *cell =nil;

    
    if (!flag) {
        
        static NSString *CellIdentifier = @"Cell1";
      
        cell = [self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"SamllCell" owner:self options:nil];
            
            
            cell = [array objectAtIndex:0];
        }
        SamllCell *thisCell =(SamllCell *) cell;
        
        thisCell.startName.text = data.allData.dptCN;
        thisCell.endName.text = data.allData.arrCN;
        thisCell.startDate.text = data.allData.startDate;
        thisCell.endDate.text = data.allData.endDate;
        thisCell.discount.text = data.allData.discount;
        
        thisCell.selectionStyle = 0;
        
        
        
        thisCell.closeBtn.tag = indexPath.row;
        [thisCell.closeBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    else{
        
        
        static NSString *CellIdentifier = @"Cell2";
        cell = [self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
           NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil];
           cell = [array objectAtIndex:0];
        }
        ListCell *thisCell =(ListCell *) cell;
        thisCell.startName.text = data.allData.dptCN;
        thisCell.endName.text = data.allData.arrCN;
        thisCell.startDate.text = data.allData.startDate;
        thisCell.endDate.text = data.allData.endDate;
        thisCell.discount.text = data.allData.discount;
        
        flightListTemp * temp = [data.listArray objectAtIndex:0];
        thisCell.searchDate.text = temp.startDate;
        thisCell.searchDiscount.text = temp.diccount;
        thisCell.searchPay.text = temp.price;
    
    
        thisCell.selectionStyle = 0;
        
        thisCell.closeBtn.tag = indexPath.row;
        [thisCell.closeBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
     }

    
return cell;

}



-(void)del:(UIButton *)btn
{
    ProBooKResultData *data =[self.dataArr objectAtIndex:btn.tag];
    NSLog(@"%@",data.allData.code);
    DeleteOrderList * dele = [[DeleteOrderList alloc] initWithCode:data.allData.code
                                                           andHwId:HWID_VALUE
                                                       andDelegate:self];
    [dele deleteOrderList];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark -

//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    NSString * meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
}

//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    NSString * meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{

    self.dataArr = [info objectForKey:@"dic"];
    
   CCLog(@"网络返回的数据信息 count = %@",self.dataArr);
    
        
    
    [self.showTableView reloadData];

}

@end
