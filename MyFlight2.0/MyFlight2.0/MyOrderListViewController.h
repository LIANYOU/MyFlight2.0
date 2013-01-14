//
//  MyOrderListViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "ServiceDelegate.h"
@interface MyOrderListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>
{
    
    SVSegmentedControl * segmented;
}

//查看本地订单

- (IBAction)lookForLocalOrderList:(id)sender;


@property (retain, nonatomic) IBOutlet UIView *thisFuckFootView;



@property (retain, nonatomic) IBOutlet UIView *customView;

@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

@property (retain, nonatomic) IBOutlet UIView *thisHeadView;



@property(nonatomic,retain)NSArray *noPaylistArray;
@property(nonatomic,retain)NSArray *alreadlyListArray;
@property(nonatomic,retain)NSArray  *allOrderListArray;

@end
