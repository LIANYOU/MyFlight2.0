//
//  MyCenterTable_1.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/27/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyCenterTable_1.h"
#import "MyCenterCell.h"
#import "MyCenterSecondCell.h"
#import "AppConfigure.h"
#import "PersonalInfoViewController.h"
#import "PersonInfotoShowViewController.h"
#import "MyCheapViewController.h"
#import "MyOrderListViewController.h"
#import "CommonContactViewController.h"
#import "MyCheapViewController.h"


#import "IsLoginInSingle.h"
#import "MyCenterUnLoginViewController.h"

#import "UIQuickHelp.h"
#import "PhoneReChargeViewController.h"
#import "LoginBusiness.h"

#import "UserAccount.h"

#import "MyLowOrderListViewController.h"
#import "CommonContact_LocalTmpDBHelper.h"

#import "UIButton+BackButton.h"
#import "CommonContact.h"

@interface MyCenterTable_1 ()
{
    
    UITableView * thistableView;
    NSArray *imageArray;
    NSArray *nameArray;
    
    
    
    
}

@end

@implementation MyCenterTable_1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}



- (void) loginOut{
    
    
    
    //    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    //
    //    [user setBool:false forKey:KEY_Default_IsUserLogin];
    //
    
    [[IsLoginInSingle shareLoginSingle] updateUserDefault];
    
    MyCenterUnLoginViewController *controller= [[MyCenterUnLoginViewController alloc] init];
    UINavigationController *con = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [controller release];
    
    [self presentModalViewController:con animated:YES];
    
    [con release];
    
    
}


#pragma mark -
#pragma mark 设置导航栏



- (void) setNav{
    
    UIButton * backBtn = [UIButton  backButtonType:2 andTitle:@"退出"];
    [backBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem=backBtn1;
    [backBtn1 release];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    cellsum = 1;
    [self setNav];
    
    nameResultArray =[[NSMutableArray alloc] init];
    
    LoginBusiness *busi = [[LoginBusiness alloc] init];
    
    NSString *memberId =Default_UserMemberId_Value;
    
    CCLog(@"在个人中心界面 memberId= %@",memberId);
    
    [busi getAccountInfoWithMemberId:memberId andDelegate:self];
    
    
    
    self.accountString = [NSString stringWithFormat:@"%d",0];
    self.allAccountMoneyString = [NSString stringWithFormat:@"%d",0];
    self.goldMoneyString =[NSString stringWithFormat:@"%d",0];
    self.silverMoneyString =[NSString stringWithFormat:@"%d",0];
    
    imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"icon_atv.png"],[UIImage imageNamed:@"icon_Coupon.png"],[UIImage imageNamed:@"icon_Recharge.png"] ,nil];
    nameArray =[[NSArray alloc] initWithObjects:@"常用联系人信息",@"我订阅的低价航线",@"用心愿旅行卡充值", nil];
    //    self.view.backgroundColor =View_BackGround_Color;
    
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
    
    return 3;
}




- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSInteger height= 44;
    
    if (indexPath.section ==0) {
        height = 44;
    }
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            height = 60;
        }
        
    }
    
    
    return height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSInteger number =0;
    
    if (section == 0) {
        return 1;
    } else if (section==1){
        
        return 2;
    } else{
        
        return 4;
    }
    
    
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    if (indexPath.section ==0) {
        
        NSLog(@"000000000000");
        static NSString *CellIdentifier = @"Cell";
        
        MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
            
            cell = [[[array objectAtIndex:0] retain] autorelease];
        }
        
        cell.titleLabel.text = @"个人资料";
//           cell.detailLabel.text = self.accountString;
        cell.thisImageView.image = [UIImage imageNamed:@"icon_acc.png"];
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {
        
        
        if (indexPath.row==0) {
            
            static NSString *CellIdentifier = @"second";
            
            MyCenterSecondCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterSecondCell" owner:self options:nil];
                
                cell = [[[array objectAtIndex:0] retain] autorelease];
            }
            
//            CCLog(@"金币*****%@",self.allAccountMoneyString);
            //
            //            if (cellsum == 1) {
            //                cell.accountMoneyLabel.text =@"888888";
            //            }else{
            //            cell.accountMoneyLabel.text =@"999999";
            //            }
            
            return  cell;
        }
        
        if (indexPath.row==1){
            
            
            static NSString *CellIdentifier = @"Cell_1";
            
            MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
                
                cell = [[[array objectAtIndex:0] retain] autorelease];
            }
            
            cell.titleLabel.text = @"我的优惠券";
            cell.detailLabel.text = @"";
            cell.thisImageView.image = [UIImage imageNamed:@"icon_Coupon.png"];
            
            return  cell;
            
        }
        
        
        
    }
    
    
    //第三分区
    if(indexPath.section==2){
        
        
        static NSString *CellIdentifier = @"Cell0";
        
        MyCenterCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
            
            cell = [[[array objectAtIndex:0] retain] autorelease];
        }
        
        
        if(indexPath.row==0){
            
            
            
            cell.titleLabel.text = @"我的订单";
            cell.detailLabel.text = @"未支付订单(1)";
            cell.thisImageView.image = [UIImage imageNamed:@"icon_Orders.png"];
            
        } else{
            
            
            cell.titleLabel.text = [nameArray objectAtIndex:indexPath.row-1];
            
            cell.thisImageView.image = [imageArray objectAtIndex:indexPath.row-1];
            cell.detailTextLabel.text =@"";
            
            
        }
        
        
        
        return  cell;
        
    }
    
    return  nil;
    
}





- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSLog(@"第%d分区 第%d行",indexPath.section,indexPath.row);
    
    id controller =nil;
    
    
    if (indexPath.section==0) {
        
        NSLog(@"第0分区执行");
        
        
        controller = [[PersonInfotoShowViewController alloc] init];
        
        
    }
    
    
    if (indexPath.section==1) {
        
        if (indexPath.row==1) {
            
            controller = [[MyCheapViewController alloc] init];
            
        }
        
    }
    
    
    if (indexPath.section==2) {
        
        switch (indexPath.row) {
            case 0:
                //我的订单列表
                controller = [[MyOrderListViewController alloc] init];
                
                break;
            case 1:
                //常用联系人
                controller = [[CommonContactViewController alloc] init];
                break;
            case 2:
                //低价预约
                controller= [[MyLowOrderListViewController alloc] init];
                break;
            case 3:
                //充值
                controller = [[PhoneReChargeViewController alloc] init];
                break;
                
            default:
                break;
        }
        
        
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
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
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    cellsum = 2;
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    IsLoginInSingle *userSingle = [IsLoginInSingle shareLoginSingle];
    
    self.accountString = Default_AccountName_Value;
    
    CCLog(@"返回的到个人中心首页；***************");
    CCLog(@"资金账户：%@",userSingle.userAccount.account);
    CCLog(@"金币：%@",userSingle.userAccount.xinlvGoldMoeny);
    CCLog(@"银币：%@",userSingle.userAccount.xinlvSilverMoney);
    CCLog(@"用户名为：%@",self.accountString);
    
    
    
    self.allAccountMoneyString= userSingle.userAccount.account;
    self.goldMoneyString= userSingle.userAccount.xinlvGoldMoeny;
    self.silverMoneyString= userSingle.userAccount.xinlvSilverMoney;
    //
    
    
    CCLog(@"资金账户：%@",self.allAccountMoneyString);
    CCLog(@"金币：%@",self.goldMoneyString);
    CCLog(@"银币：%@",self.silverMoneyString);
    CCLog(@"用户名为：%@",self.accountString);

    
    
    MyCenterSecondCell *secondCell =(MyCenterSecondCell *)[self.thisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    
    CCLog(@"更新cell 之前 ：%@", secondCell.accountMoneyLabel.text);
    
    //    cell.goldMoneyLabel.text = @"1311241";
    NSString *string = self.allAccountMoneyString;
    
    [secondCell.accountMoneyLabel setText:[NSString stringWithFormat:@"%@",_allAccountMoneyString]];
    
    
    [secondCell.goldMoneyLabel setText:[NSString stringWithFormat:@"%@",_goldMoneyString]];
    
    secondCell.silverMoneyLabel.text = [NSString stringWithFormat:@"%@",_silverMoneyString];
    
//    secondCell.silverMoneyLabel.text = _silverMoneyString;
    
    
    
    MyCenterCell *thisCell = (MyCenterCell *)[self.thisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    thisCell.detailLabel.text = [NSString stringWithFormat:@"%@",_accountString];
//    [thisCell.detailLabel setTextColor:[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]]
    
    CCLog(@"更新界面 金币 %@",self.allAccountMoneyString);
    CCLog(@"银币 %@",self.silverMoneyString);
    
    
    
    
//     [self.thisTableView reloadData];
    
    
}



- (void)dealloc {
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self.accountString =nil;
    self.allAccountMoneyString =nil;
    [_thisTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    //    [self setThisTableView:nil];
    [super viewDidUnload];
}
@end
