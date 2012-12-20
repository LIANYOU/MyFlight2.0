//
//  MyNewCenterViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewCenterViewController : UIViewController

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


@end
