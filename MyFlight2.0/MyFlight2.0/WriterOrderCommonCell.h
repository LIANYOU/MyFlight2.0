//
//  WriterOrderCommonCell.h
//  MyFlight2.0
//
//  Created by sss on 12-12-6.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriterOrderCommonCell : UITableViewCell
{
    
    IBOutlet UILabel *secondLabel;
    IBOutlet UILabel *firstLable;
}
@property (retain, nonatomic) IBOutlet UILabel *secondLable;
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UILabel *firstLable;
@property (retain, nonatomic) IBOutlet UILabel *imageLabel;

@property (retain, nonatomic) IBOutlet UIImageView *fristImageView;
@property (retain, nonatomic) IBOutlet UIImageView *secImageView;
@property (retain, nonatomic) IBOutlet UIImageView *sortImageView;



@end
