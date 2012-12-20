//
//  BuyInsuranceViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyInsuranceViewController;
@protocol BuyInsuranceViewControllerDelegate <NSObject>

@optional


//记录用户是否购买保险的代理方法
-(void) BuyInsuranceViewController:(BuyInsuranceViewController *) controller   didBuyInsurance: (BOOL) flag;
@end


@interface BuyInsuranceViewController : UIViewController


//代理
@property(nonatomic,assign)id<BuyInsuranceViewControllerDelegate> delegate;




@end
