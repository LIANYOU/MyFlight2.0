//
//  MyLowOrderListViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@class ListCell;
@class SmallListCell;
@interface MyLowOrderListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ServiceDelegate>

@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet UIView *headView;
@property (retain, nonatomic) IBOutlet UIView *footView;

@property (retain, nonatomic) IBOutlet SmallListCell *smallCell;


@property (retain, nonatomic) NSMutableArray * flightListArr;

@property (retain, nonatomic) NSArray * dataArr;

@property (retain, nonatomic) NSMutableArray * indexArr;

@property (retain, nonatomic) IBOutlet ListCell *list;

@end
