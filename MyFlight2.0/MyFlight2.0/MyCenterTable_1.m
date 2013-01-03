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
    

    thistableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    thistableView.dataSource =self;
    thistableView.delegate =self;
    thistableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor =View_BackGround_Color;
    
    [self.view addSubview:thistableView];
    
     
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
    
    
    UITableViewCell *cell = nil;
    
    
    
    if (indexPath.section ==0) {
        
        NSLog(@"000000000000");
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
            
            cell = [array objectAtIndex:0];
        }
        
        MyCenterCell *thisCell = (MyCenterCell * ) cell;
        
        thisCell.titleLabel.text = @"个人资料";
        thisCell.detailLabel.text = @"13161188680";
        thisCell.imageView.image = [UIImage imageNamed:@"icon_acc.png"];
        
    }
    
    if (indexPath.section == 1) {
        
        
        if (indexPath.row==0) {
            
            static NSString *CellIdentifier = @"second";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterSecondCell" owner:self options:nil];
                
                cell = [array objectAtIndex:0];
            }
            
            MyCenterSecondCell *thisCell =(MyCenterSecondCell *) cell;
            thisCell.accountMoneyLabel.text = @"￥675";
            thisCell.goldMoneyLabel.text = @"￥436";
            thisCell.silverMoneyLabel.text= @"￥787";
        }
        
        if (indexPath.row==1){
            
            
            static NSString *CellIdentifier = @"Cell_1";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.imageView.image = [UIImage imageNamed:@"icon_Coupon.png"];

            cell.textLabel.text = @"我的优惠券";
            
//            MyCenterCell *thisCell = (MyCenterCell *) cell;
//            thisCell.titleLabel.text = @"我的优惠券";
//            thisCell.detailLabel.text = @"";
//            thisCell.imageView.image = [UIImage imageNamed:@"icon_Coupon.png"];
            
            
        }
        
        
        
    }
    
    
    //第三分区
    if(indexPath.section==2){
        
        
        static NSString *CellIdentifier = @"Cell0";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCenterCell" owner:self options:nil];
            
            cell = [array objectAtIndex:0];
        }
        
        
        MyCenterCell *thisCell = (MyCenterCell *) cell;
        
        if(indexPath.row==0){
            
            
            
            thisCell.titleLabel.text = @"我的订单";
            thisCell.detailLabel.text = @"未支付订单(1)";
            thisCell.imageView.image = [UIImage imageNamed:@"icon_Orders.png"];
            
        } else{
            
            
            thisCell.titleLabel.text = [nameArray objectAtIndex:indexPath.row-1];
            
            thisCell.imageView.image = [imageArray objectAtIndex:indexPath.row-1];
            thisCell.detailTextLabel.text =@"";
            
            
        }
        
        
    }
    
    
    return cell;
}



- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSLog(@"第%d分区 第%d行",indexPath.section,indexPath.row);
    if (indexPath.section==0) {
        
        NSLog(@"第0分区执行");
        
            
            PersonInfotoShowViewController *controller = [[PersonInfotoShowViewController alloc] init];
            
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];

              
       
    }
    
    
    
    
    
    
    
}
@end
