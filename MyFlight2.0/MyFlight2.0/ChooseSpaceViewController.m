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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受舱位数据" object:nil];
    [self.searchCab searchCabin];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    [HUD show:YES];


    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    
    if (self.searchBackFlight != nil) {
        data = self.searchBackFlight;
    }
    else{
        data = self.searchFlight;
    }
    self.flightCode.text =data.temporaryLabel;
//    self.airPort.text = data.airPort;
//    self.palntType.text = data.palntType;
//    self.beginTime.text = data.beginTime;
//    self.endTime.text = data.endTime;
//
//    self.beginAirPortName.text = data.startPortName;
//    self.endAirPortName.text = data.endPortName;
    
    self.changeInfoArr = [NSMutableArray array];
    self.indexPath = [NSMutableArray array];
    data.cabinNumberArr = [NSMutableArray array];
    self.payArr = [NSMutableArray array];
    self.childPayArr = [NSMutableArray arrayWithCapacity:5];
    self.indexArr = [NSMutableArray array];
    //    for (int i = 0; i<data.cabinsArr.count; i++) {
//        NSDictionary * dictionary = [data.cabinsArr objectAtIndex:i];
//        NSString * string = [dictionary objectForKey:@"changeInfo"];
//        NSString * string1 = [dictionary objectForKey:@"cabinCode"]; // 舱位编码
//        NSString * string2 = [dictionary objectForKey:@"cabinCN"];
//        NSString * str = [NSString stringWithFormat:@"%@ %@",string2,string1];
//        [data.cabinNumberArr addObject:str];
//        [self.changeInfoArr addObject:string];
//    }

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
 
    [self.showTableView reloadData];

    [HUD removeFromSuperview];
	[HUD release];
	HUD = nil;

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
    [super viewDidUnload];
}

//#pragma mark - Table view data source
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 103;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return self.headView;
//}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.searchBackFlight != nil) {
//        return self.searchBackFlight.cabinsArr.count;
//    }
//    else{
//        return self.searchFlight.cabinsArr.count;
//    }
    
    return self.dateArr.count+1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    else
    {
//        if (flag == 10) {
//            NSLog(@"%s,%d",__FUNCTION__,__LINE__);
//            NSString * string = [self.changeInfoArr objectAtIndex:indexPath.row-1];
//            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:12]
//                             constrainedToSize:CGSizeMake(280, [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding])];
//            flag = 0;
//            return 44+size.height;
//        }
//       else
//       {
//           return 44;
//       }
        
        _firstCellText = [self.tempArr objectAtIndex:indexPath.row-1];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
        
        CGSize size = [_firstCellText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
        
        //   CGFloat height = MAX(size.height, 44.0f);
        //   NSLog(@"%f",size.height);
        return size.height+50.0f;

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
        
        
        cell.airPort.text = data.airPort;
        cell.palntType.text = data.palntType;
        cell.beginTime.text = data.beginTime;
        cell.endTime.text = data.endTime;
        cell.beginAirPortName.text = data.startPortName;
        cell.endAirPortName.text = data.endPortName;
        cell.scheduleDate.text = @"";  // 判断是不是第二天

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
            
            self.searchFlight.pay = [self.payArr objectAtIndex:indexPath.row-1]; // 保存成人去程金额
            
            ShowSelectedResultViewController * show = [self.navigationController.viewControllers objectAtIndex:2];
            
            show.payMoney = [self.payArr objectAtIndex:indexPath.row-1];
            show.childPayMoney = [self.childPayArr objectAtIndex:indexPath.row-1];   // 传递儿童的价格
          //  NSLog(@"show.payMoney  %@, childPayMoney  %@",show.payMoney,show.childPayMoney);
            show.airPort = searchAirPort;
            show.cabin = [data.cabinNumberArr objectAtIndex:indexPath.row-1];
            
            
            show.netFlag = 1;  // 等与1  ，在返回到返程列表的时候 不需要联网
            show.write = self;
            [self.navigationController popToViewController:show animated:YES];
            
        }
        
        else
        {
            WriteOrderViewController * insurance = [[WriteOrderViewController alloc] init];
            insurance.flag = self.flag;
            
            insurance.searchDate = self.searchFlight;
            
//            NSLog(@"---%@,%@",self.searchFlight.personPrice,self.searchFlight.childPrice);
//            NSLog(@"---%@,%@",self.searchBackFlight.personPrice,self.searchBackFlight.childPrice);
            insurance.searchBackDate = self.searchBackFlight;
            
            insurance.searchDate.cabinNumber =  [insurance.searchDate.cabinNumberArr objectAtIndex:indexPath.row-1];
            
            insurance.searchBackDate.cabinNumber = [insurance.searchBackDate.cabinNumberArr objectAtIndex:indexPath.row-1];
            
            insurance.searchDate.pay = [[self.searchFlight.cabinsArr objectAtIndex:indexPath.row-1]objectForKey:@"price"];
            
            insurance.searchBackDate.pay = [[self.searchBackFlight.cabinsArr objectAtIndex:indexPath.row-1] objectForKey:@"price"];
            
//            NSLog(@"%@,%@",insurance.searchDate.pay,insurance.searchBackDate.pay);
//            
//            
//           NSLog(@"%@,%@",self.goPay,self.goCabin);
            
            NSString * str = [self.payArr objectAtIndex:indexPath.row-1];
            NSString * str2 = [self.childPayArr objectAtIndex:indexPath.row-1];
            NSString * str1 = [data.cabinNumberArr objectAtIndex:indexPath.row-1];
//            NSLog(@"%@,%@",str,str1);
            
            insurance.goCabin = self.goCabin;
            insurance.backCabin = str1;
            
            insurance.goPay = self.goPay;
            insurance.backPay = str;
            insurance.childGopay = self.childGoPay;
            insurance.childBackPay = str2;
            
            NSLog(@"%@,%@",insurance.goPay,str);
            NSLog(@"%@,%@",self.childGoPay,str2);  // 此处都儿童成人价格都正确
            
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
