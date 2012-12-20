//
//  MyInformationController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSArray * titleArr;
@end
