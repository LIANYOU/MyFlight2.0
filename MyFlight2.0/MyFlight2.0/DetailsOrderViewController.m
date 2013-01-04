//
//  DetailsOrderViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "DetailsOrderViewController.h"

#import "PassengerCell.h"
#import "JourneyCell.h"
#import "WriteOrderCell.h"
#import "LinkmanCell.h"
#import "FlightConditionCell.h"
#import "UIQuickHelp.h"
#import "PublicConstUrls.h"
#import "UIButton+BackButton.h"

#import "OrderBasicInfoWJ.h"
#import "FlightConditionWj.h"
#import "Passenger.h"
#import "PostInfo.h"
#import "LinkPersonInfo.h"
#import "InFlightConditionWJ.h"

@interface DetailsOrderViewController ()
{
    BOOL select;
    
    float hight;
}
@end

@implementation DetailsOrderViewController

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
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    
    self.detaile.delegate = self;
    [self.detaile getOrderDetailInfo:self.searchType];

    self.tempView = nil;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bigView release];
    [_smallView release];
    [_showTableView release];
    [_linkCell release];
    [_journeyCell release];
    [_passengerCell release];
    [_flightCell release];
    [_one release];
    [_two release];
    [_three release];
    [_four release];
    [_five release];


    [_WjCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBigView:nil];
    [self setSmallView:nil];
    [self setShowTableView:nil];
    [self setLinkCell:nil];
    [self setJourneyCell:nil];
    [self setPassengerCell:nil];
    [self setFlightCell:nil];
    [self setOne:nil];
    [self setTwo:nil];
    [self setThree:nil];
    [self setFour:nil];
    [self setFive:nil];

    [self setWjCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.one;
            break;
        case 1:
            return self.two;
            break;
        case 2:
            return self.three;
            break;
        case 3:
            return self.four;
            break;
        case 4:
            return self.five;
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if (self.inFlight.depAirPortCN != nil) {
                return 2;
            }
            else{
                return 1;
            }
            
            break;
        case 2:
           
            return self.personArray.count;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 357 + self.tempView.frame.size.height;
            break;
        case 1:
            return 94;
            break;
        case 2:
            return 150;
            break;
        case 3:
            return 150;
            break;
        case 4:
            return 80;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell5";
        WJOrderBasicCell *cell = (WJOrderBasicCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"WJOrderBasicCell" owner:self options:nil];
            cell = self.WjCell;
            
        }
        
        hight = self.tempView.frame.size.height;
        cell.infoView.frame = CGRectMake(0, 190, 320, self.tempView.frame.size.height);
        [cell.infoView addSubview:self.tempView];
        
        if (hight == 0.000000) {
           
            [self.bigView removeFromSuperview];
        }
        
        self.showTableView.separatorColor = [UIColor grayColor];
        
        [cell.orderAllPay addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.order != nil) {
           
            cell.orderNo.text = self.order.code;
            cell.orderData.text = self.order.createDate;
            cell.orderStation.text = self.order.stsCh;
            cell.payStation.text = self.order.payStsCh;
            [cell.orderAllPay setTitle:self.order.totalMoney forState:0 ];
        }
       
        
        
        return cell;
        
 

    }
    if (indexPath.section == 1) {
        
        static NSString *CellIdentifier = @"Cell1";
        FlightConditionCell *cell = (FlightConditionCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"FlightConditionCell" owner:self options:nil];
            cell = self.flightCell;
            
        }
        self.showTableView.separatorColor = [UIColor clearColor];
        
        if (indexPath.row == 0) {
           [cell.imageBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue.png"] forState:0];
           [cell.imageBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue.png"] forState:UIControlStateHighlighted];
            cell.HUButton.text = self.flight.flightNo;
            cell.endAirPortName.text = self.flight.arrAirportCN;
            cell.startAirPortName.text = self.flight.depAirPortCN;
            cell.endTime.text = self.flight.arrivalTime;
            cell.startTime.text = self.flight.departureTime;
            cell.date.text = self.flight.departureDate;
            cell.plantType.text = self.flight.aircraftType;
            cell.airPortName.text = self.flight.airlineCompany;
            
            cell.changeTicket.tag = indexPath.row;
       
            [cell.changeTicket setBackgroundImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:0];
   
            [cell.changeTicket addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
      //  if (self.inFlight != nil && indexPath.row == 1)
        if (indexPath.row == 1){
            
            [cell.imageBtn setBackgroundImage:[UIImage imageNamed:@"bg_green.png"] forState:0];
            [cell.imageBtn setBackgroundImage:[UIImage imageNamed:@"bg_green.png"] forState:UIControlStateHighlighted];

            cell.HUButton.text = self.inFlight.flightNo;
            cell.endAirPortName.text = self.inFlight.arrAirportCN;
            cell.startAirPortName.text = self.inFlight.depAirPortCN;
            cell.endTime.text = self.inFlight.arrivalTime;
            cell.startTime.text = self.inFlight.departureTime;
            cell.date.text = self.inFlight.departureDate;
            cell.plantType.text = self.inFlight.aircraftType;
            cell.airPortName.text = self.inFlight.airlineCompany;
            
            cell.changeTicket.tag = indexPath.row;
             [cell.changeTicket setBackgroundImage:[UIImage imageNamed:@"btn_green_rule.png"] forState:0];
            [cell.changeTicket addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
    }

    if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"Cell2";
        PassengerCell *cell = (PassengerCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"PassengerCell" owner:self options:nil];
            cell = self.passengerCell;
            
        }
        self.showTableView.separatorColor = [UIColor grayColor];
        if (indexPath.row == 1) {
            cell.image.hidden = YES;
        }
        
        for (int i = 0; i<self.personArray.count; i++) {
            
            Passenger * p = [self.personArray objectAtIndex:i];
            
            if (indexPath.row == i) {                
                cell.name.text = p.name;
                cell.number.text = p.certNo;
                cell.orderNo.text = p.etNo;
                cell.orderInfo.text = p.insuranceCode;
                
            }
        }
        
        
        return cell;
    }

    if (indexPath.section == 3) {
        
        static NSString *CellIdentifier = @"Cell3";
        JourneyCell *cell = (JourneyCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"JourneyCell" owner:self options:nil];
            cell = self.journeyCell;
            
        }
        
        cell.sendType.text = self.post.deliveryType;
        cell.name.text = self.post.catchUser;
        cell.iphone.text = self.post.mobile;
        cell.address.text = self.post.address;
        
        return cell;


    }

    if (indexPath.section == 4) {
        static NSString *CellIdentifier = @"Cell4";
        LinkmanCell *cell = (LinkmanCell *)[self.showTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"LinkmanCell" owner:self options:nil];
            cell = self.linkCell;
            
        }
        
        cell.nsme.text = self.person.name;
        cell.phone.text = self.person.iphone;
        
        return cell;
    
    }

    return nil;
    
}


-(void)change:(UIButton *)btn
{
    if (hight == 0.000000) {
        self.tempView = self.bigView;
    }
    else{
        self.tempView = nil;
    }
    
    [self.showTableView reloadData];
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
    
    NSArray * arr = [info objectForKey:@"newDic"];
    
    
    self.order = [arr objectAtIndex:0];
    self.flight = [arr objectAtIndex:1];
    self.inFlight = [arr objectAtIndex:2];
    self.personArray = [NSArray arrayWithArray:[arr objectAtIndex:3]];
    self.post = [arr objectAtIndex:4];
    self.person = [arr objectAtIndex:5];
    
    NSLog(@"%@",self.order.code );
    NSLog(@"%@",self.flight.depAirPortCN );
    NSLog(@"%@",self.inFlight.depAirPortCN );
    NSLog(@"%@",self.post.deliveryType );
    NSLog(@"--------- %@",self.person.name );
    NSLog(@"%d",self.personArray.count);
    for (Passenger * p in self.personArray) {
        NSLog(@"%@",p.name);
    }
    
    [self.showTableView reloadData];

}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showInfo:(UIButton *)btn
{
    NSString * string = nil;
    if (btn.tag == 0) {
        string = self.flight.cabinRule;
    }
    else{
        string = self.inFlight.cabinRule;
    }
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"退改签信息" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}
@end
