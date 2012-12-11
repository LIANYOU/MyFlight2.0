//
//  WriteOrderViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "WriteOrderViewController.h"
#import "BuyInsuranceViewController.h"
#import "ChooseSpaceViewController.h"
#import "ChoosePersonController.h"
@interface WriteOrderViewController ()

@end

@implementation WriteOrderViewController

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
    self.cellTitleArr = [NSArray arrayWithObjects:@"乘机人",@"联系人",@"联系电话",@"购买保险",@"行程单",@"账户资金/优惠券抵用",@"活动促销减免", nil];
    self.navigationItem.title = @"填写订单";
    
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    
    //self.orderScrollView.contentSize = CGSizeMake(320, 600);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_writeOrderCell release];
    [_writeOrderDetailsCell release];
    [_writerOrderCommonCell release];
    [_wirterOrderTwoLineCell release];
    [orderMoney release];
    [_orderTableView release];
    [_orderScrollView release];
    [_headView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWriteOrderCell:nil];
    [self setWriteOrderDetailsCell:nil];
    [self setWriterOrderCommonCell:nil];
    [self setWirterOrderTwoLineCell:nil];
    [orderMoney release];
    orderMoney = nil;
    [self setOrderTableView:nil];
    [self setOrderScrollView:nil];
    [self setHeadView:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section //设置不同section的header的高度
{
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        self.headView.frame = CGRectMake(0, 0, 320, 40);
        [myView addSubview:self.headView];
        
        return myView;
    }
   else
return nil;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 6;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 70;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 50;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        return 80;
    }
    else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *CellIdentifier = @"Cell1";
            WriteOrderCell *cell = (WriteOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                [[NSBundle mainBundle] loadNibNamed:@"WriteOrderCell" owner:self options:nil];
                cell = self.writeOrderCell;
            }
            cell.userInteractionEnabled = NO;
            return cell;
            break;
        }
         case 1:
        {
            static NSString *CellIdentifier = @"Cell1";
            WriteOrderCell *cell = (WriteOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                [[NSBundle mainBundle] loadNibNamed:@"WriteOrderCell" owner:self options:nil];
                cell = self.writeOrderCell;
            }
            cell.backView.backgroundColor = [UIColor orangeColor];
            cell.userInteractionEnabled = NO;
            return cell;
            break;
            
        }
        case 2:
        {
            if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5) {
                static NSString *CellIdentifier = @"Cell3";
                WriterOrderCommonCell *cell = (WriterOrderCommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell)
                {
                    [[NSBundle mainBundle] loadNibNamed:@"WriterOrderCommonCell" owner:self options:nil];
                    cell = self.writerOrderCommonCell;
                }
                switch (indexPath.row) {
                    case 0:
                        cell.firstLable.text = [self.cellTitleArr objectAtIndex:0];
                        break;
                    case 2:
                        cell.firstLable.text = [self.cellTitleArr objectAtIndex:3];
                        break;
                    case 3:
                        cell.firstLable.text = [self.cellTitleArr objectAtIndex:4];
                        break;
                    case 5:
                        cell.firstLable.text = [self.cellTitleArr objectAtIndex:6];
                        break;
                        
                    default:
                        break;
                }
                return cell;
            }
            if (indexPath.row == 1) {
                static NSString *CellIdentifier = @"Cell4";
                WriteOrderDetailsCell *cell = (WriteOrderDetailsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell)
                {
                    [[NSBundle mainBundle] loadNibNamed:@"WriteOrderDetailsCell" owner:self options:nil];
                    cell = self.writeOrderDetailsCell;
                }
                cell.personName = [self.cellTitleArr objectAtIndex:1];
                cell.phoneNumber = [self.cellTitleArr objectAtIndex:2];
               // cell.userInteractionEnabled = NO;
                return cell;
            }
            if (indexPath.row == 4) {
                static NSString *CellIdentifier = @"Cell5";
                WirterOrderTwoLineCell *cell = (WirterOrderTwoLineCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell)
                {
                    [[NSBundle mainBundle] loadNibNamed:@"WirterOrderTwoLineCell" owner:self options:nil];
                    cell = self.wirterOrderTwoLineCell;
                }
                //cell = [self.cellTitleArr objectAtIndex:1];
                return cell;
            }
            break;
            
        }
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL logFlag = TRUE;  // 此处保留一个flag判断是否用户已经登陆
    if (indexPath.section == 2 && indexPath.row == 0) {
        if (logFlag) {
            CCLog(@"推进到选择乘机人列表");
//            ChoosePersonController * person = [[ChoosePersonController alloc] init];
//            [self.navigationController pushViewController:person animated:YES];
//            [person release];
        }
        else
        {
            CCLog(@"进入添加乘机人列表");
        }
    }
    else
    {
        BuyInsuranceViewController * insurance = [[BuyInsuranceViewController alloc] init];
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];
    }
    
}
@end
