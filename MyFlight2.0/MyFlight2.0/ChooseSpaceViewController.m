//
//  ChooseSpaceViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ChooseSpaceViewController.h"
#import "ChooseSpaceCell.h"
#import "WriteOrderViewController.h"
#import "TransitionString.h"
#import "ShowSelectedResultViewController.h"
@interface ChooseSpaceViewController ()

@end

@implementation ChooseSpaceViewController

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
    
    self.flightCode.text = self.searchFlight.temporaryLabel;
    self.airPort.text = self.searchFlight.airPort;
    self.palntType.text = self.searchFlight.palntType;
    self.beginTime.text = self.searchFlight.beginTime;
    self.endTime.text = self.searchFlight.endTime;
    
    self.changeInfoArr = [NSMutableArray array];
    self.indexPath = [NSMutableArray array];
    self.searchFlight.cabinNumberArr = [NSMutableArray array];
    for (int i = 0; i<self.searchFlight.cabinsArr.count; i++) {
        NSDictionary * dic = [self.searchFlight.cabinsArr objectAtIndex:i];
        NSString * string = [dic objectForKey:@"changeInfo"];
        NSString * string1 = [dic objectForKey:@"cabinCode"]; // 舱位编码
        NSString * string2 = [dic objectForKey:@"cabinCN"];
        NSString * str = [NSString stringWithFormat:@"%@ %@",string2,string1];
        [self.searchFlight.cabinNumberArr addObject:str];
        [self.changeInfoArr addObject:string];
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [_showTableView release];
    [_spaceCell release];
    [_flightCode release];
    [_airPort release];
    [_palntType release];
    [_beginTime release];
    [_endTime release];
    [_scheduleDate release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowTableView:nil];
    [self setSpaceCell:nil];
    [self setFlightCode:nil];
    [self setAirPort:nil];
    [self setPalntType:nil];
    [self setBeginTime:nil];
    [self setEndTime:nil];
    [self setScheduleDate:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchFlight.cabinsArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ChooseSpaceCell *cell = (ChooseSpaceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ChooseSpaceCell" owner:self options:nil];
        cell = self.spaceCell;
    }
    
    NSDictionary * dic = [self.searchFlight.cabinsArr objectAtIndex:indexPath.row] ;
    cell.SpaceName.text = [dic objectForKey:@"cabinCN"];
    cell.payMoney.text = [dic objectForKey:@"price"];
    cell.ticketCount.text = [TransitionString transitionSeatNum: [dic objectForKey:@"seatNum"] ];
    cell.discount.text = [dic objectForKey:@"discount"];
    cell.discount.text = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"cabinCode"]];
    
    cell.changeSpace.tag = indexPath.row;
    [cell.changeSpace addTarget:self action:@selector(changeFlightInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


#pragma mark - Table view delegatesearchFlight

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 2) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还有返程订单未选择" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"选择返程", nil];
        [alert show];
        [alert release];
    }
    
    else
    {
        WriteOrderViewController * insurance = [[WriteOrderViewController alloc] init];
        insurance.flag = self.flag;
        NSLog(@"%s,%d",__FUNCTION__,self.flag);
        insurance.searchDate = self.searchFlight;
        insurance.searchDate.cabinNumber =  [insurance.searchDate.cabinNumberArr objectAtIndex:indexPath.row];
        insurance.searchDate.pay = [[self.searchFlight.cabinsArr objectAtIndex:indexPath.row]objectForKey:@"price"];
        
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];
    }
    
}
- (void)changeFlightInfo:(UIButton *)sender {
    
    CCLog(@"%@",[self.changeInfoArr objectAtIndex:sender.tag]);
    
//    NSIndexPath * indexPathToInsert = [NSIndexPath indexPathForRow:sender.tag+1 inSection:0];
//
//    [self.indexPath addObject:indexPathToInsert];
//
//    [self.showTableView insertRowsAtIndexPaths:self.indexPath withRowAnimation:UITableViewRowAnimationBottom];
}



#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1 ) {
        SearchAirPort * searchAirPort = [[SearchAirPort alloc] initWithdpt:@"SHA" arr:@"PEK" date:@"2012-12-20" ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
        show.airPort = searchAirPort;
        show.write = self;
        [self.navigationController popToViewController:show animated:YES];
        NSLog(@"返回选择返程订单");
    }
    else if (buttonIndex ==0)
    {
        NSLog(@"停留在次界面");
    }
}

@end
