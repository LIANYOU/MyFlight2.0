//
//  FlightCompanyDistrubuteViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightCompanyDistrubuteViewController : UIViewController
{
    NSString * _airPortCode;
    NSMutableData * myData;
    UITextView * myTextView;
    UILabel * myTitleLabel;
}
@property(nonatomic,retain) NSString * airPortCode;

@end
