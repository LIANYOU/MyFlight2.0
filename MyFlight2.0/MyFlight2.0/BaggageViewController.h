//
//  BaggageViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaggageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableData * myData;
    NSString * _myAirPortCode;
}
@property(nonatomic,retain)NSString * myAirPortCode;
@end
