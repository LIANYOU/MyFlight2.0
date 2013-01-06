//
//  MyLowOrderListViewController.h
//  MyFlight2.0
//
//  Created by WangJian on 13-1-6.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListCell;
@interface MyLowOrderListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *showTableView;
@property (retain, nonatomic) IBOutlet UIView *headView;
@property (retain, nonatomic) IBOutlet UIView *footView;

@property (retain, nonatomic) IBOutlet ListCell *list;

@end
