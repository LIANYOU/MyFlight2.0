//
//  ChooseDiscountCouponController.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@class discountCell;
@interface ChooseDiscountCouponController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{
    void (^blocks) (NSString * name, NSString * count ,NSMutableArray * arr);
}
@property (retain, nonatomic) IBOutlet discountCell *discountCell;
@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) NSMutableArray * selectArr;
@property (retain, nonatomic) NSMutableArray * indexArr;
@property (retain, nonatomic) IBOutlet UIView *backViee;

@property (retain, nonatomic) IBOutlet UIView *footView;
@property (retain, nonatomic) NSArray * captchaList;

-(void)getDate:(void (^) (NSString * name, NSString * count ,NSMutableArray * arr))string;


@property (retain, nonatomic) IBOutlet UITextField *tempField;
@property (retain, nonatomic) IBOutlet UIView *keyBoardView;
@property (retain, nonatomic) IBOutlet UITextField *discountInfoField;
- (IBAction)checkDiscountInfo:(id)sender;
- (IBAction)inputDiscountInfo:(id)sender;

@end
