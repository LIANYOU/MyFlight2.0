//
//  CustomTableViewCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
{
    IBOutlet UIButton *selectBtn;   // 选择的图标
    IBOutlet UILabel *airPortName;  // 机场名字
}
@property (retain, nonatomic) IBOutlet UILabel *airPortName;
@property (retain, nonatomic) IBOutlet UIButton *selectBtn;

@end
