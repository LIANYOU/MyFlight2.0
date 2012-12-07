//
//  ChoosePersonCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePersonCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *chooseBtn;    // 多选按钮
@property (retain, nonatomic) IBOutlet UILabel *personName;    // 联系人姓名
@property (retain, nonatomic) IBOutlet UILabel *personType;    // 联系人类型(成人，儿童)
@property (retain, nonatomic) IBOutlet UILabel *papersNumber;  // 证件号码

@end
