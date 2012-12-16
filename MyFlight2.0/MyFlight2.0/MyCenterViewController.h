//
//  MyCenterViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/5/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCenterViewCell.h"
#import "MyCenterViewCommonCell.h"
@interface MyCenterViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet MyCenterViewCommonCell *myCommonCell;

@property (retain,nonatomic) NSArray * titleArr;
@property (retain,nonatomic) NSArray * imageArr;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet MyCenterViewCell *myCell;

@end
