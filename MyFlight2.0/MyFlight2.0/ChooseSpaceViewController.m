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
#define FONT_SIZE 8.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 100.0f

@interface ChooseSpaceViewController ()
{
    int flag ;
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
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];




    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    if (self.searchBackFlight != nil) {
        
        data = self.searchBackFlight;
    }
    else{
        data = self.searchFlight;
    }
    self.flightCode.text =data.temporaryLabel;
    
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
            [self.lookFlightBtn setTitle:@"     取消关注" forState:0];
           
        }
    }
}
-(void)receive:(NSNotification *)not
{
    self.dateArr  = [[NSMutableArray alloc] init];
    self.dateArr = [[not userInfo] objectForKey:@"arr"];
 
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
 
 //    NSLog(@"*****************%d,%d,%d",self.dateArr.count,self.payArr.count,self.childPayArr.count);
    
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
        return size.height+51.0f;

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
        
        NSLog(@"选择舱位bigCell的信息 %@%@%@%@%@%@%@",data.airPort,data.palntType,data.beginTime,data.endTime,data.beginDate,data.startPortThreeCode,data.endPortThreeCode);
        if ([data.goOrBackFlag isEqualToString:@"1"]) {
            cell.scheduleDate.text = data.beginDate;
        }
        else{
            cell.scheduleDate.text = data.backDate;
        }
        cell.airPort.text = data.airPort;
        cell.palntType.text = [NSString stringWithFormat:@"%@机型",data.palntType];
        cell.beginTime.text = data.beginTime;
        cell.endTime.text = data.endTime;
        cell.beginAirPortName.text = data.startPortName;
        cell.endAirPortName.text = data.endPortName;
        cell.nextDayLabel.text = @"";  // 判断是不是第二天

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
        cell.payMoney.text = [dic objectForKey:@"price"];
        cell.ticketCount.text = [TransitionString transitionSeatNum: [dic objectForKey:@"seatNum"] ];
        cell.discount.text = [dic objectForKey:@"discount"];
        cell.discount.text = [TransitionString transitionDiscount:[dic objectForKey:@"discount"] andCanbinCode:[dic objectForKey:@"cabinCode"]];
        
        cell.changeSpace.tag = indexPath.row;
        
        
        _firstCellText = [self.tempArr objectAtIndex:indexPath.row-1];
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
        
        CGSize size = [_firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
        
        cell.view.frame = CGRectMake(0, 0, 320, size.height+50.0f);
        cell.textCell.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.textCell.frame = CGRectMake(10, 50, 290, size.height);
        cell.textCell.font = [UIFont systemFontOfSize:12.0f];
        cell.textCell.text = _firstCellText;
        cell.wImage.frame = CGRectMake(0, size.height+50.0f, 320, 1);
        cell.dImage.frame = CGRectMake(0, size.height+51.0f, 320, 1);
    
        
        [cell.changeSpace addTarget:self action:@selector(changeFlightInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }
 }


#pragma mark - Table view delegatesearchFlight

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
    else{
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
     
            
            ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];

            show.airPort = searchAirPort;            
            
            show.netFlag = 1;  // 等与1  ，在返回到返程列表的时候 不需要联网
            show.write = self;
            [self.navigationController popToViewController:show animated:YES];
            
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

            }
            
            WriteOrderViewController * insurance = [[WriteOrderViewController alloc] init];
            insurance.flag = self.flag;

            insurance.searchDate = self.searchFlight;
            
            insurance.searchBackDate = self.searchBackFlight;
            
            [self.navigationController pushViewController:insurance animated:YES];
            [insurance release];
        }

    }
        
}
- (void)changeFlightInfo:(UIButton *)send {

    if (self.indexArr.count == 0) {
        [self.indexArr addObject:[NSString stringWithFormat:@"%d",send.tag]];
    }
    else{
        for (NSString * str in self.indexArr) {
         
            if ([str intValue] == send.tag) {
                [self.tempArr replaceObjectAtIndex:send.tag-1 withObject:@""];
                
                [self.showTableView reloadData];
                [self.indexArr removeAllObjects];
                return;
            }
            else{
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
    
    if ([sender.titleLabel.text isEqualToString:@"     关注航班"]) {

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
    
    NSLog(@"%@",self.lookFlightArr);
    
    if (string == @"") {
        if ([self.lookFlightBtn.titleLabel.text isEqualToString:@"     关注航班"]) {
  
            [self.lookFlightBtn setTitle:@"     取消关注" forState:0];
        }
        else{

            [self.lookFlightBtn setTitle:@"     关注航班" forState:0];
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
    //ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
    //show.netFlag = 1;  // 返回时候不需要联网
    [self.navigationController popViewControllerAnimated:YES];

}
@end
