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
#import "AddPersonController.h"
#import "ShowSelectedResultViewController.h"
@interface WriteOrderViewController ()

@end

@implementation WriteOrderViewController

int flightFlag = 1; // 暂时判断是不是往返

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
    self.upPayMoney.text = self.searchDate.pay;
    
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    
    
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
    [_allPay release];
    [_upPayMoney release];
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
    [self setAllPay:nil];
    [self setUpPayMoney:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 40  ;
    }
    else
    {
        return 20;
    }
    
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
    if (flightFlag==1) { // 单程
        return 2;
    }
    else if(flightFlag == 2)
    { 
        return 3;   // 往返的时候返回3个分区
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flightFlag == 1)
    {
        switch (section)
        {
            case 0:
                return 1;
            case 1:
                return 6;
            default:
                break;
        }

    }
    else
    {
        switch (section)
        {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 6;
        default:
            break;
       }

    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (flightFlag == 1) {  // 单程
        if (indexPath.section == 0) {
            return 70;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            return 50;
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            return 80;
        }
        else{
            return 40;
        }

    }
    else{
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (flightFlag == 2) {   // 往返
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
    }
    else if(flightFlag == 1)
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
                
                cell.HUButton.text = self.searchDate.temporaryLabel;
                cell.airPortName.text = self.searchDate.airPort;
                cell.startTime.text = self.searchDate.beginTime;
                cell.endTime.text = self.searchDate.endTime;
                cell.startAirPortName.text = self.searchDate.startPortName;
                cell.endAirPortName.text = self.searchDate.endPortName;
                cell.plantType.text = self.searchDate.cabinNumber;
                
                return cell;
                break;
            }
            case 1:
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
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL logFlag = TRUE;  // 此处保留一个flag判断是否用户已经登陆
    if (indexPath.section == flightFlag && indexPath.row == 0) {
        if (logFlag) {
            AddPersonController * person = [[AddPersonController alloc] init];   // 添加乘机人列表
            [self.navigationController pushViewController:person animated:YES];
            [person release];
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
- (IBAction)payMoney:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还有返程订单未选择" delegate:self cancelButtonTitle:nil otherButtonTitles:@"选择返程",@"继续支付", nil];
    [alert show];
    [alert release];
}

#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0 ) {
        
        SearchAirPort * searchAirPort = [[SearchAirPort alloc] initWithdpt:@"SHA" arr:@"PEK" date:@"2012-12-20" ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
        show.airPort = searchAirPort;
        show.write = self;
        [self.navigationController popToViewController:show animated:YES];
        NSLog(@"返回选择返程订单");
    }
    else if (buttonIndex ==1)
    {
        NSLog(@"继续支付");
    }
}
@end
