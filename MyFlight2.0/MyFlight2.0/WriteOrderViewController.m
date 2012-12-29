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
#import "UseGoldPay.h"
#import "flightContactVo.h"
#import "flightPassengerVo.h"
#import "flightItineraryVo.h"
#import "payVo.h"
#import "bookingGoFlightVo.h"
#import "FlightBookingBusinessHelper.h"
#import "bookingReturnFlightVo.h"
#import "UIQuickHelp.h"


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
    
    NSMutableArray * addPersonArr;
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
    newChildAllPay = (childPersonMoney+childAirPortName+childOil);
    
    finalPay = newPersonAllPay + newChildAllPay;
    
    
    self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0];
    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0]; // 默认开始进入没有儿童
    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay+0];
    
}
- (void)viewDidLoad
{
    personNumber = 1;  // 默认一个成人
    childNumber = 0;
    
    
    NSLog(@"%d,%@",self.searchDate.pay,self.searchBackDate.childPrice);
    NSLog(@"%@,%@",self.searchDate.ticketCount,self.searchBackDate.ticketCount);
    
    [self calculateAllPay];

    self.firstCelTextArr = [NSMutableArray arrayWithObject:@""];
    self.navigationItem.title = @"填写订单";
    
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(260, 5, 40, 31);
    histroyBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [histroyBut setTitle:@"登陆" forState:UIControlStateNormal];
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_2words_.png"]];
    [histroyBut addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];

    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    self.indexArr = [[NSMutableArray alloc] init];
    addPersonArr = [[NSMutableArray alloc]initWithObjects:@"王健",@"13120397709", nil];
    self.indexGoldArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    self.tempView = self.headView;
    self.headViewHegiht = 40;
    
    
       
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
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
            return self.headViewHegiht-30;
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
                return 7;
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
                return 7;
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
        if (indexPath.section == 2 && indexPath.row == 0) {
            
           firstCellText = [self.firstCelTextArr objectAtIndex:0];
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
            
            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
            
            CGFloat height = MAX(size.height, 50.0f);
           
            return height;
            
        }
        if (indexPath.row == 4 && indexPath.section == 1) {
            if (Default_IsUserLogin_Value) {
                return 50;
            }
            else{
                return 0;
            }
        }
        if (indexPath.section == 2 && indexPath.row == 1) {
            return 100;
        }
        else{
            return 50;
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
            return 100;
        }
        if (indexPath.section == 3 && indexPath.row == 0) {
            firstCellText = [self.firstCelTextArr objectAtIndex:0];
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
            
            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
            
            CGFloat height = MAX(size.height, 50.0f);
            
            return height;

        }
        if (indexPath.section == 3 && indexPath.row == 1) {
            return 100;
        }
        else{
            return 50;
        }

    }
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
          //  cell.bounds.origin.x = 50;
            
        
            cell.backView.frame = CGRectMake(50, 0, 325, 80);
            cell.imageView.image = [UIImage imageNamed:@"bg_blue__.png"];
            cell.userInteractionEnabled = NO;
            
            cell.HUButton.text = self.searchDate.temporaryLabel;
            cell.airPortName.text = self.searchDate.airPort;
            cell.startTime.text = self.searchDate.beginTime;
            cell.endTime.text = self.searchDate.endTime;
            cell.startAirPortName.text = self.searchDate.startPortName;
            cell.endAirPortName.text = self.searchDate.endPortName;
            cell.plantType.text = self.searchDate.cabinNumber;
            
            cell.date.text = self.searchDate.beginDate;
                       
            return cell;
            break;
        }
         case 2:
        {
            static NSString *CellIdentifier = @"Cell1";
            WriteOrderCell *cell = (WriteOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                [[NSBundle mainBundle] loadNibNamed:@"WriteOrderCell" owner:self options:nil];
                cell = self.writeOrderCell;
            }
            cell.imageView.image = [UIImage imageNamed:@"bg_green__.png"];
            cell.userInteractionEnabled = NO;
            
            cell.HUButton.text = self.searchBackDate.temporaryLabel;
            cell.airPortName.text = self.searchBackDate.airPort;
            cell.startTime.text = self.searchBackDate.beginTime;
            cell.endTime.text = self.searchBackDate.endTime;
            cell.startAirPortName.text = self.searchBackDate.startPortName;
            cell.endAirPortName.text = self.searchBackDate.endPortName;
            cell.plantType.text = self.searchBackDate.cabinNumber;
            cell.date.text = self.searchBackDate.backDate;
            
            return cell;
            break;
            
        }
        case 3:
        {
            if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6) {
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
                        
                        cell.secondLable.text = firstCellText;
                        
                        cell.firstLable.text = @"乘机人";
                     //   NSLog(@"++++++++   %@",cell.firstLable.text);

                    }
                        
                    case 2:
                        cell.firstLable.text = @"购买保险";
                        cell.imageLabel.hidden = YES;
                        break;
                    case 3:
                        cell.firstLable.text = @"行程单";
                        cell.imageLabel.hidden = YES;
                        break;
                    case 5:
                        cell.firstLable.text = @"活动促销减免";
                        cell.imageLabel.hidden = YES;
                        break;
                    case 6:
                        cell.firstLable.text = @"";
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        cell.imageLabel.hidden = YES;
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
                [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];

                cell.nameField.delegate = self;
                cell.phoneField.delegate = self;
                
                cell.nameField.text = [addPersonArr objectAtIndex:0];
                cell.phoneField.text = [addPersonArr objectAtIndex:1];
                
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
                
                cell.imageView.image = [UIImage imageNamed:@"bg_blue__.png"];
                cell.userInteractionEnabled = NO;
                
                cell.HUButton.text = self.searchDate.temporaryLabel;
                cell.airPortName.text = self.searchDate.airPort;
                cell.startTime.text = self.searchDate.beginTime;
                cell.endTime.text = self.searchDate.endTime;
                cell.startAirPortName.text = self.searchDate.startPortName;
                cell.endAirPortName.text = self.searchDate.endPortName;
                cell.plantType.text = self.searchDate.cabinNumber;
                cell.date.text = self.searchDate.beginDate;
                
                return cell;
                break;
            }
            case 2:
            {
                if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6) {
                    static NSString *CellIdentifier = @"Cell3";
                    WriterOrderCommonCell *cell = (WriterOrderCommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"WriterOrderCommonCell" owner:self options:nil];
                        cell = self.writerOrderCommonCell;
                    }
                    switch (indexPath.row) {
                        case 0:
                            cell.firstLable.text = @"乘机人";
                            
                            firstCellText = [self.firstCelTextArr objectAtIndex:0];
                            
                            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                            
                            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];                            
                          
                            cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                             
                            cell.secondLable.frame = CGRectMake(110, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.firstLable.frame = CGRectMake(23, 0, 196, MAX(size.height, 50.0f));
                            
                            cell.backView.frame = CGRectMake(0, 0, 320, MAX(size.height, 50.0f));
                            
                            cell.secondLable.text = firstCellText;
                            
                            cell.imageLabel.frame = CGRectMake(10, MAX(size.height, 50.0f)/2-6, 7, 21);
                            
                            break;
                        case 2:
                            cell.firstLable.text = @"购买保险";
                            cell.imageLabel.hidden = YES;
                            break;
                        case 3:
                            cell.firstLable.text = @"行程单";
                            cell.imageLabel.hidden = YES;
                            break;
                        case 5:
                            cell.firstLable.text = @"促销活动减免";
                            cell.imageLabel.hidden = YES;
                            break;
                        case 6:
                            cell.firstLable.text = @"";
                            cell.accessoryType = UITableViewCellAccessoryNone;
                            cell.imageLabel.hidden = YES;
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
//                    cell.personName = [self.cellTitleArr objectAtIndex:1];
//                    cell.phoneNumber = [self.cellTitleArr objectAtIndex:2];
                    
                    cell.nameField.delegate = self;
                    cell.phoneField.delegate = self;
                    [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.nameField.text = [addPersonArr objectAtIndex:0];
                    cell.phoneField.text = [addPersonArr objectAtIndex:1];
                    
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
                    if (Default_IsUserLogin_Value) {
                        
                        cell.firLable.text = @"";
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
    BOOL logFlag = FALSE;  // 此处保留一个flag判断是否用户已经登陆
    if (indexPath.row == 0) {
        
        personNumber = 1;
        childNumber = 0; // 再次进入的时候清空初始人数；
        
        if (logFlag) {
            
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
            
            self.stringArr = [NSMutableArray array];
            
            stringAfterJoin = @"";
            
            [choose getDate:^(NSMutableDictionary * name, NSMutableDictionary * identity ,NSMutableDictionary * type, NSMutableDictionary *flightPassengerIdDic,NSMutableDictionary * certTypeDic,NSMutableArray * arr)
             {
                 
                 
                
                 
                 
                 
                 
                 if (type.allKeys.count > [self.searchDate.ticketCount intValue]) {
                     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请减少乘机人数目。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
                 
                 
                 self.personArray = [NSMutableArray array];
                 
                 
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
                     
                     [self.personArray addObject:passenger];
                     [passenger release];
                     // **** 
                     
                     
                     NSString * string = [NSString stringWithFormat:@"%@%@\n%@",str1,str3,str2];
                     
                     if ([str3 isEqualToString:@"儿童"]) {
                         childNumber = childNumber + 1;
                    }

                    [self.stringArr addObject:string];
                }
                  
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
                
                [self.firstCelTextArr replaceObjectAtIndex:0 withObject:stringAfterJoin];
                [self.orderTableView reloadData];
                
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
                         
            if (idntity != nil) {
                
                cell.secondLable.text = [NSString stringWithFormat:@"20元/份*%d人",personNumber+childNumber];
                self.Personinsure.text = @"20";
                self.childInsure.text = @"20";
                            
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
            }
            else{
                cell.secondLable.text = @"";
                self.Personinsure.text = @"0";
                self.childInsure.text = @"0";
                
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber ];

            }
           
               [self.orderTableView reloadData];
        }];
        
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];

    }
    if (indexPath.row == 3) {
        
        TraveController * trave = [[TraveController alloc] init];
        
        trave.flag = self.traveType;
        
        [trave getDate:^(NSString *schedule, NSString *postPay, int chooseBtnIndex) {
            
            
            /// **************  填写行程单配送信息
            flightItinerary = [[flightItineraryVo alloc] init];
            flightItinerary.deliveryType = @"0";
            flightItinerary.address = nil;
            flightItinerary.city = nil;
            flightItinerary.mobile = nil;
            flightItinerary.postCode = nil;
            flightItinerary.catchUser = nil;
            flightItinerary.isPromptMailCost = @"0";
            
            NSLog(@"--------------------------------------------------- %@",flightItinerary.deliveryType);
            
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            
            self.traveType = chooseBtnIndex;
            
            cell.secondLable.text = schedule;
            
            if ([postPay isEqualToString:@"快递"]) {
                
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) + 20];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) + 20];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) +20];
            }
            
            else{
                self.upPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber) ];
                self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
                self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay*personNumber + newChildAllPay*childNumber + 20*(personNumber+childNumber)];
            }
            
            NSLog(@"%@,%@",schedule,postPay);
            
            
            
        }];
        
        [self.navigationController pushViewController:trave animated:YES];
        [trave release];
        
    }
    if (indexPath.row == 4) {
        
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
        
        [discount getDate:^(NSString *swithStation, NSString *silverOrDiscount, NSString *gold, NSMutableArray *arr) {
            
            self.indexGoldArr = arr;
            
            WirterOrderTwoLineCell * cell = (WirterOrderTwoLineCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            
            cell.secLabel.text = [NSString stringWithFormat:@"%@/%@",silverOrDiscount,gold];
            
            NSLog(@"%@,%@,%@,%@",swithStation,silverOrDiscount,gold,arr);
        }];
        
        [self.navigationController pushViewController:discount animated:YES];
        [discount release];
    }
}
- (IBAction)payMoney:(id)sender {
    bookingGoFlightVo * go = [[bookingGoFlightVo alloc] init];
    
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
    
    go.departureTimeStr = self.searchDate.beginTime;
    
    go.flightNo = self.searchDate.temporaryLabel; 
    
    go.flightType = @"1";
    
    go.orderType = @"0";
    
    go.prodType = @"0";
    
    go.rmk = nil;
    
    go.ticketType = @"0";
    
    go.flightOrgin = @"B2B";
    
    
    bookingReturnFlightVo * bookReturn = [[bookingReturnFlightVo alloc] init];
    
    
    
    payVo * pay  = [[payVo alloc] init];
    pay.isNeedPayPwd = NO;
    pay.isNeedAccount = NO;
    pay.needNotSilver = NO;
    pay.payPassword = nil;
    pay.captcha = nil;
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",KEY_FlightBook_prodType,@"hello",KEY_FlightBook_rmk, nil];
    
    
    flightContactVo * contactVo = [[flightContactVo alloc] init];
    contactVo.name = [addPersonArr objectAtIndex:0];
    contactVo.mobile = [addPersonArr objectAtIndex:1];
    
    [FlightBookingBusinessHelper flightBookingWithGoflight:dic
                                         bookingGoFlightVo:go
                                     bookingReturnFlightVo:bookReturn
                                           flightContactVo:contactVo
                                         flightItineraryVo:flightItinerary
                                         flightPassengerVo:self.personArray
                                                     payVo:pay
                                                  delegate:self];
    
}


-(void)addPersonFormAddressBook
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
    [picker release];
    
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
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

    
}

@end
