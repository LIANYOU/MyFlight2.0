//
//  ChoosePersonController.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ChoosePersonCell.m"
@interface ChoosePersonController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *showPersonTableView;

//@property (retain, nonatomic) IBOutlet ChoosePersonCell *choosePersonTableView;

@end
