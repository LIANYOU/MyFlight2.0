//
//  TravelTrafficViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTrafficViewController : UIViewController
{
    NSString * _airPortCode;
    NSMutableData * myData;
    NSInteger mySegValue;   //seg值，作为交通类型
    UILabel * navgaitionLabel;
    NSInteger orientation;  //方向
}
@property(nonatomic,retain) NSString * airPortCode;

@end
