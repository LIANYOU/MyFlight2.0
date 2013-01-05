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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"icon_atv.png"],[UIImage imageNamed:@"icon_Coupon.png"],[UIImage imageNamed:@"icon_Recharge.png"] ,nil];
    nameArray =[[NSArray alloc] initWithObjects:@"常用联系人信息",@"我订阅的低价航线",@"用心愿旅行卡充值", nil];
    self.view.backgroundColor =View_BackGround_Color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 3;
}


//
//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//
//    return 20;
//
//}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger height= 50;
    
    if (indexPath.section ==0) {
        height = 50;
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
    
    
    
    
    
    
    if (indexPath.section ==0) {
        
        NSLog(@"000000000000");
        static NSString *CellIdentifier = @"Cell";
        
        MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
            
            cell = [array objectAtIndex:0];
        }
        
        cell.titleLabel.text = @"个人资料";
        cell.detailLabel.text = @"13161188680";
        cell.thisImageView.image = [UIImage imageNamed:@"icon_acc.png"];
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {
        
        
        if (indexPath.row==0) {
            
            static NSString *CellIdentifier = @"second";
            
            MyCenterSecondCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterSecondCell" owner:self options:nil];
                
                cell = [array objectAtIndex:0];
            }
            
            
            cell.accountMoneyLabel.text = @"￥675";
            cell.goldMoneyLabel.text = @"￥436";
            cell.silverMoneyLabel.text= @"￥787";
            return  cell;
        }
        
        if (indexPath.row==1){
            
            
            static NSString *CellIdentifier = @"Cell_1";
            
            MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
                
                cell = [array objectAtIndex:0];
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
            
            cell = [array objectAtIndex:0];
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
                
                controller = [[MyOrderListViewController alloc] init];
                
                break;
            case 1:
                controller = [[CommonContactViewController alloc] init];
                break;
            case 2:
                controller= [[MyCheapViewController alloc] init];
                break;
            default:
                break;
        }
        
            
    }
    
    
       [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
}



@end
