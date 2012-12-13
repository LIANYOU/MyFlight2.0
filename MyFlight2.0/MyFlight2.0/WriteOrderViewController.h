//
//  WriteOrderViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "WriteOrderCell.h"
#import "WriteOrderDetailsCell.h"
#import "WirterOrderTwoLineCell.h"
#import "WriterOrderCommonCell.h"
#import "SearchFlightData.h"
@interface WriteOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *orderMoney;
    NSString * stringAfterJoin ;  // 拼接好的string
    
    NSString * firstCellText;
}
@property (retain, nonatomic) IBOutlet UIView *headView;
@property (retain, nonatomic) NSArray * cellTitleArr;
@property (retain, nonatomic) IBOutlet UITableView *orderTableView;
@property (retain, nonatomic) IBOutlet WriteOrderCell *writeOrderCell;
@property (retain, nonatomic) IBOutlet WriteOrderDetailsCell *writeOrderDetailsCell;
@property (retain, nonatomic) IBOutlet WriterOrderCommonCell *writerOrderCommonCell;
@property (retain, nonatomic) IBOutlet WirterOrderTwoLineCell *wirterOrderTwoLineCell;
@property (retain, nonatomic) IBOutlet UIScrollView *orderScrollView;
@property (retain, nonatomic) IBOutlet UILabel *allPay;   // 底部的显示还有多少钱的按钮

@property (retain, nonatomic) NSMutableArray * stringArr;  // 存放添加联系人返回回来的字符串

@property (retain, nonatomic) SearchFlightData * searchDate;
@property (retain, nonatomic) SearchFlightData * searchBackDate;

@property (assign, nonatomic) int flag;
@property (retain, nonatomic) NSMutableArray * firstCelTextArr;

///  cell属性的定义
@property (retain, nonatomic) IBOutlet UILabel *upPayMoney;

- (IBAction)payMoney:(id)sender;  // 去支付订单

@end
