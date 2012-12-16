//
//  MyCenterViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterViewCell.h"
#import "MyCenterViewCommonCell.h"
#import "MyInformationController.h"
#import "UsedPersonController.h"
@interface MyCenterViewController ()

@end

@implementation MyCenterViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.titleArr = [NSArray arrayWithObjects:@"个人资料",@"我的订单",@"常用乘机人信息",@"我订阅的低价航线",@"用心愿旅行卡充值", nil];
    self.imageArr = [NSArray arrayWithObjects:@"icon_acc.png",@"icon_Orders.png",@"icon_atv.png",@"icon_rss.png",@"icon_Recharge.png", nil];
    
    self.navigationItem.title = @"我的个人中心";
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }
    else
    {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 94;
    }
    else{
        return 44;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0 || indexPath.section == 2) {
        MyCenterViewCommonCell *cell = (MyCenterViewCommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyCenterViewCommonCell" owner:self options:nil];
            cell = self.myCommonCell;
        }
        if (indexPath.section == 0) {
            cell.firstLabel.text = [self.titleArr objectAtIndex:0];
            cell.imaeView.image = [UIImage imageNamed:@"icon_acc.png"];
            cell.secondLabel.text = @"12345678";  // 个人账号
        }
        else{
            cell.firstLabel.text = [self.titleArr objectAtIndex:indexPath.row + 1];
            cell.imaeView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row +1]];
            cell.secondLabel.text = @"";
        }

        
        return cell;
    }
    else{
        MyCenterViewCell *cell = (MyCenterViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyCenterViewCell" owner:self options:nil];
            cell = self.myCell;
        }
        
        
        return cell;
    }
        
    //cell.airPortName.text = [cellArr objectAtIndex:indexPath.row];
    
    
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyInformationController  * center = [[MyInformationController alloc] init];
        [self.navigationController pushViewController:center animated:YES];
        [center release];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {

        UsedPersonController * person = [[UsedPersonController alloc] init];
        [self.navigationController pushViewController:person animated:YES];
        [person release];
    }
}

- (void)dealloc {
    
    [_myCell release];
    [_myCommonCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setMyCell:nil];
    [self setMyCommonCell:nil];
    [super viewDidUnload];
}
@end
