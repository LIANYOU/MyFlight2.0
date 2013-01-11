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
#import "ChoosePersonController.h"
#import "TraveController.h"
#import "LogViewController.h"
#import "DiscountCouponController.h"
#import "flightContactVo.h"
#import "flightPassengerVo.h"
#import "flightItineraryVo.h"
#import "payVo.h"
#import "bookingGoFlightVo.h"
#import "FlightBookingBusinessHelper.h"
#import "bookingReturnFlightVo.h"
#import "UIQuickHelp.h"
#import "PayOnline.h"

#import "PayViewController.h"
#import "OrderDetaile.h"
#import "UIButton+BackButton.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 100.0f

@interface WriteOrderViewController ()
{
    int goPay;
    int backPay;
    
    int newPersonAllPay;
    int newChildAllPay;
    
    int childNumber;  // 儿童个数
    int personNumber; // 成人个数
  
    int finalPay;  // 最终支付的价格
    
    int insuranceFlag;  // 判断有没有购买保险
    
    NSMutableArray * addPersonArr;
    
    NSString * silverString;// 银币
    NSString * captchaString;  //优惠券
    NSString * goldAndCount;// 金币和资金账户
    NSString * passWord;    // 支付密码
    NSString * captchaID;// 优惠券ID
    
   
    
    
    BOOL selectDicount;
    
    
}
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

-(void)calculateAllPay
{
    // *****  填写bigView里边的信息
    self.PerStanderPrice.text =[NSString stringWithFormat:@"￥%d",self.searchDate.pay + self.searchBackDate.pay] ;  // 票面价
    self.personAdultBaf.text = [NSString stringWithFormat:@"￥%d",[self.searchDate.adultBaf intValue] + [self.searchBackDate.adultBaf intValue]];
    self.PersonConstructionFee.text = [NSString stringWithFormat:@"￥%d",[self.searchDate.constructionFee intValue] + [self.searchBackDate.constructionFee intValue]];
    self.Personinsure.text = @"￥0";   // 保险
    self.personMuber.text = [NSString stringWithFormat:@"%d",personNumber];
    
    
    self.childStanderPrice.text = [NSString stringWithFormat:@"￥%d",[self.searchDate.childPrice intValue] +[self.searchBackDate.childPrice intValue]];
    self.childBaf.text =[NSString stringWithFormat:@"￥%d", [self.searchDate.childBaf intValue] + [self.searchBackDate.childBaf intValue]];
    self.childConstructionFee.text =[NSString stringWithFormat:@"￥%d", [self.searchDate.childConstructionFee intValue] + [self.searchBackDate.childConstructionFee intValue]];
    self.childInsure.text = @"￥0";
    self.childMunber.text = [NSString stringWithFormat:@"%d",childNumber];
    
    //********* 计算订单总额......
    
    int personMoney = self.searchDate.pay + self.searchBackDate.pay;   // 单程是时候最后赋值的是self.backPay
    int airPortName = [self.searchDate.constructionFee intValue] + [self.searchBackDate.constructionFee intValue];
    int oil = [self.searchDate.adultBaf intValue]+[self.searchBackDate.adultBaf intValue];
    
    int childPersonMoney = [self.searchDate.childPrice intValue] +[self.searchBackDate.childPrice intValue];
    int childAirPortName = [self.searchDate.childConstructionFee intValue] + [self.searchBackDate.childConstructionFee intValue];
    int childOil = [self.searchDate.childBaf intValue] + [self.searchBackDate.childBaf intValue];
    
    
    newPersonAllPay = (personMoney+airPortName+oil)*personNumber;
    newChildAllPay = (childPersonMoney+childAirPortName+childOil)*childNumber;
    
    finalPay = newPersonAllPay + newChildAllPay;
    
    
    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0];
    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0]; // 默认开始进入没有儿童
    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0];
    
}

-(void)initLastPassengerInfo
{
    // 读取最后一次乘机人信息
    
    self.stringArr = [NSMutableArray array];
    self.personArray = [NSMutableArray array];
    
    NSMutableArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"personArr"];
    
    self.passengerIDArr = [arr objectAtIndex:0];
    self.cerNO = [arr objectAtIndex:1];
    self.cerTYPE = [arr objectAtIndex:2];
    self.passengeNAME = [arr objectAtIndex:3];
    self.passengerTYPE = [arr objectAtIndex:4];
    
    NSLog(@"%d",self.passengerIDArr.count);
    NSLog(@"%@",self.passengerIDArr);
    NSLog(@"%@",self.cerNO);
    NSLog(@"%@",self.cerTYPE);
    NSLog(@"%@",self.passengeNAME);
    NSLog(@"%@",self.passengerTYPE);
    
    for(int i = 0; i<self.passengerIDArr.count;i++ )
    {
        NSString * str1 = [self.passengerIDArr objectAtIndex:i];
        NSString * str2 = [self.cerNO objectAtIndex:i];
        NSString * str3 = [self.cerTYPE objectAtIndex:i];
        NSString * str4 = [self.passengeNAME objectAtIndex:i];
        NSString * str5 = [self.passengerTYPE objectAtIndex:i];
        
        // *******  加入到填写订单时候的 flightPassengerVo
        flightPassengerVo * passenger = [[flightPassengerVo alloc] init];
        
        passenger.name = str4;
        passenger.certNo = str2;
        passenger.type = str5;
        passenger.flightPassengerId = str1;
        passenger.certType = str3;
        
        passenger.goInsuranceNum = @"0";
        passenger.returnInsuranceNum = @"0";
        
        [self.personArray addObject:passenger];
        [passenger release];
        // ****
        
        
        if ([str5 isEqualToString:@"01"]) {
            str5  = @"成人";
        }
        else{
            str5 = @"儿童";
        }
        
        NSString * string = [NSString stringWithFormat:@"%@ (%@) \n%@",str4,str5,str2];
        
        if ([str5 isEqualToString:@"儿童"]) {
            childNumber = childNumber + 1;
        }
        
        [self.stringArr addObject:string];
        
        
        // *****************  常用联系人自动匹配第一个乘机人
        
        if (self.personArray.count != 0) {
            flightPassengerVo * passenger = [self.personArray objectAtIndex:0];
            
            [addPersonArr replaceObjectAtIndex:0 withObject:passenger.name];
            [addPersonArr replaceObjectAtIndex:1 withObject:@""];
            
        }
        
    }
    
    stringAfterJoin = @"";
    NSLog(@"self.stringArr.count  %d",self.stringArr.count);
    
    for (int i = 0; i<self.stringArr.count; i++) {
        
        if ([stringAfterJoin isEqualToString:@""]) {
            stringAfterJoin = [NSString stringWithFormat:@"%@",[self.stringArr objectAtIndex:i]];
        }
        else{
            stringAfterJoin = [NSString stringWithFormat:@"%@\n%@",stringAfterJoin,[self.stringArr objectAtIndex:i]];
        }
        
    }
    personNumber = self.passengerIDArr.count-childNumber;
    
    NSLog(@"------------%@",stringAfterJoin);
    [self.firstCelTextArr replaceObjectAtIndex:0 withObject:stringAfterJoin];

}
- (void)viewDidLoad
{
    personNumber = 0;  // 默认一个成人
    childNumber = 0;
    
//    NSLog(@"%@\n--------------%@",self.searchDate.cabinInfo,self.searchBackDate.cabinInfo);
//    NSLog(@"%d,%@",self.searchDate.pay,self.searchBackDate.childPrice);
//    NSLog(@"%@,%@",self.searchDate.ticketCount,self.searchBackDate.ticketCount);
    
    

    self.firstCelTextArr = [NSMutableArray arrayWithObject:@""];
    self.navigationItem.title = @"填写订单";
    
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;

    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    self.indexArr = [[NSMutableArray alloc] init];
    addPersonArr = [[NSMutableArray alloc]initWithObjects:@"王健",@"13120397709", nil];
    self.indexGoldArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    self.tempView = self.headView;
    self.headViewHegiht = 40;
    
    
    // 行程单
    flightItinerary = [[flightItineraryVo alloc] init];
    flightItinerary.deliveryType = @"0"; // 默认是不需要邮寄行程单
    
    
    // 调去获取金币（优惠活动）API
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"返回金币数目" object:nil];
    [self.useGoldPay searchGold];
    

    [self initLastPassengerInfo];
    
    
    [self calculateAllPay];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(void)receive:(NSNotification *) not
{

    self.discountListArr = [[not userInfo] objectForKey:@"list"];
    
//    NSLog(@" *******  促销活动名称 数目 ****   %d",self.discountListArr.count);
    
    if (self.discountListArr.count != 0) {
        self.discountName = [[self.discountListArr objectAtIndex:0] objectForKey:@"name"];
        [self.orderTableView reloadData];
    }

    
//    self.discountListArr = [NSArray arrayWithObject:@"my机票活动"];
//    
//     NSLog(@" *******  促销活动名称 数目 ****   %d",self.discountListArr.count);
//    
//    self.discountName = @"my机票活动";
    
    [self.orderTableView reloadData];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewWillAppear:(BOOL)animated
{
      if (! Default_IsUserLogin_Value) {
    
   
    UIButton * histroyBut = [UIButton backButtonType:2 andTitle:@"登录"];
    [histroyBut addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];
       }
    
    if (Default_IsUserLogin_Value) {
        UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:nil];
        self.navigationItem.rightBarButtonItem=backBtn2;
        [backBtn2 release];
    }
    
    
    [self.orderTableView reloadData];
    [super viewWillAppear:YES];
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
    [_bigHeadView release];
    [_bigUpPayMoney release];
    [_PerStanderPrice release];
    [_PersonConstructionFee release];
    [_personAdultBaf release];
    [_childStanderPrice release];
    [_childConstructionFee release];
    [_childBaf release];
    [_personMuber release];
    [_childMunber release];
    [_Personinsure release];
    [_childInsure release];
    [_backLabel release];
    [_salesCell release];
    [_greenCell release];
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
    [self setBigHeadView:nil];
    [self setBigUpPayMoney:nil];
    [self setPerStanderPrice:nil];
    [self setPersonConstructionFee:nil];
    [self setPersonAdultBaf:nil];
    [self setChildStanderPrice:nil];
    [self setChildConstructionFee:nil];
    [self setChildBaf:nil];
    [self setPersonMuber:nil];
    [self setChildMunber:nil];
    [self setPersoninsure:nil];
    [self setChildInsure:nil];
    [self setBackLabel:nil];
    [self setSalesCell:nil];
    [self setGreenCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        if (self.headViewHegiht == 97 && childNumber == 0) {
            self.backLabel.hidden = YES;
            self.childInsure.hidden = YES;
            self.childMunber.hidden = YES;
            self.childStanderPrice.hidden = YES;
            self.childConstructionFee.hidden = YES;
            self.childBaf.hidden = YES;
            return self.headViewHegiht-29;
        }
        else{
            self.backLabel.hidden = NO;
            self.childInsure.hidden = NO;
            self.childMunber.hidden = NO;
            self.childStanderPrice.hidden = NO;
            self.childConstructionFee.hidden = NO;
            self.childBaf.hidden = NO;
            return self.headViewHegiht;
        }
       
    }
    
    else
    {
        return 0;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _tempView;
    }
    else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.flag==1) { // 单程
        
        return 3;
    }
    else if(self.flag == 3)
    { 
        return 4;   // 往返的时候返回3个分区
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.flag == 1)
    {
        switch (section)
        {
            case 0:
                return 0;
            case 1:
                return 1;
            case 2:
                return 6;
            default:
                break;
        }

    }
    else  if(self.flag == 3)
    {
        switch (section)
        {
            case 0:
                return 0;
            case 1:
                return 1;
            case 2:
                return 1;
            case 3:
                return 6;
            default:
                break;
        }

    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 1) {  // 单程
        if (indexPath.section == 0) {
            return 0;
        }
        if (indexPath.section == 1) {
            return 100;
        }
        if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                firstCellText = [self.firstCelTextArr objectAtIndex:0];
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
                
                CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
                
                CGFloat height = MAX(size.height, 50.0f);
                
                return height;

            }
            if (indexPath.row == 4) {
                
                if (Default_IsUserLogin_Value) {
                  
                    return 50;
                }
                else{
                    return 0;
                }

            }
            if (indexPath.row == 1) {
                return 100;
            }
            if (indexPath.row == 5) {
                
               
                if (Default_IsUserLogin_Value && self.discountListArr.count != 0) {
       
                    return 30;
                }
                else{
                    return 0;
                }

            }
            else{
                return 50;
            }
                       
        }
       
       
    }
    else{
        if (indexPath.section == 0) {
            return 0;
        }
        if (indexPath.section == 1 ) {
            return 100;
        }
        if (indexPath.section == 2 ) {
            return 90;
        }
        if (indexPath.section == 3 ) {
            if (indexPath.row == 0) {
                firstCellText = [self.firstCelTextArr objectAtIndex:0];
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
                
                CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
                
                CGFloat height = MAX(size.height, 50.0f);
                
                
                NSLog(@"---------------  %f",height);
                
                return height;

            }
            
            if (indexPath.row == 1) {
                return 100;
            }
            if (indexPath.row == 4) {
                
                if (Default_IsUserLogin_Value) {
                    
                    return 50;
                }
                else{
                    return 0;
                }
                
            }
            if (indexPath.row == 5) {
                
                if (Default_IsUserLogin_Value && self.discountListArr.count != 0) {
                    
                    return 30;
                }
                else{
                    return 0;
                }

            }

            else{
                return 50;
            }
           
        }
     
       

    }
    
     return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 3) {   // 往返
        switch (indexPath.section) {
            case 0:
            {
                return nil;
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
                

                cell.imageView.frame = CGRectMake(0, 0,0 , 0);
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"bg_blue.png"] forState:UIControlStateHighlighted];
                [cell.changeTicket setBackgroundImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:0];
                cell.HUButton.text = self.searchDate.temporaryLabel;
                cell.airPortName.text = self.searchDate.goAirportName;
                cell.startTime.text = self.searchDate.beginTime;
                cell.endTime.text = self.searchDate.endTime;
                cell.startAirPortName.text = self.searchDate.startPortName;
                cell.endAirPortName.text = self.searchDate.endPortName;
                cell.plantType.text = self.searchDate.cabinNumber;
                
                cell.changeTicket.tag = 1;
                [cell.changeTicket addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside]; // 记录退改签
                
                cell.date.text = [self.searchDate.beginDate substringWithRange:NSMakeRange(5, 5)];
                
                cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
               
                return cell;
                break;
            }
            case 2:
            {
                static NSString *CellIdentifier = @"Cell2";
                WriteOrderGreenCell *cell = (WriteOrderGreenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell)
                {
                    [[NSBundle mainBundle] loadNibNamed:@"WriteOrderGreenCell" owner:self options:nil];
                    cell = self.greenCell;
                }
        //        cell.imageView.image = [UIImage imageNamed:@"bg_green.png"];
               [cell.changeTicket setBackgroundImage:[UIImage imageNamed:@"btn_green_rule.png"] forState:0];
                
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"bg_green.png"] forState:UIControlStateHighlighted];
                
          //      cell.backView.frame = CGRectMake(50, 0, 325, 80);
                cell.HUButton.text = self.searchBackDate.temporaryLabel;
                cell.airPortName.text = self.searchBackDate.backAirportName;
                cell.startTime.text = self.searchBackDate.beginTime;
                cell.endTime.text = self.searchBackDate.endTime;
                cell.startAirPortName.text = self.searchBackDate.startPortName;
                cell.endAirPortName.text = self.searchBackDate.endPortName;
                cell.plantType.text = self.searchBackDate.cabinNumber;
            //    cell.date.text = self.searchBackDate.backDate;
                cell.date.text = [self.searchBackDate.backDate substringWithRange:NSMakeRange(5, 5)];
                cell.changeTicket.tag = 2;
                [cell.changeTicket addTarget:self action:@selector(changeTwoInfo:) forControlEvents:UIControlEventTouchUpInside]; // 记录退改签
                
                cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
                
                return cell;
                break;
                
            }
            case 3:
            {
                if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
                    static NSString *CellIdentifier = @"Cell3";
                    WriterOrderCommonCell *cell = (WriterOrderCommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"WriterOrderCommonCell" owner:self options:nil];
                        cell = self.writerOrderCommonCell;
                    }
                    switch (indexPath.row) {
                        case 0:
                        {
                            firstCellText = [self.firstCelTextArr objectAtIndex:0];;
                            
                            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                            
                            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
                            
                            cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                            
                            cell.secondLable.frame = CGRectMake(110, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.firstLable.frame = CGRectMake(21, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.backView.frame = CGRectMake(0, 0, 320, MAX(size.height, 50.0f));
                            
                            cell.imageLabel.frame = CGRectMake(10, MAX(size.height, 50.0f)/2-6, 7, 21);
                            
                            cell.secondLable.text = firstCellText;
                            
                            cell.firstLable.text = @"乘  机  人";
                            
                            break;
                            
                        }
                            
                            
                        case 3:
                            cell.firstLable.text = @"行  程  单";
                            cell.secondLable.text = @"不需要行程单报销凭证";
                            self.traveType = 1;
                            
                            cell.imageLabel.hidden = YES;
                            break;
                        case 2:
                            cell.firstLable.text = @"购买保险";
                            
                            cell.imageLabel.hidden = YES;
                            break;
                            
                            
                        default:
                            break;
                    }
                    
                    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                    cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
                    
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
                    [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.nameField.delegate = self;
                    cell.phoneField.delegate = self;
                    
                    cell.nameField.text = [addPersonArr objectAtIndex:0];
                    cell.phoneField.text = [addPersonArr objectAtIndex:1];
                    
                    
                    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                    cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
                    
                    
                    
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
                    if (Default_IsUserLogin_Value) {
                        
                        
                        cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                        cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
                        
                        return cell;
                        
                    }
                    else
                    {
                        
                        cell.hidden = YES;
                        return cell;
                    }
                    
                    
                    
                }
                if (indexPath.row == 5) {
                    static NSString *CellIdentifier = @"Cell8";
                    SalesCell *cell = (SalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"SalesCell" owner:self options:nil];
                        cell = self.salesCell;
                    }
                    
                    if (Default_IsUserLogin_Value && self.discountListArr.count != 0) {
                        return cell;
                        
                    }
                    else
                    {
                        
                        cell.hidden = YES;
                        return cell;
                    }

                    
                }
                break;
            
        }
    }
    }
    else if(self.flag == 1)
    {
        switch (indexPath.section) {
            case 0:
            {
                return nil;
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
                
       //         cell.imageView.image = [UIImage imageNamed:@"bg_blue.png"];
                [cell.changeTicket setBackgroundImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:0];

                [cell.btn setBackgroundImage:[UIImage imageNamed:@"bg_blue.png"] forState:UIControlStateHighlighted];
                
                cell.HUButton.text = self.searchDate.temporaryLabel;
                cell.airPortName.text = self.searchDate.goAirportName;
                cell.startTime.text = self.searchDate.beginTime;
                cell.endTime.text = self.searchDate.endTime;
                cell.startAirPortName.text = self.searchDate.startPortName;
                cell.endAirPortName.text = self.searchDate.endPortName;
                cell.plantType.text = self.searchDate.cabinNumber;
                cell.date.text = [self.searchDate.beginDate substringWithRange:NSMakeRange(5, 5)];
                
                cell.changeTicket.tag = 1;
                
                [cell.changeTicket addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside]; // 记录退改签
                
                
                cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;

                
                return cell;
                break;
            }
            case 2:
            {
                if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 ) {
                    static NSString *CellIdentifier = @"Cell3";
                    WriterOrderCommonCell *cell = (WriterOrderCommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"WriterOrderCommonCell" owner:self options:nil];
                        cell = self.writerOrderCommonCell;
                    }
                    switch (indexPath.row) {
                        case 0:
                            cell.firstLable.text = @"乘 机  人";
                            
                            firstCellText = [self.firstCelTextArr objectAtIndex:0];
                            
                            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                            
                            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];                            
                          
                            cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                             
                            cell.secondLable.frame = CGRectMake(110, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.firstLable.frame = CGRectMake(23, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.backView.frame = CGRectMake(0, 0, 320, MAX(size.height, 50.0f));
                            
                            cell.secondLable.text = firstCellText;
                            
                            cell.imageLabel.frame = CGRectMake(10, MAX(size.height, 50.0f)/2-6, 7, 21);
                            cell.sortImageView.frame = CGRectMake(301, MAX(size.height, 50.0f)/2-6, 9, 14);
                            
                            cell.fristImageView.frame = CGRectMake(0, MAX(size.height-1, 49.0f), 320,1);
                            cell.secImageView.frame = CGRectMake(0, MAX(size.height, 50.0f), 320,1);
                            break;
                        case 2:
                            cell.firstLable.text = @"购买保险";
                            cell.imageLabel.text = @" ";
                            break;
                        case 3:
                            cell.firstLable.text = @"行  程  单";
                            cell.secondLable.text = @"不需要行程单报销凭证";
                            self.traveType = 1;   // 默认带进去就是不要行程单
                            
                            cell.imageLabel.text = @" ";
                            break;
                   
                            
                        default:
                            break;
                    }
                    
                    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                    cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;

                    
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
                    
                    cell.nameField.delegate = self;
                    cell.phoneField.delegate = self;
                    [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.nameField.text = [addPersonArr objectAtIndex:0];
                    cell.phoneField.text = [addPersonArr objectAtIndex:1];
                    
                    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                    cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;
                    
                    
                    return cell;
                }
                if (indexPath.row == 4) {
                   
                    static NSString *CellIdentifier = @"Cell5";
                    WirterOrderTwoLineCell *cell = (WirterOrderTwoLineCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    
                                       
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"WirterOrderTwoLineCell" owner:self options:nil];
                        cell = self.wirterOrderTwoLineCell;
                        cell.firLable.text = @"";
                    }
                    if (Default_IsUserLogin_Value) {
                        
          
                        
                        cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
                        cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;

                        
                        return cell;
                        
                    }
                    else
                    {
                 
                        cell.hidden = YES;
                        return cell;
                    }

                }
                if (indexPath.row == 5) {
                    static NSString *CellIdentifier = @"Cell8";
                    SalesCell *cell = (SalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"SalesCell" owner:self options:nil];
                        cell = self.salesCell;
                    }
                    
                    if (Default_IsUserLogin_Value && self.discountListArr.count != 0) {
                        return cell;
                        
                    }
                    else
                    {
                        
                        cell.hidden = YES;
                        return cell;
                    }

                    
                }

                break;
                
            }
        }
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.orderTableView deselectRowAtIndexPath:indexPath animated:NO];
    
  
    
    if (self.flag == 3) {
        if (indexPath.section == 1) {
            return;
        }
        if (indexPath.section == 2) {
            return;
        }
    }
    if (self.flag == 1) {
        if (indexPath.section == 1) {
            return;
        }
    }

    if (indexPath.row == 0) {
        
        
        if (selectDicount) {     // 判断如果已经选择了优惠券，有重新选择乘机人，优惠券要重新选择
            
            int section;
            if (self.flag == 1) {
                section =2;
            }
            else{
                section =3;
            }
            
            WirterOrderTwoLineCell * cell = (WirterOrderTwoLineCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:section]];
            
            cell.secLabel.text = @"账户资金/优惠券抵用";
            
            cell.firLable.text = @"不使用银币，优惠券和金币及资金账户";
        
        }
        
        personNumber = 1;
        childNumber = 0; // 再次进入的时候清空初始人数；
        
        if (!Default_IsUserLogin_Value) {
            
            AddPersonController * person = [[AddPersonController alloc] init];   // 添加乘机人列表
            
            [person getDate:^(NSString *name, NSString *identity) {
               
               WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[tableView cellForRowAtIndexPath:indexPath];
                cell.secondLable.text = [NSString stringWithFormat:@"%@(%@)",name,identity];
            }];
            [self.navigationController pushViewController:person animated:YES];
            [person release];
        }
        else   // 如已经登陆就如选择乘机人列表
        {
            ChoosePersonController * choose = [[ChoosePersonController alloc] init];
            
            choose.indexArr = self.indexArr;
            
           
            [self.stringArr removeAllObjects];
            
            stringAfterJoin = @"";
            
            [choose getDate:^(NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableDictionary *flightPassengerIdDic,NSMutableDictionary * certTypeDic,NSMutableArray * arr)
             {

                 if (arr.count != 0) {
                     if (type.allKeys.count > [self.searchDate.ticketCount intValue]) {
                         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已超过本舱位可预订的剩余座位数。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                         [alert show];
                         [alert release];
                         return ;
                     }
                     
                     if (self.searchBackDate.ticketCount != NULL) {
                         
                         if (type.allKeys.count > [self.searchBackDate.ticketCount intValue]) {
                             
                             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请减少乘机人数目。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                             [alert show];
                             [alert release];
                             return ;
                         }
                     }
                     
                     
                     self.indexArr = arr;   // 把后边添加的标记的联系人传过来
                     
                     
                     
                     [self.personArray removeAllObjects];
                     
                     for (int i = 0; i<name.allKeys.count; i++) {
                         
                         NSString * str1 = [name objectForKey:[name.allKeys objectAtIndex:i]];
                         NSString * str2 = [identity objectForKey:[identity.allKeys objectAtIndex:i]];
                         NSString * str3 = [type objectForKey:[type.allKeys objectAtIndex:i]];
                         NSString * str4 = [flightPassengerIdDic objectForKey:[flightPassengerIdDic.allKeys objectAtIndex:i]];
                         NSString * str5 = [certTypeDic objectForKey:[certTypeDic.allKeys objectAtIndex:i]];
                         
                         
                         // *******  加入到填写订单时候的 flightPassengerVo
                         flightPassengerVo * passenger = [[flightPassengerVo alloc] init];
                         
                         passenger.name = str1;
                         passenger.certNo = str2;
                         passenger.type = str3;
                         passenger.flightPassengerId = str4;
                         passenger.certType = str5;
                         
                         passenger.goInsuranceNum = @"0";
                         passenger.returnInsuranceNum = @"0";
                         
                         [self.personArray addObject:passenger];
                         [passenger release];
                         // ****
                         
                         
                         if ([str3 isEqualToString:@"01"]) {
                             str3  = @"成人";
                         }
                         else{
                             str3 = @"儿童";
                         }
                         
                         NSString * string = [NSString stringWithFormat:@"%@ (%@) \n%@",str1,str3,str2];
                         
                         if ([str3 isEqualToString:@"儿童"]) {
                             childNumber = childNumber + 1;
                         }
                         
                         [self.stringArr addObject:string];
                     }
                     
                     
                     // *****************  常用联系人自动匹配第一个乘机人
                     
                     if (self.personArray.count != 0) {
                         flightPassengerVo * passenger = [self.personArray objectAtIndex:0];
                         
                         [addPersonArr replaceObjectAtIndex:0 withObject:passenger.name];
                         [addPersonArr replaceObjectAtIndex:1 withObject:@""];
                         
                     }
                     
                     
                     
                     //****************
                     
                     
                     personNumber = type.allKeys.count-childNumber;  // 此处获得了选择的成人和儿童的人数
                     
                     
                     for (int i = 0; i<self.stringArr.count; i++) {
                         
                         if ([stringAfterJoin isEqualToString:@""]) {
                             stringAfterJoin = [NSString stringWithFormat:@"%@",[self.stringArr objectAtIndex:i]];
                         }
                         else{
                             stringAfterJoin = [NSString stringWithFormat:@"%@\n%@",stringAfterJoin,[self.stringArr objectAtIndex:i]];
                         }
                         
                     }
                     
                     // 动态修改定单的金额数
                     self.personMuber.text = [NSString stringWithFormat:@"%d",personNumber];  //  改变成人和儿童的数目
                     self.childMunber.text = [NSString stringWithFormat:@"%d",childNumber];
                     
                     self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber];
                     self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber];
                     self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber];
                     
                     if (stringAfterJoin != @"") {
                         [self.firstCelTextArr replaceObjectAtIndex:0 withObject:stringAfterJoin];
                     }
                     
                     
                     
                     
                     //默认所有乘机人都选择保险
                     if (self.flag == 1) {
                         WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
                         
                         cell.secondLable.text = [NSString stringWithFormat:@"20元/份*%d人" ,personNumber+childNumber];
                     }
                     else{
                         WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]];
                         
                         cell.secondLable.text = [NSString stringWithFormat:@"20元/份*%d人" ,personNumber+childNumber];
                     }
                     
                     
                     //把保险的钱数加上
                     
                     self.swithType = @"ON";  // 默认保险的开关打开
                     
                     self.Personinsure.text = @"￥20";
                     self.childInsure.text = @"￥20";
                     
                     for (flightPassengerVo * passenger in self.personArray) {   // 默认乘机人都买上保险
                         passenger.goInsuranceNum = @"1";
                     }
                     
                     self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20*(personNumber + childNumber)];
                     self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20*(personNumber + childNumber)];
                     self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20*(personNumber + childNumber)];
                     
                     if (stringAfterJoin != @"") {  
                         [self.orderTableView reloadData];
                     }
                 }
           
               
             
                
            }];
            
            [self.navigationController pushViewController:choose animated:YES];
        }
    }
    if (indexPath.row == 2) {

        BuyInsuranceViewController * insurance = [[BuyInsuranceViewController alloc] init];
        
        insurance.type = self.swithType;
        
        [insurance getDate:^(NSString *idntity,NSString * type) {
   
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            
            self.swithType = type;   // 记录开关状态
            
            
            NSLog(@"~~~~~~~~~~~~~~~~~~~~~%@",idntity);
                         
            if (idntity != nil) {
                NSLog(@"%s,%d",__FUNCTION__,__LINE__);
                for (flightPassengerVo * passenger in self.personArray) {
                    passenger.goInsuranceNum = @"1";
                }
                insuranceFlag = 1;
                cell.secondLable.text = [NSString stringWithFormat:@"20元/份*%d人",personNumber+childNumber];
                self.Personinsure.text = @"￥20";
                self.childInsure.text = @"￥20";
                
                if ([self.postType isEqualToString:@"快递"]) {
                    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) + 20];
                    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) + 20];
                    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) + 20];
                }

                else{
                    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                }
               
       
                
            }
            else{

                cell.secondLable.text = @"不需要购买保险";
                self.Personinsure.text = @"0";
                self.childInsure.text = @"0";
                insuranceFlag = 0;
                for (flightPassengerVo * passenger in self.personArray) {
                    passenger.goInsuranceNum = @"0";
                }

                
                if ([self.postType isEqualToString:@"快递"]) {
                    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20 ];
                    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20];
                    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +20];
                }
                else
                {
                    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];
                    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];
                    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];
                }
                
                
                

            }
           
               [self.orderTableView reloadData];
        }];
        
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];

    }
    if (indexPath.row == 3) {
        
        TraveController * trave = [[TraveController alloc] init];
        
        trave.flag = self.traveType;
        
        [trave getDate:^(NSString *schedule, NSString *postPay, int chooseBtnIndex , NSArray * InfoArr) {
            
            
            self.postType = postPay;
            NSLog(@"%@,,,%@,,,%d",schedule,postPay,chooseBtnIndex);
            
            /// **************  填写行程单配送信息
            if (chooseBtnIndex != 0) {
                flightItinerary.deliveryType = [NSString stringWithFormat:@"%d",chooseBtnIndex-1];
            }
            
            if (chooseBtnIndex == 3) {
                flightItinerary.address = [InfoArr objectAtIndex:2];
                flightItinerary.city = [InfoArr objectAtIndex:1];
                flightItinerary.mobile = [InfoArr objectAtIndex:3];
                flightItinerary.postCode = nil;
                flightItinerary.catchUser = [InfoArr objectAtIndex:0];
                flightItinerary.isPromptMailCost = @"0";

            }
            else{
                flightItinerary.address = nil;
                flightItinerary.city = nil;
                flightItinerary.mobile = nil;
                flightItinerary.postCode = nil;
                flightItinerary.catchUser = nil;
                flightItinerary.isPromptMailCost = @"0";

            }
            
       
            
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            
            if (chooseBtnIndex != 0) {
                
                self.traveType = chooseBtnIndex;
                
                cell.secondLable.text = schedule;
            }
            
            
            
            if ([postPay isEqualToString:@"快递"]) {
                
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",[self.upPayMoney.text intValue]+20];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + insuranceFlag*20*(personNumber+childNumber)+20];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +insuranceFlag*20*(personNumber+childNumber)+20];
            }
            
            else{
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +insuranceFlag*20*(personNumber+childNumber)];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber+insuranceFlag*20*(personNumber+childNumber)];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber +insuranceFlag*20*(personNumber+childNumber)];
            }
            
       
            
            
            
        }];
        
        [self.navigationController pushViewController:trave animated:YES];
        [trave release];
        
    }
    if (indexPath.row == 4) {
        
        selectDicount = true;
        
        NSString * sign = [NSString stringWithFormat:@"%@%@%@",Default_UserMemberId_Value,@"xx",Default_Token_Value];
        NSString *signReal =GET_SIGN(sign);

        
        UseGoldPay * gold = [[UseGoldPay alloc] initWithIsOpenAccount:@"true"
                                                          andMemberId:Default_UserMemberId_Value
                                                              andSign:signReal
                                                        andOrderPrice:[NSString stringWithFormat:@"%d",[self.goPay intValue] + [self.backPay intValue]]
                                                        andTotalPrice:self.allPay.text
                                                          andProdType:@"01"
                                                            andSource:@"xx"
                                                        andAirCompany:nil
                                                               andDpt:nil
                                                               andArr:nil
                                                           andDisount:nil
                                                      andInsuranceNum:nil
                                               andInsuranceTotalPrice:nil
                                                              andHwld:HWID_VALUE];
        
        DiscountCouponController * discount = [[DiscountCouponController alloc] init];
        
        discount.gold = gold;
        discount.indexArr = self.indexGoldArr;
        discount.type = self.swithTypeForGold;
        
        [discount getDate:^(NSString *swithStation, NSString *silverOrDiscount, NSString *gold, NSMutableArray *arr, NSString * password, NSString * ID) {
            
            self.swithTypeForGold = swithStation;
            
            self.indexGoldArr = arr;

            
            WirterOrderTwoLineCell * cell = (WirterOrderTwoLineCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            cell.secLabel.text = @"账户资金/优惠券抵用";
            if ([swithStation isEqualToString:@"OFF"]) {
                cell.firLable.text = @"不使用银币，优惠券和金币及资金账户";
            }
            else
            {
                goldAndCount = gold;  // 赋值金币和资金账户
                passWord = password;
                
                if (arr.count != 0) {
                    if ([[arr objectAtIndex:0] isEqualToString:@"0"]) {
                        
                        silverString = silverOrDiscount;
                        cell.firLable.text = [NSString stringWithFormat:@"使用银币￥%@",silverOrDiscount];  // 使用银币
                    }
                    else{
                        
                        captchaString = silverOrDiscount;
                        captchaID = ID;
                        cell.firLable.text = [NSString stringWithFormat:@"使用优惠券%@",silverOrDiscount];   // 使用优惠券
                    }

                }
                
            }
   
            self.upPayMoney.text = [NSString stringWithFormat:@"%d",[self.upPayMoney.text intValue]-[silverOrDiscount intValue]-[gold intValue]];
            self.bigUpPayMoney.text = self.upPayMoney.text;
            self.allPay.text = self.upPayMoney.text;
            
            NSLog(@"%@,%@,%@,%@",swithStation,silverOrDiscount,gold,arr);
        }];
        
        [self.navigationController pushViewController:discount animated:YES];
        [discount release];
    }
}
- (IBAction)payMoney:(id)sender {
    
    // 判断手机号格式是否正确
    if (self.flag == 3)
    {
 
        WriteOrderDetailsCell *cell = (WriteOrderDetailsCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
        
        if (![self checkTel:cell.phoneField.text]) {
         
            return;
        }
        
                
        
    }
    else{
       
        WriteOrderDetailsCell *cell = (WriteOrderDetailsCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
       
        
        if (![self checkTel:cell.phoneField.text]) {
         
            return;
        }
    }

    
    // 去成和往返信息
    bookingGoFlightVo * go = [[bookingGoFlightVo alloc] init];
    
    go.dptAirportName = self.searchDate.startPortName;
    go.arrAirportName = self.searchDate.endPortName;
    go.aircraftType = self.searchDate.palntType;
    go.airlineCompanyCode = self.searchDate.airPort;
    go.arrivalAirportCode = self.searchDate.endPortThreeCode;
    go.arrivalDateStr = self.searchDate.beginDate;
    go.arrivalTerminal = nil;
    go.arrivalTimeStr = self.searchDate.endTime;
    go.cabinCode = self.searchDate.cabinCode;
    go.departureAirportCode = self.searchDate.startPortThreeCode;
    go.departureDateStr = self.searchDate.beginDate;
    go.departureTerminal = nil;
    int lenght = [self.searchDate.temporaryLabel length];
    NSString * flightNo = [self.searchDate.temporaryLabel substringWithRange:NSMakeRange(2, lenght-2)];    
    go.departureTimeStr = self.searchDate.beginTime;    
    go.flightNo = flightNo;    
    go.flightType = @"1";
    go.orderType = @"0";
    go.prodType = @"0";
    go.rmk = nil;
    go.ticketType = @"0";
    go.flightOrgin = @"B2B";    
    
    
    bookingReturnFlightVo * bookReturn = [[bookingReturnFlightVo alloc] init];
    
    
    bookReturn.aircraftType = self.searchBackDate.palntType;
    bookReturn.airlineCompanyCode = self.searchBackDate.airPort;
    bookReturn.arrivalAirportCode = self.searchBackDate.endPortThreeCode;
    bookReturn.arrivalDateStr = self.searchBackDate.beginDate;
    bookReturn.arrivalTerminal = nil;
    bookReturn.arrivalTimeStr = self.searchBackDate.endTime;
    bookReturn.cabinCode = self.searchBackDate.cabinCode;
    bookReturn.departureAirportCode = self.searchBackDate.startPortThreeCode;
    bookReturn.departureDateStr = self.searchBackDate.beginDate;
    bookReturn.departureTerminal = nil;
    int lenght1 = [self.searchBackDate.temporaryLabel length];
    NSString * flightNo1 = [self.searchBackDate.temporaryLabel substringWithRange:NSMakeRange(2, lenght1-2)];
    bookReturn.departureTimeStr = self.searchBackDate.beginTime;
    bookReturn.flightNo = flightNo1;
    bookReturn.flightType = @"2";
    bookReturn.orderType = @"0";
    bookReturn.prodType = @"0";
    bookReturn.rmk = nil;
    bookReturn.ticketType = @"0";
    bookReturn.flightOrgin = @"B2B";
    

    // 优惠券使用
    payVo * pay  = [[payVo alloc] init];
    if (goldAndCount != nil || silverString != nil ) {
        
       
        if (goldAndCount != nil && silverString != nil) {
            pay.isNeedPayPwd = @"yes";
            pay.isNeedAccount = @"yes";
            pay.needNotSilver = @"no";
            pay.payPassword = passWord;
            pay.captcha = captchaID;
        }
        else{
            
            if (silverString != nil) {
                pay.isNeedPayPwd = @"no";
                pay.isNeedAccount = @"no";
                pay.needNotSilver = @"no";  // 需要银币
                pay.payPassword = passWord;
                pay.captcha = captchaID;
            }
            else{
                pay.isNeedPayPwd = @"yes";
                pay.isNeedAccount = @"yes";
                pay.needNotSilver = @"yes";  // 不需要银币
                pay.payPassword = passWord;
                pay.captcha = captchaID;

            }
        }
 
    }
    else
    {
        
        pay.isNeedPayPwd = @"no";
        pay.isNeedAccount = @"no";
        pay.needNotSilver = @"yes";  // 都为空的时候就是不需要使用银币
        pay.payPassword = passWord;
        pay.captcha = captchaID;
        
    }
  
    // 配置去成和往返的杂项信息
    if (self.flag == 1) {
        self.searchType = @"0";
        
        
        bookReturn.flightType = nil;
        bookReturn.orderType = nil;
        bookReturn.prodType = nil;
        bookReturn.rmk = nil;
        bookReturn.ticketType = nil;
        bookReturn.flightOrgin = nil;

    }
    else{
        
        self.searchType = @"1";
       
    }
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.searchType,KEY_FlightBook_prodType,@"hello",KEY_FlightBook_rmk, nil];
    
    
    // 联系人
    
    
    
    
    flightContactVo * contactVo = [[flightContactVo alloc] init];
    contactVo.name = [addPersonArr objectAtIndex:0];
    contactVo.mobile = [addPersonArr objectAtIndex:1];
    
    
    NSLog(@"====================================================  %@",flightItinerary.deliveryType);
    
    [FlightBookingBusinessHelper flightBookingWithGoflight:dic        // 杂项
                                         bookingGoFlightVo:go           //去成
                                     bookingReturnFlightVo:bookReturn  // 返程
                                           flightContactVo:contactVo     // 联系人
                                         flightItineraryVo:flightItinerary      // 行程单
                                         flightPassengerVo:self.personArray      // 乘客信息
                                                     payVo:pay   // 优惠券信息
                                                  delegate:self];
    
    
    // 保存最后一次订单中乘机人信息
    
    [self.personArray writeToFile:[self filePath] atomically:YES];
    
    NSMutableArray * IDArr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray * certNoArr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray * certTypeArr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray * nameArr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray * typeArr = [NSMutableArray arrayWithCapacity:5];
    
    for (flightPassengerVo * vo in self.personArray) {
        [IDArr addObject:vo.flightPassengerId];
        [certNoArr addObject:vo.certNo];
        [certTypeArr addObject:vo.certType];
        [nameArr addObject:vo.name];
        [typeArr addObject:vo.type];
    }
    

    NSMutableArray * arr = [NSMutableArray arrayWithObjects:IDArr,certNoArr,certTypeArr,nameArr,typeArr, nil];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"personArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
}

//保存最后一次乘机人文件路径
- (NSString *)filePath
{
    //document路径
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//在沙盒DomainMask里边走索NSDocumentDirectory，返回一个路径
    //具体文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"person"];//找到里边的文件。。在docPath后边拼接一个，@"A/texts"这样不行，不能创建文件夹。
    
    return path;
    
    
}



-(void)addPersonFormAddressBook
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)changeToBigHeadView:(id)sender {
    
    self.tempView = self.bigHeadView;
    
    self.headViewHegiht = 97.0f;
    [self.orderTableView reloadData];
}

- (IBAction)changeToSmallHeadView:(id)sender {
    self.tempView = self.headView;
    self.headViewHegiht = 40.0f;
    
//    self.upPayMoney.text = [NSString stringWithFormat:@"%d",finalPay];
//    self.allPay.text = [NSString stringWithFormat:@"%d",finalPay];
    
    [self.orderTableView reloadData];
}

-(void)add
{
//    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self;
//    [self presentModalViewController:picker animated:YES];
//    [picker release];

}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    //是否存在此人 开关
    haveThisMan = NO;
    
    //获取联系人姓名
    NSString * name = (NSString*)ABRecordCopyCompositeName(person);
    
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++)
    {
        NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i) autorelease];
        NSString *aLabel = [(NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i) autorelease];
        
        //获取号码
        NSString * temp1 =  [aPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        NSString * new = [temp1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString * phone = new;
        NSLog(@"PhoneLabel:%@ Phone#:%@",aLabel,aPhone);
        
        [addPersonArr replaceObjectAtIndex:0 withObject:name];
        [addPersonArr replaceObjectAtIndex:1 withObject:aPhone];

        //查重
        NSDictionary * oneMan = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name",phone,@"phone", nil];
        for (NSDictionary * dic in nameAndPhone) {
            if ([[dic valueForKey:@"name"] isEqualToString:name]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"已存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [alert release];
                haveThisMan = YES;
                return NO;
            }
        }
        //将联系人添加到数组中
        if (haveThisMan == NO) {
            [nameAndPhone addObject:oneMan];
        }
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"]){
            [phones addObject:aPhone];
            NSLog(@"[phones count] : %d",[phones count]);
        }
    }
    //    //获取号码
    //    if([phones count]>0)
    //    {   NSLog(@"[phones count]>0");
    //        phone = [phones objectAtIndex:0];
    //    }
    
    
    //获取联系人邮箱
    ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    for (int i = 0;i < ABMultiValueGetCount(emailMulti); i++)
    {
        //邮箱地址
        NSString *emailAdress = [(NSString*)ABMultiValueCopyValueAtIndex(emailMulti, i) autorelease];
        [emails addObject:emailAdress];
    }
    //    if([emails count]>0){
    //        NSString *emailFirst=[emails objectAtIndex:0];
    //        NSString * email = emailFirst;
    //    }
   // [self resetSendMessageBtnFrame];
    [peoplePicker dismissModalViewControllerAnimated:YES];
    
    [self.orderTableView reloadData];
      
    return NO;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)log
{
    LogViewController * log = [[LogViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
    [log release];
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

    
    NSArray * arr = [info objectForKey:@"dic"];
    
    
    // 支付
    PayOnline * payOnline = [[PayOnline alloc] initWithProdType:@"01"
                                                        payType:@"umpay"
                                                      orderCode:[arr objectAtIndex:1]
                                                       memberId:[arr objectAtIndex:2]
                                                      actualPay:[arr objectAtIndex:3]
                                                         source:@"51you"
                                                           hwId:HWID_VALUE
                                                    serviceCode:@"01"
                                                    andDelegate:self];

    
  // 获取订单详情
    NSString * sign = [NSString stringWithFormat:@"%@%@%@",Default_UserMemberId_Value,SOURCE_VALUE,Default_Token_Value];
    
    OrderDetaile * order = [[OrderDetaile alloc] initWithOrderId:[arr objectAtIndex:0]
                                                     andMemberId:[arr objectAtIndex:2]
                                                    andCheckCode:[arr objectAtIndex:1]
                                                         sndSign:GET_SIGN(sign)
                                                       sndSource:SOURCE_VALUE
                                                         andHwId:HWID_VALUE
                                                      andEdition:EDITION_VALUE
                                                     andDelegate:self];
    
    
    PayViewController * pay = [[PayViewController alloc] init];
    pay.orderDetaile = order;
    pay.payOnline = payOnline;
    pay.searchType = self.searchType;
    [self.navigationController pushViewController:pay animated:YES];
    [pay release];

}


-(void)changeInfo:(UIButton *)btn
{

    NSString * string = nil;

      
    string =[NSString stringWithFormat:@"%@", self.searchDate.cabinInfo];

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"退改签信息" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}
-(void)changeTwoInfo:(UIButton *)btn
{

    NSString * string = nil;
    
    
    string =[NSString stringWithFormat:@"%@", self.searchBackDate.cabinInfo];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"退改签信息" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}


#pragma mark UIScrollViewDelegate Methods

- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert release];
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert release];
        
        return NO;
    }
    return YES;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
    if (self.flag == 3)
    {
        WriteOrderDetailsCell *cell = (WriteOrderDetailsCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
        
        [addPersonArr replaceObjectAtIndex:0 withObject:cell.nameField.text];
        [addPersonArr replaceObjectAtIndex:1 withObject:cell.phoneField.text];
        
        [cell.nameField resignFirstResponder];
        [cell.phoneField resignFirstResponder];
        
    }
    else{
        
        WriteOrderDetailsCell *cell = (WriteOrderDetailsCell *)[self.orderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];

        [addPersonArr replaceObjectAtIndex:0 withObject:cell.nameField.text];
        [addPersonArr replaceObjectAtIndex:1 withObject:cell.phoneField.text];
        
        [cell.nameField resignFirstResponder];
        [cell.phoneField resignFirstResponder];
    }

    
  
    

}

@end
