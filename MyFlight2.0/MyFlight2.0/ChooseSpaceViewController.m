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
#import "BigCell.h"
#import "NewChooseSpaceCell.h"
#import "AttentionFlight.h"
#import "AppConfigure.h"
#import "GetAttentionFlight.h"
#import "UIButton+BackButton.h"
#import "ColorUility.h"
#import "UseGoldPay.h"
#define FONT_SIZE 8.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 105.0f

@interface ChooseSpaceViewController ()
{
    int flag ;
    NSString * nextDayStr;
}

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
    self.navigationItem.title = @"选择舱位";
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    
   

    self.showTableView.tableFooterView = self.footView;
    
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    if (self.searchBackFlight != nil) {
        
        data = self.searchBackFlight;
    }
    else{
        data = self.searchFlight;
    }
    self.flightCode.text =data.temporaryLabel;
    
    
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"AirPortCode" ofType:@"plist"];
    
    NSDictionary * dicCode = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    
    
    for (int i = 0; i<dicCode.allKeys.count; i++) {
        
        if ([data.airPort isEqualToString:[dicCode.allKeys objectAtIndex:i]]) {
            
            self.airCodeName = [dicCode objectForKey:[dicCode.allKeys objectAtIndex:i]];
            
            break;
        }
        else
        {
            self.airCodeName = data.airPort;
        }
    }

    
  
    if (self.flag == 1) {
        self.goORBackLabel.text = @"单程";
    }
    if (self.flag == 2) {
        self.goORBackLabel.text = @"去程";
    }
    else if(self.flag == 3){
        self.goORBackLabel.text = @"返程";
    }
   
    
    NSString * date = nil;
    if ([data.goOrBackFlag isEqualToString:@"1"]) {
        date = data.beginDate;
    }
    else{
        date = data.backDate;
    } 
    
    nextDayStr =  [TransitionString getNextDay:date];
    
    
    self.nextArr = [nextDayStr componentsSeparatedByString:@"-"];
    self.dateSparetArr = [data.endTime componentsSeparatedByString:@":"];

    
    if ([[self.dateSparetArr objectAtIndex:0] intValue]<3) {  // 判断是不是第二天
        nextDayStr = [NSString stringWithFormat:@"%@日",[self.nextArr objectAtIndex:2]];
    }
    
    self.changeInfoArr = [NSMutableArray array];
    self.indexPath = [NSMutableArray array];
    data.cabinNumberArr = [NSMutableArray array];
    self.payArr = [NSMutableArray array];
    self.childPayArr = [NSMutableArray arrayWithCapacity:5];
    self.indexArr = [NSMutableArray array];
    
    // 调去查看舱位数据信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受舱位数据" object:nil];
    [self.searchCab searchCabin];
   
    
    // 调取应经关注的航班的信息
    NSString * memberID = Default_UserMemberId_Value;
    NSString * hwID = HWID_VALUE;
    
    GetAttentionFlight * flight = [[GetAttentionFlight alloc] initWithMemberId:memberID
                                                                  andOrgSource:@"51YOU"
                                                                       andType:@"P"
                                                                      andToken:hwID
                                                                     andSource:@"1"
                                                                       andHwid:hwID andServiceCode:@"01"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lookReceive:) name:@"获得已经关注航班信息" object:nil];
    [flight getAttentionFlight];

    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    [HUD show:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)lookReceive:(NSNotification *)not
{
    self.lookReceive = [NSArray array];
    self.lookReceive = [[not userInfo] objectForKey:@"arr"];
    for (NSDictionary * dic_ in self.lookReceive) {
         NSLog(@"已经关注的航班号 %@",[dic_ objectForKey:@"flightNum"]);
        if ([data.temporaryLabel isEqualToString:[dic_ objectForKey:@"flightNum"]]) {
            [self.lookFlightBtn setTitle:@"    取消关注" forState:0];
            [self.lookFlightBtn setBackgroundImage:[UIImage imageNamed:@"btn_cancel.png"] forState:0];
           
        }
    }
}
-(void)receive:(NSNotification *)not
{
    self.dateArr  = [[NSMutableArray alloc] initWithArray:[[not userInfo] objectForKey:@"arr"]];

   
//    [self.dateArr addObject:@""];


    self.tempArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.dateArr.count; i++) {
        [self.tempArr addObject:@""];
    }
    
   
    
    for (int i = 0; i<self.dateArr.count; i++) {
        NSDictionary * dictionary = [self.dateArr objectAtIndex:i];
        NSString * string = [dictionary objectForKey:@"changeInfo"];
        NSString * string1 = [dictionary objectForKey:@"cabinCode"]; // 舱位编码
        NSString * string2 = [dictionary objectForKey:@"cabinCN"];
        NSString * string3 = [dictionary objectForKey:@"price"];    //
        NSString * string4 = [dictionary objectForKey:@"childPrice"];
        NSString * str = [NSString stringWithFormat:@"%@ %@",string2,string1];
        [data.cabinNumberArr addObject:str];
        [self.payArr addObject:string3];
        [self.childPayArr addObject:string4];
        [self.changeInfoArr addObject:string];
     
    }
    
    [self.showTableView reloadData];

    [HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

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
    [_beginAirPortName release];
    [_endAirPortName release];
    [_headView release];
    [_bigCell release];
    [_newCell release];
    [_lookFlightBtn release];
    [_lookButton release];
    [_goORBackLabel release];
    [_footView release];
    [_cellSelectedView release];
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
    [self setBeginAirPortName:nil];
    [self setEndAirPortName:nil];
    [self setHeadView:nil];
    [self setBigCell:nil];
    [self setNewCell:nil];
    [self setLookFlightBtn:nil];
    [self setLookButton:nil];
    [self setGoORBackLabel:nil];
    [self setFootView:nil];
    [self setCellSelectedView:nil];
    [super viewDidUnload];
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dateArr.count+1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    else
    {
        
        _firstCellText = [self.tempArr objectAtIndex:indexPath.row-1];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
        
        CGSize size = [_firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
        
        if ( _firstCellText != @"" &&  size.height < 20) {
            size.height = 25;
        }
    
        return size.height+60.0f;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"Cell1";
        BigCell *cell = (BigCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"BigCell" owner:self options:nil];
            cell = self.bigCell;
        }
        
        if ([data.goOrBackFlag isEqualToString:@"1"]) {
            cell.scheduleDate.text = [NSString stringWithFormat:@"%@ %@",data.beginDate,data.beginStartWeek];
        }
        else{
            cell.scheduleDate.text = [NSString stringWithFormat:@"%@ %@",data.beginDate,data.backStartWeek];
        }
        cell.airPort.text = self.airCodeName;
        cell.palntType.text = [NSString stringWithFormat:@"%@机型",data.palntType];
        cell.beginTime.text = data.beginTime;
        cell.endTime.text = data.endTime;
        cell.beginAirPortName.text = data.startPortName;
        cell.endAirPortName.text = data.endPortName;
        
        if ([[self.dateSparetArr objectAtIndex:0] intValue]<3) {  // 判断是不是第二天
            
            cell.nextDayLabel.text = [NSString stringWithFormat:@"(明天)"];
        }
        else{
        
            cell.endAirPortName.frame = CGRectMake(239, 62, 70, 21);
            cell.endTime.frame = CGRectMake(243, 39, 66, 27);
            cell.planeImage.frame = CGRectMake(106+15, 48, 75, 20);
            cell.nextDayLabel.text = @"";  // 判断是不是第二天
        }
        
        
        
        cell.userInteractionEnabled = NO;

        return cell;

    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        NewChooseSpaceCell *cell = (NewChooseSpaceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"NewChooseSpaceCell" owner:self options:nil];
            cell = self.newCell;
        }

        
        
        
        
        dic = [self.dateArr objectAtIndex:indexPath.row-1];
        
        cell.SpaceName.text = [dic objectForKey:@"cabinCN"];
        cell.payMoney.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
        cell.ticketCount.text = [TransitionString transitionSeatNum: [dic objectForKey:@"seatNum"] ];
        
        if ([cell.ticketCount.text isEqualToString:@"已售空"]) {
            cell.ticketCount.textColor = [UIColor redColor];
            cell.sortImage.hidden = YES;
        }
        
        
        cell.discount.text = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"cabinCode"] andCabinName:[dic objectForKey:@"cabinCN"]];
        
        
        
        cell.changeSpace.tag = indexPath.row;
        
        
        _firstCellText = [self.tempArr objectAtIndex:indexPath.row-1];
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
        
        CGSize size = [_firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
        
        if ( _firstCellText != @"" &&  size.height < 20) {
            size.height = 25;
        }
        
        cell.view.frame = CGRectMake(0, 0, 320, size.height+60.0f);
        cell.textCell.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.textView.frame = CGRectMake(0, 60, 320, size.height);
        cell.textCell.frame = CGRectMake(10,0, 300, size.height);
        cell.selectBtn.frame = CGRectMake(10,0, 300, size.height);
        
        cell.textView.backgroundColor = [UIColor colorWithRed:237/255.0 green:232/255.0 blue:226/255.0 alpha:1];
        cell.textCell.font = [UIFont systemFontOfSize:12.0f];
        cell.textCell.text = _firstCellText;
        UIColor * myColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        cell.textCell.textColor = myColor;
        cell.wImage.frame = CGRectMake(0, size.height+60.0f, 320, 1);
        cell.dImage.frame = CGRectMake(0, size.height+61.0f, 320, 1);
        
        
        [cell.selectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = 2;
        
        
        [cell.changeSpace addTarget:self action:@selector(changeFlightInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.selectedBackgroundView = self.cellSelectedView;
        cell.SpaceName.highlightedTextColor = View_BackGrayTitleOne_Color;
        cell.payMoney.highlightedTextColor = FONT_Orange_Color;
        cell.ticketCount.highlightedTextColor = View_BackGrayTitleTwo_Color;
        cell.discount.highlightedTextColor = FONT_Orange_Color;
        cell.textCell.highlightedTextColor = View_BackGrayTitleTwo_Color;
        cell.selectBtn.highlighted = NO;
        
        
        return cell;
        
        
    }
}


#pragma mark - Table view delegatesearchFlight
-(void)select:(UIButton *)btn
{
    NSLog(@"999");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.showTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NewChooseSpaceCell *cell = (NewChooseSpaceCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell.ticketCount.text isEqual:@"已售空"]) {

            if (self.flag == 2) {
                
                SearchAirPort * searchAirPort = [[SearchAirPort alloc] initWithdpt:self.searchFlight.endPortThreeCode arr:self.searchFlight.startPortThreeCode date:self.goBackDate ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
                
                self.searchFlight.pay = [[self.payArr objectAtIndex:indexPath.row-1] intValue]; // 保存成人去程金额
                
                self.searchFlight.ticketCount = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"seatNum"];
                if ([self.searchFlight.ticketCount isEqualToString:@"A"]) {
                    self.searchFlight.ticketCount = @"10";
                }
                self.searchFlight.childPrice = [self.childPayArr objectAtIndex:indexPath.row-1];
                self.searchFlight.cabinNumber = [data.cabinNumberArr objectAtIndex:indexPath.row-1];
                self.searchFlight.cabinCode = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"cabinCode"];
                self.searchFlight.cabinInfo = [self.changeInfoArr objectAtIndex:indexPath.row-1];
                self.searchFlight.goAirportName = self.airCodeName;
                
                
                ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
                show.airPort = searchAirPort;
                
                show.netFlag = 1;  // 等与1  ，在返回到返程列表的时候 不需要联网
                show.write = self;
                
                CATransition *animation = [CATransition animation];
                animation.duration = 0.3f;
                animation.type = kCATransitionMoveIn;
                animation.subtype = kCATransitionFromRight;
                [self.navigationController popToViewController:show animated:NO];
                [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
                [show.navigationController.view.layer addAnimation:animation forKey:@"animation"];
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }
            
            else
            {
                
                
                if (self.flag == 1) {
                    
                    self.searchFlight.pay = [[self.payArr objectAtIndex:indexPath.row-1] intValue];
                    self.searchFlight.ticketCount = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"seatNum"];
                    if ([self.searchFlight.ticketCount isEqualToString:@"A"]) {
                        self.searchFlight.ticketCount = @"10";
                    }
                    self.searchFlight.childPrice = [self.childPayArr objectAtIndex:indexPath.row-1];
                    self.searchFlight.cabinNumber = [data.cabinNumberArr objectAtIndex:indexPath.row-1];
                    self.searchFlight.cabinCode = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"cabinCode"];
                    self.searchFlight.cabinInfo = [self.changeInfoArr objectAtIndex:indexPath.row-1];
                    self.searchFlight.goAirportName = self.airCodeName;
                }
                else{
                    
                    self.searchBackFlight.pay = [[self.payArr objectAtIndex:indexPath.row-1] intValue];
                    self.searchBackFlight.ticketCount = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"seatNum"];
                    if ([self.searchBackFlight.ticketCount isEqualToString:@"A"]) {
                        self.searchBackFlight.ticketCount = @"10";
                    }
                    self.searchBackFlight.childPrice = [self.childPayArr objectAtIndex:indexPath.row-1];
                    self.searchBackFlight.cabinNumber = [data.cabinNumberArr objectAtIndex:indexPath.row-1];
                    self.searchBackFlight.cabinCode = [[self.dateArr objectAtIndex:indexPath.row-1] objectForKey:@"cabinCode"];
                    self.searchBackFlight.cabinInfo = [self.changeInfoArr objectAtIndex:indexPath.row-1];
                    self.searchBackFlight.backAirportName = self.airCodeName;
                    
                }
                
                
                UseGoldPay * gold = nil;
                
                if (Default_IsUserLogin_Value) {
                    NSString * sign = [NSString stringWithFormat:@"%@%@%@",Default_UserMemberId_Value,@"xx",Default_Token_Value];
                    NSString *signReal =GET_SIGN(sign);
                    
                    
                    gold = [[UseGoldPay alloc] initWithIsOpenAccount:@"true"
                                                                      andMemberId:Default_UserMemberId_Value
                                                                          andSign:signReal
                                                                    andOrderPrice:[NSString stringWithFormat:@"%d",self.searchFlight.pay + self.searchBackFlight.pay]
                                                                    andTotalPrice:[NSString stringWithFormat:@"%d",self.searchFlight.pay + self.searchBackFlight.pay]
                                                                      andProdType:@"01"
                                                                        andSource:SOURCE_VALUE
                                                                    andAirCompany:nil
                                                                           andDpt:nil
                                                                           andArr:nil
                                                                       andDisount:nil
                                                                  andInsuranceNum:nil
                                                           andInsuranceTotalPrice:nil
                                                                          andHwld:HWID_VALUE];
                }
               

                
                
                
                
                WriteOrderViewController * insurance = [[WriteOrderViewController alloc] init];
                insurance.flag = self.flag;
                
                insurance.useGoldPay = gold;
                
                insurance.searchDate = self.searchFlight;
                
                insurance.searchBackDate = self.searchBackFlight;
                
                [self.navigationController pushViewController:insurance animated:YES];
                [insurance release];
            }
            
        }

//    }
    
    
}
- (void)changeFlightInfo:(UIButton *)send {

    NewChooseSpaceCell *cell = (NewChooseSpaceCell *)[self.showTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:send.tag inSection:0]];
    
    if (self.indexArr.count == 0) {
         cell.sortimage.image = [UIImage imageNamed:@"blue_icon_up.png"];
        [self.indexArr addObject:[NSString stringWithFormat:@"%d",send.tag]];
    }
    else{
        for (NSString * str in self.indexArr) {
         
            if ([str intValue] == send.tag) {
                
                cell.sortimage.image = [UIImage imageNamed:@"blue_icon_down.png"];
                
                [self.tempArr replaceObjectAtIndex:send.tag-1 withObject:@""];
                
                [self.showTableView reloadData];
                [self.indexArr removeAllObjects];
                return;
            }
            else{
                cell.sortimage.image = [UIImage imageNamed:@"blue_icon_up.png"];
                
                for (NSString * string in self.indexArr) {
                    NewChooseSpaceCell *cell1 = (NewChooseSpaceCell *)[self.showTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[string intValue] inSection:0]];
                    cell1.sortimage.image = [UIImage imageNamed:@"blue_icon_down.png"];
                    
                }
                
                
                [self.indexArr removeAllObjects];
                [self.indexArr addObject:[NSString stringWithFormat:@"%d",send.tag]];
            }
        }
    }
    
    
    
    self.tempArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.dateArr.count; i++) {
        
        [self.tempArr addObject:@""];
    }
    [self.tempArr replaceObjectAtIndex:send.tag-1 withObject:[self.changeInfoArr objectAtIndex:send.tag-1]];
    
    [self.showTableView reloadData];

}

- (IBAction)lookFlight:(UIButton *)sender {
    
    // 只发push....
    
    if (self.lookReceive.count >=5) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您关注的航班已经达到5条,不能继续添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSString * type = nil;
    
    if ([sender.titleLabel.text isEqualToString:@"    关注航班"]) {

        type = @"P";
    }
    else{

        type = @"C";
    }
    
    self.lookFlightArr = [NSDictionary dictionary];
    
    NSString * memberId = Default_UserMemberId_Value;
    NSString * hwId = HWID_VALUE;
    
    NSLog(@"关注航班的条件 : %@, %@ , %@, %@ ,%@ ,%@, %@",data.temporaryLabel,data.beginDate,data.startPortThreeCode,data.endPortThreeCode,data.beginTime,data.endTime,type
          );
    
    AttentionFlight * attention = [[AttentionFlight alloc] initWithMemberId:memberId
                                                               andorgSource:@"51YOU"
                                                                     andFno:data.temporaryLabel
                                                                   andFdate:data.beginDate
                                                                     andDpt:data.startPortThreeCode
                                                                     andArr:data.endPortThreeCode
                                                                 andDptTime:data.beginTime
                                                                 andArrTime:data.endTime
                                                                 andDptName:nil
                                                                 andArrName:nil
                                                                    andType:type
                                                                  andSendTo:nil
                                                                 andMessage:nil
                                                                   andToken:hwId
                                                                  andSource:@"1"
                                                                    andHwId:hwId
                                                             andServiceCode:@"01"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLookFlightData:) name:@"关注航班" object:nil];
    [attention lookFlightAttention];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    [HUD show:YES];

}

-(void)receiveLookFlightData:(NSNotification *) not
{
    
    self.lookFlightArr = [[not userInfo] objectForKey:@"arr"];
    NSString * string = [self.lookFlightArr objectForKey:@"message"];

    if (string == @"") {
        if ([self.lookFlightBtn.titleLabel.text isEqualToString:@"    关注航班"]) {
  
            [self.lookFlightBtn setTitle:@"    取消关注" forState:0];
       
            [self.lookFlightBtn setBackgroundImage:[UIImage imageNamed:@"btn_cancel.png"] forState:0];
        }
        else{

            [self.lookFlightBtn setTitle:@"    关注航班" forState:0];
      
            [self.lookFlightBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention.png"] forState:0];
        }

    }
    
    else{
        NSLog(@"取消或者关注航班失败");
    }
    
     [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
    
    
    [HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1 ) {

        SearchAirPort * searchAirPort = [[SearchAirPort alloc] initWithdpt:self.searchFlight.endPortThreeCode arr:self.searchFlight.startPortThreeCode date:@"2012-12-20" ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        
        ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
        show.airPort = searchAirPort;
        show.netFlag = 1;  // 等与1  ，在返回到返程列表的时候 不需要联网
        show.write = self;
        [self.navigationController popToViewController:show animated:YES];
        
    }
    else if (buttonIndex ==0)
    {
        NSLog(@"停留在次界面");
    }
}

-(void)back
{
//    ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
//    show.netFlag = 1;  // 返回时候不需要联网
    [self.navigationController popViewControllerAnimated:YES];

}
@end
