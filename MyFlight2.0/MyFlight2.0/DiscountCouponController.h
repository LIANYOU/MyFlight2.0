//
//  DiscountCouponController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-28.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UseGoldPay.h"
#import "ServiceDelegate.h"
@class UseDiscountCell;
@class GoldCoinCell;
@interface DiscountCouponController : UIViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{

    void (^blocks) (NSString * swithStation, NSString * silverOrDiscount ,NSString * gold, NSMutableArray * arr);
}


/// ************   keyBar
@property (retain, nonatomic) IBOutlet UITextField *tempText;
@property (retain, nonatomic) IBOutlet UITextField *text;
@property (retain, nonatomic) IBOutlet UIView *keyBoardBar;
@property (retain, nonatomic) IBOutlet UITextField *keyText;
- (IBAction)sure:(id)sender;
///**************


@property (nonatomic, retain) NSArray * captchaListArr;

@property (retain, nonatomic) NSMutableArray * selectArr;

@property (retain, nonatomic) IBOutlet UISwitch *swith;
@property (retain, nonatomic) NSString * swithStation;
@property (retain, nonatomic) NSString * type;  // 开关状态

@property (retain, nonatomic) IBOutlet UITableView *showDiscountTableView;
@property (retain, nonatomic) IBOutlet UIView *sectionHeadViewOne;
@property (retain, nonatomic) IBOutlet UIView *sectionHeadViewTwo;
@property (retain, nonatomic) IBOutlet UIView *sectionFootView;
@property (retain, nonatomic) IBOutlet UseDiscountCell *discountCell;
@property (retain, nonatomic) IBOutlet GoldCoinCell *goldCell;

@property (retain, nonatomic) UseGoldPay * gold;
@property (retain, nonatomic) NSMutableArray * indexArr;
@property (retain, nonatomic) NSMutableArray * nextSelectArr;// 下个界面选择的优惠券的种类

@property (retain, nonatomic) NSString * accountAmount;  // 账户资金
@property (retain, nonatomic) NSString * goldAmount;     // 金币数目
@property (retain, nonatomic) NSString * silverAmount;   // 银币数目

- (IBAction)swithOFFOrON:(UISwitch *)sender;

-(void)getDate:(void (^) (NSString * swithStation, NSString * silverOrDiscount ,NSString * gold, NSMutableArray * arr))string;



@end
