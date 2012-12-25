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

#import <AddressBookUI/AddressBookUI.h>


@interface WriteOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ABPersonViewControllerDelegate,ABNewPersonViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UILabel *orderMoney;
    NSString * stringAfterJoin ;  // 拼接好的string
    
    NSString * firstCellText;
    
    NSMutableArray * nameAndPhone;      //联系人名字和电话号码
    UIButton * sendMessageBtn;
    BOOL haveThisMan;
}
@property (retain, nonatomic) IBOutlet UIView *bigHeadView;
@property (retain, nonatomic) IBOutlet UIView *headView;
// @property (retain, nonatomic) NSArray * cellTitleArr;
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

@property (retain, nonatomic) NSMutableArray * indexArr;

///  cell属性的定义
@property (retain, nonatomic) IBOutlet UILabel *upPayMoney;
@property (retain, nonatomic) IBOutlet UILabel *bigUpPayMoney;


//*****headView  property
@property (retain, nonatomic) IBOutlet UILabel *PerStanderPrice;
@property (retain, nonatomic) IBOutlet UILabel *PersonConstructionFee;
@property (retain, nonatomic) IBOutlet UILabel *personAdultBaf;
@property (retain, nonatomic) IBOutlet UILabel *personMuber;
@property (retain, nonatomic) IBOutlet UILabel *Personinsure;


@property (retain, nonatomic) IBOutlet UILabel *backLabel;
@property (retain, nonatomic) IBOutlet UILabel *childStanderPrice;
@property (retain, nonatomic) IBOutlet UILabel *childConstructionFee;
@property (retain, nonatomic) IBOutlet UILabel *childBaf;
@property (retain, nonatomic) IBOutlet UILabel *childMunber;
@property (retain, nonatomic) IBOutlet UILabel *childInsure;



@property (retain, nonatomic) NSString * goPay;
@property (retain, nonatomic) NSString * goCabin;
@property (retain, nonatomic) NSString * backPay;
@property (retain, nonatomic) NSString * backCabin;
@property (retain, nonatomic) NSString * childGopay; // 儿童去程价格
@property (retain, nonatomic) NSString * childBackPay; 

@property (nonatomic,retain) UIView * tempView;
@property (nonatomic,assign) float headViewHegiht;

@property (nonatomic,retain) NSString * swithType;  // 记录填写保险的状态
@property (nonatomic,assign) int traveType;  // 记录填写行程单状态

- (IBAction)payMoney:(id)sender;  // 去支付订单
- (IBAction)changeToBigHeadView:(id)sender;
- (IBAction)changeToSmallHeadView:(id)sender;

@end
