//
//  ChooseSpaceViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseSpaceCell.h"

@interface ChooseSpaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UILabel *SpaceName;
@property (retain, nonatomic) IBOutlet UIButton *changeSpace;
@property (retain, nonatomic) IBOutlet UILabel *payMoney;
@property (retain, nonatomic) IBOutlet UILabel *ticketCount;
@property (retain, nonatomic) IBOutlet UILabel *discount;
@property (retain, nonatomic) IBOutlet UITableView *showTableView;

@property (retain, nonatomic) IBOutlet ChooseSpaceCell *spaceCell;

@property(nonatomic,readonly) NSArray * spaceNameArr;  // 存放cell的仓明（超值经济舱，经济舱）

@end
