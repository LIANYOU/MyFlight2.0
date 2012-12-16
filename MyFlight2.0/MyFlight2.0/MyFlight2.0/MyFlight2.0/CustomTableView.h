//
//  CustomTableView.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface CustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * cellArr;   // 存放不同button推进来的cell的内容
    UITableView * _tableView;
}

@property (retain, nonatomic) IBOutlet CustomTableViewCell *resultCell;

-(id)initWithButtonName:(NSString *)name andAirPortTwoCode:(NSArray *) codeArr andTable:(UITableView *) tableView; // 通过点击的button的名字确认弹出的table里边有多少行数
@end
