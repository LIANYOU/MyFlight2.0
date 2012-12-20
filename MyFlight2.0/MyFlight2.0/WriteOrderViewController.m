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
    
    int goPay = [self.goPay intValue];
    int backPay = [self.backPay intValue];
    
    self.upPayMoney.text = [NSString stringWithFormat:@"%d",(goPay+backPay)];  // 暂时的 此处还没有添加保险金额
    self.allPay.text = [NSString stringWithFormat:@"%d",(goPay+backPay)];
    
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
                        cell.firstLable.text = [self.cellTitleArr objectAtIndex:0];
                        
                        firstCellText = [self.firstCelTextArr objectAtIndex:0];
                                               
                        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
                        
                        CGSize size = [firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
                        
                        cell.secondLable.lineBreakMode = UILineBreakModeCharacterWrap;
                        cell.secondLable.frame = CGRectMake(118, 11, 196, MAX(size.height, 44.0f));
                        
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
                            NSLog(@"%@",firstCellText);
                            
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
                   
                    [self.stringArr addObject:string];
                }
                
                
                for (int i = 0; i<self.stringArr.count; i++) {
                    
                    if ([stringAfterJoin isEqualToString:@""]) {
                        stringAfterJoin = [NSString stringWithFormat:@"%@",[self.stringArr objectAtIndex:i]];
                    }
                    else{
                        stringAfterJoin = [NSString stringWithFormat:@"%@\n%@",stringAfterJoin,[self.stringArr objectAtIndex:i]];
                    }
                    
                }
                            
                [self.firstCelTextArr replaceObjectAtIndex:0 withObject:stringAfterJoin];
                [self.orderTableView reloadData];
                
            }];
            
            [self.navigationController pushViewController:choose animated:YES];
        }
    }

    if (indexPath.row == 2) {
        TraveController * trave = [[TraveController alloc] init];
        [trave getDate:^(NSString *schedule, NSString *postPay) {
            WriterOrderCommonCell * cell = (WriterOrderCommonCell *)[self.orderTableView cellForRowAtIndexPath:indexPath];
            cell.secondLable.text = schedule;
            NSLog(@"post %@",schedule);
        }];
        
        [self.navigationController pushViewController:trave animated:YES];
        [trave release];
    }
    if (indexPath.row == 3) {
        
        BuyInsuranceViewController * insurance = [[BuyInsuranceViewController alloc] init];
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];
        
       
    }
}
- (IBAction)payMoney:(id)sender {
    
}


-(void)addPersonFormAddressBook
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
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
    [self.orderTableView reloadData];
}
@end
