//
//  DetailsOrderViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "DetailsOrderViewController.h"
#import "AppConfigure.h"
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
#import "PayViewController.h"
#import "PayOnline.h"

#import "CancelOrdre.h"

@interface DetailsOrderViewController ()
{
    BOOL select;
    
    int personCount;  // 成人数
    int childCount;  // 儿童个数
    
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
           
            [self.tempView removeFromSuperview];
        }
        
        self.showTableView.separatorColor = [UIColor grayColor];
        
        [cell.orderAllPay addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.order != nil) {
           
            cell.orderNo.text = self.order.code;
            cell.orderData.text = self.order.createDate;
            cell.orderStation.text = self.order.stsCh;
            cell.payStation.text = self.order.payStsCh;
            cell.allPayLabel.text = [NSString stringWithFormat:@"￥%@",self.order.totalMoney];
            cell.payOnline.text = self.order.actualMoney;
            
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
        if (childCount != 0) {
            self.tempView = self.bigView;
        }
        else{
            self.tempView = self.smallView;
        }
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
    
    
    //获取请求类型
    NSString *requestType = [info objectForKey:KEY_Request_Type];
    
    if ([requestType isEqualToString:@"cancel"]) {
        [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:@"取消订单成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];

    }
    else{
        NSArray * arr = [info objectForKey:@"newDic"];
        
        self.order = [arr objectAtIndex:0];
        self.flight = [arr objectAtIndex:1];   // 出港
        self.inFlight = [arr objectAtIndex:2];  // 入港
        self.personArray = [NSArray arrayWithArray:[arr objectAtIndex:3]];
        self.post = [arr objectAtIndex:4];
        self.person = [arr objectAtIndex:5];
        
        Passenger * person = [[Passenger alloc] init];
        Passenger * goPerson = [[Passenger alloc] init];
        Passenger * child = [[Passenger alloc] init];
        Passenger * goChild = [[Passenger alloc] init];
        
        NSMutableArray * personArr = [[NSMutableArray alloc] init];
        NSMutableArray * childArr = [[NSMutableArray alloc] init];
        
        personCount = 0;
        childCount = 0;
        
        for (Passenger * p in self.personArray) {
            
            if ([p.type isEqualToString:@"01"]) {
                
                [personArr addObject:p];
                person = p;
                personCount = personCount + 1;
            }
            else{
                [childArr addObject:p];
                child = p;
                childCount = childCount +1;
            }
            
        }
        
        
        if ([self.order.flyType isEqualToString:@"2"]) {
            goPerson = [personArr objectAtIndex:0];
            
            personCount = personCount/2;
            
            
            if (childCount != 0) {
                goChild = [childArr objectAtIndex:0];
                childCount = childCount/2;
            }
            
            
        }
        else{
            goPerson = nil;
            goChild = nil;
        }
        
        
        
        self.PerStanderPrice.text =[NSString stringWithFormat:@"￥%d",[person.ticketPrice intValue] + [goPerson.ticketPrice intValue]];
        self.PersonConstructionFee.text =[NSString stringWithFormat:@"￥%d",[person.constructionPrice intValue] + [goPerson.constructionPrice intValue]];
        self.personAdultBaf.text =[NSString stringWithFormat:@"￥%d",[person.bafPrice intValue] + [goPerson.bafPrice intValue]];
        self.Personinsure.text = [NSString stringWithFormat:@"￥%d",[person.insurance intValue] + [goPerson.insurance intValue]];
        self.personMuber.text = [NSString stringWithFormat:@"%d",personCount];
        
        self.smallPerStanderPrice.text = [NSString stringWithFormat:@"￥%d",[person.ticketPrice intValue] + [goPerson.ticketPrice intValue]];
        self.smallPersonConstructionFee.text = [NSString stringWithFormat:@"￥%d",[person.constructionPrice intValue] + [goPerson.constructionPrice intValue]];
        self.smallpersonAdultBaf.text = [NSString stringWithFormat:@"￥%d",[person.bafPrice intValue] + [goPerson.bafPrice intValue]];
        self.smallPersoninsure.text = [NSString stringWithFormat:@"￥%d",[person.insurance intValue] + [goPerson.insurance intValue]];
        self.smallpersonMuber.text = [NSString stringWithFormat:@"%d",personCount];
        
        self.childStanderPrice.text =[NSString stringWithFormat:@"￥%d",[child.ticketPrice intValue] + [child.ticketPrice intValue]];
        self.childConstructionFee.text =[NSString stringWithFormat:@"￥%d",[child.constructionPrice intValue] + [child.constructionPrice intValue]] ;
        self.childBaf.text = [NSString stringWithFormat:@"￥%d",[child.bafPrice intValue] + [child.bafPrice intValue]];
        self.childInsure.text = [NSString stringWithFormat:@"￥%d",[child.insurance intValue] + [child.insurance intValue]];
        self.childMunber.text = [NSString stringWithFormat:@"%d",childCount];
        
        [self.showTableView reloadData];

    }
   
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
- (IBAction)goPay:(id)sender {
    
    
    
    PayOnline * payOnline = [[PayOnline alloc] initWithProdType:@"01"
                                                        payType:@"umpay"
                                                      orderCode:self.order.code
                                                       memberId:Default_UserMemberId_Value
                                                      actualPay:self.order.actualMoney
                                                         source:@"51you"
                                                           hwId:HWID_VALUE
                                                    serviceCode:@"01"
                                                    andDelegate:self];
    
    PayViewController * pay = [[PayViewController alloc] init];
    pay.payOnline = payOnline;
    pay.searchType = self.searchType;
    [self.navigationController pushViewController:pay animated:YES];
    [pay release];
}

- (IBAction)cancelOrder:(id)sender {
    
    NSString * string = [NSString stringWithFormat:@"%@%@%@",Default_UserMemberId_Value,SOURCE_VALUE,Default_Token_Value];
    
    CancelOrdre * cancel = [[CancelOrdre alloc] initWithOrderId:self.order.orderId
                                                   andOrderCode:self.order.code
                                                    andMemberId:Default_UserMemberId_Value
                                                   andCheckCode:self.person.iphone
                                                        andSign:GET_SIGN(string)
                                                      andSource:SOURCE_VALUE
                                                        andHwId:HWID_VALUE
                                                     andEdition:EDITION_VALUE
                                                    andDelegate:self];
    
    [cancel delOrder];
}
@end
