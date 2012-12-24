//
//  MyNewCenterViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface MyNewCenterViewController : UIViewController<ServiceDelegate>







//用户名
@property (retain, nonatomic) IBOutlet UILabel *userNameLabel;

//资金账户余额
@property (retain, nonatomic) IBOutlet UILabel *accountMoneyLabel;
//金币余额
@property (retain, nonatomic) IBOutlet UILabel *xlGoldMoneyLabel;

//银币余额

@property (retain, nonatomic) IBOutlet UILabel *xlSilverMoneyLabel;


//显示个人资料界面
- (IBAction)gotoPersonalInfo:(id)sender;


//推出我的优惠券界面 
- (IBAction)gotoMyCoupons:(id)sender;

//显示我的订单列表 
- (IBAction)gotoMyOrderList:(id)sender;

//显示我的常用乘机人
- (IBAction)gotoCommonPerson:(id)sender;
//显示我订阅的低价航线
- (IBAction)gotoMyCheapFlightList:(id)sender;

//心愿旅行卡充值 
- (IBAction)gotoMakeAccountFull:(id)sender;



- (void) updateThisViewWhenSuccess;


@end
