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

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 100.0f

@interface WriteOrderViewController ()
{
    int goPay;
    int backPay;
    
    
    int childNumber;  // 儿童个数
    int personNumber; // 成人个数
    
    int finalPay;  // 最终支付的价格
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

- (void)viewDidLoad
{
    self.cellTitleArr = [NSArray arrayWithObjects:@"乘机人",@"联系人",@"联系电话",@"购买保险",@"行程单",@"账户资金/优惠券抵用",@"活动促销减免", nil];
    self.firstCelTextArr = [NSMutableArray arrayWithObject:@""];
    self.navigationItem.title = @"填写订单";
    
    // NSLog(@"-------%d",[self.goPay intValue]);  // 如果是单程的时候按照self.backPay 计算。
     goPay = [self.goPay intValue];
     backPay = [self.backPay intValue];
    
    int airPortName = [self.searchDate.constructionFee intValue];
    int oil = [self.searchDate.adultBaf intValue];

    
    self.upPayMoney.text = [NSString stringWithFormat:@"%d",([self.goPay intValue]+[self.backPay intValue]+airPortName+oil)];  // 暂时的 此处还没有添加保险金额
    self.allPay.text = [NSString stringWithFormat:@"%d",([self.goPay intValue]+[self.backPay intValue]+airPortName+oil)];
    
//    NSLog(@"%@,%@",self.searchDate.personPrice,self.searchDate.childPrice);
//    NSLog(@"%@",self.searchDate.cabinNumber);
//    NSLog(@"%@,%@",self.searchBackDate.personPrice,self.searchBackDate.childPrice);
//    NSLog(@"%@",self.searchBackDate.cabinNumber);

    //******** headView

    
    
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    self.indexArr = [[NSMutableArray alloc] init];
    
    self.tempView = self.headView;
    self.headViewHegiht = 40;
    
    
    //
    personNumber = 1;  // 默认一个成人
    childNumber = 0;
    
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
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
       return self.headViewHegiht;
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
    else
        return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.flag==1) { // 单程
        
        return 2;
    }
    else if(self.flag == 3)
    { 
        return 3;   // 往返的时候返回3个分区
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
                return 1;
            case 1:
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
    if (self.flag == 1) {  // 单程
        if (indexPath.section == 0) {
            return 90;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            
           firstCellText = [self.firstCelTextArr objectAtIndex:0];
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
            
            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
            
            CGFloat height = MAX(size.height, 44.0f);
           
            return height;
            
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
            return 90;
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
            firstCellText = [self.firstCelTextArr objectAtIndex:0];
            
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
            
            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
            
            CGFloat height = MAX(size.height, 44.0f);
            
            return height;

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
    if (self.flag == 3) {   // 往返
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
            cell.imageView.image = [UIImage imageNamed:@"bg_blue_.png"];
            cell.userInteractionEnabled = NO;
            
            cell.HUButton.text = self.searchDate.temporaryLabel;
            cell.airPortName.text = self.searchDate.airPort;
            cell.startTime.text = self.searchDate.beginTime;
            cell.endTime.text = self.searchDate.endTime;
            cell.startAirPortName.text = self.searchDate.startPortName;
            cell.endAirPortName.text = self.searchDate.endPortName;
            cell.plantType.text = self.goCabin;
            
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
            cell.imageView.image = [UIImage imageNamed:@"bg_green_.png"];
            cell.userInteractionEnabled = NO;
            
            cell.HUButton.text = self.searchBackDate.temporaryLabel;
            cell.airPortName.text = self.searchBackDate.airPort;
            cell.startTime.text = self.searchBackDate.beginTime;
            cell.endTime.text = self.searchBackDate.endTime;
            cell.startAirPortName.text = self.searchBackDate.startPortName;
            cell.endAirPortName.text = self.searchBackDate.endPortName;
            cell.plantType.text = self.backCabin;
            
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
                    {
                        cell.firstLable.text = @"乘机人";
                        
                        firstCellText = [self.firstCelTextArr objectAtIndex:0];
                        
                        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                        
                        CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
                        
                        cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                        
                        cell.secondLable.frame = CGRectMake(135, 0, 196, MAX(size.height, 44.0f));
                        
                        cell.firstLable.frame = CGRectMake(21, 0, 196, MAX(size.height, 44.0f));
                        
                        cell.backView.frame = CGRectMake(0, 0, 320, MAX(size.height, 44.0f));
                        
                        cell.secondLable.text = firstCellText;
                    }
                        
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
                [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];
                cell.personName = [self.cellTitleArr objectAtIndex:1];
                cell.phoneNumber = [self.cellTitleArr objectAtIndex:2];
                cell.nameField.delegate = self;
                cell.phoneField.delegate = self;
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
    else if(self.flag == 1)
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
                
                cell.imageView.image = [UIImage imageNamed:@"bg_blue_.png"];
                cell.userInteractionEnabled = NO;
                
                cell.HUButton.text = self.searchDate.temporaryLabel;
                cell.airPortName.text = self.searchDate.airPort;
                cell.startTime.text = self.searchDate.beginTime;
                cell.endTime.text = self.searchDate.endTime;
                cell.startAirPortName.text = self.searchDate.startPortName;
                cell.endAirPortName.text = self.searchDate.endPortName;
                cell.plantType.text = self.backCabin;
                
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
                            
                            firstCellText = [self.firstCelTextArr objectAtIndex:0];
                            
                            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                            
                            CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];                            
                          
                            cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                             
                            cell.secondLable.frame = CGRectMake(135, 0, 196, MAX(size.height, 44.0f));
                            
                            cell.firstLable.frame = CGRectMake(21, 0, 196, MAX(size.height, 44.0f));
                            
                            cell.backView.frame = CGRectMake(0, 0, 320, MAX(size.height, 44.0f));
                            
                            cell.secondLable.text = firstCellText;
                            
                            
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
                    
                    cell.nameField.delegate = self;
                    cell.phoneField.delegate = self;
                    [cell.addPerson addTarget:self action:@selector(addPersonFormAddressBook) forControlEvents:UIControlEventTouchUpInside];
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
    personNumber = 1;
    childNumber = 0; // 再次进入的时候清空初始人数；
    
    BOOL logFlag = FALSE;  // 此处保留一个flag判断是否用户已经登陆
    if (indexPath.row == 0) {
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
            
            [choose getDate:^(NSMutableDictionary *name, NSMutableDictionary *identity, NSMutableDictionary *type, NSMutableArray * arr)
            {
                
                self.indexArr = arr;   // 把后边添加的标记的联系人传过来
                
                for (int i = 0; i<name.allKeys.count; i++) {
                    
                    NSString * str1 = [name objectForKey:[name.allKeys objectAtIndex:i]];
                    NSString * str2 = [identity objectForKey:[identity.allKeys objectAtIndex:i]];
                    NSString * str3 = [type objectForKey:[type.allKeys objectAtIndex:i]];
                    
                    NSString * string = [NSString stringWithFormat:@"%@%@\n%@",str1,str3,str2];
                   
                    if ([str3 isEqualToString:@"儿童"]) {
                        childNumber = childNumber + 1;
                    }
                    
                   
                   // NSLog(@"%@,%@,%@",str1,str2,str3);
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
                
                self.personMuber.text = [NSString stringWithFormat:@"%d",personNumber];  //  改变成人和儿童的数目
                self.childMunber.text = [NSString stringWithFormat:@"%d",childNumber];

                
                [self.firstCelTextArr replaceObjectAtIndex:0 withObject:stringAfterJoin];
                [self.orderTableView reloadData];
                
            }];
            
            [self.navigationController pushViewController:choose animated:YES];
        }
    }

    if (indexPath.row == 2) {

        BuyInsuranceViewController * insurance = [[BuyInsuranceViewController alloc] init];
        [insurance getDate:^(NSString *idntity) {
   
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            cell.secondLable.text = idntity;
           // NSLog(@"post %@",schedule);
        }];
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];

    }
    if (indexPath.row == 3) {
        
        TraveController * trave = [[TraveController alloc] init];
        [trave getDate:^(NSString *schedule, NSString *postPay) {
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            cell.secondLable.text = schedule;
          
        }];
        
        [self.navigationController pushViewController:trave animated:YES];
        [trave release];
        
    }
}
- (IBAction)payMoney:(id)sender {
    
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
    
    self.PerStanderPrice.text =[NSString stringWithFormat:@"%d",[self.goPay intValue] + [self.backPay intValue]] ;  // 票面价
    
   // self.PerStanderPrice.text = self.searchDate.standerPrice;
    self.personAdultBaf.text = self.searchDate.adultBaf;
    self.PersonConstructionFee.text = self.searchDate.constructionFee;
    self.Personinsure.text = @"0";
    self.personMuber.text = [NSString stringWithFormat:@"%d",personNumber];
    
    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",([self.searchDate.adultBaf intValue]+goPay+backPay+[self.searchDate.constructionFee intValue])];  //  暂时还没有把保险加入总额；
    self.allPay.text = [NSString stringWithFormat:@"%d",([self.searchDate.adultBaf intValue]+goPay+backPay+[self.searchDate.constructionFee intValue])];  //  暂时还没有把保险加入总额；
    
    self.childStanderPrice.text = [NSString stringWithFormat:@"%d",[self.childBackPay intValue]+[self.childGopay intValue]];
    self.childBaf.text = self.searchDate.childBaf;
    self.childConstructionFee.text = self.searchDate.childConstructionFee;
    self.childInsure.text = @"0";
    self.childMunber.text = [NSString stringWithFormat:@"%d",childNumber];
    
    if (childNumber == 0) {  // 次数添加如果没有儿童的时候的headView
        
    }

    //********* 计算订单总额......
   
    int personMoney = [self.backPay intValue]+[self.goPay intValue];   // 单程是时候最后赋值的是self.backPay
    int airPortName = [self.searchDate.constructionFee intValue];
    int oil = [self.searchDate.adultBaf intValue];
    int allInsure = 0;  // 所有人要买就都买一份保险
    
    int childPersonMoney = [self.childBackPay intValue] + [self.childGopay intValue];
    int childAirPortName = [self.searchDate.childConstructionFee intValue];
    int childOil = [self.searchDate.childBaf intValue];
    
   // NSLog(@"%d,%d,%d",childPersonMoney,childAirPortName,childOil);
   // int allInsure = 0;

    int newPersonAllPay = (personMoney+airPortName+oil+allInsure)*personNumber;
    int newChildAllPay = (childPersonMoney+childAirPortName+childOil)*childNumber;
    
    finalPay = newPersonAllPay + newChildAllPay;
    NSLog(@"%d,%d",newPersonAllPay,newChildAllPay);
    
    self.bigUpPayMoney.text = [NSString stringWithFormat:@"%d",newPersonAllPay+newChildAllPay];  // 暂时的 此处还没有添加保险金额
    self.allPay.text = [NSString stringWithFormat:@"%d",newPersonAllPay+newChildAllPay];
    
    self.headViewHegiht = 97.0f;
    [self.orderTableView reloadData];
}

- (IBAction)changeToSmallHeadView:(id)sender {
    self.tempView = self.headView;
    self.headViewHegiht = 40.0f;
    
    self.upPayMoney.text = [NSString stringWithFormat:@"%d",finalPay];
    self.allPay.text = [NSString stringWithFormat:@"%d",finalPay];
    
//    self.upPayMoney.text = [NSString stringWithFormat:@"%d",([self.searchDate.adultBaf intValue]+goPay+backPay+[self.searchDate.constructionFee intValue])];  //  暂时还没有把保险加入总额；
//    self.allPay.text = [NSString stringWithFormat:@"%d",([self.searchDate.adultBaf intValue]+goPay+backPay+[self.searchDate.constructionFee intValue])];  //  暂时还没有把保险加入总额；
    
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
@end
