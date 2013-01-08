//
//  ShowSelectedCell.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-21.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowSelectedCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *airPortImage;
@property (retain, nonatomic) IBOutlet UILabel *airportName;

@property (retain, nonatomic) IBOutlet UIButton *selectBtn;
@end
