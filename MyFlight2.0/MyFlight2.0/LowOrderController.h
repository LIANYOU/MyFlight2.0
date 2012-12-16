//
//  LowOrderController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-15.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LowOrderCell;
@interface LowOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSArray * firstLabelArr;
@property (retain, nonatomic) IBOutlet LowOrderCell *lowOrderCell;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *footView;

@property (retain, nonatomic) IBOutlet UIView *viewPicker;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerSort;

@end
