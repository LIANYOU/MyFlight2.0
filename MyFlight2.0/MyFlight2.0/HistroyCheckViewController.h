//
//  HistroyCheckViewController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryCell;
@interface HistroyCheckViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet HistoryCell *historyCell;
@property (retain, nonatomic) IBOutlet UITableView *showTableView;

@end
