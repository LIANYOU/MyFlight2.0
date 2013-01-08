//
//  WeatherViewController.h
//  MyFlight2.0
//
//  Created by apple on 13-1-5.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AirPortData.h"
@interface WeatherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AirPortData * _subAirPortData;
    NSMutableDictionary * myDic;
    NSMutableArray * myArray;
    NSString *  nsDateString;
    UITableView * myTableView;
    NSArray * hightArray;
    
    NSArray * tempPicNameArray;
}
@property(nonatomic,retain)AirPortData * subAirPortData;
@end
