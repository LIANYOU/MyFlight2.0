//
//  CoachTableViewController.h
//  MyFlight2.0
//
//  Created by apple on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPortData.h"
@interface CoachTableViewController : UITableViewController
{
    NSInteger orientationCoach;
    NSMutableData * myData;
    AirPortData * _subAirPortData;
    
    BOOL * flagOpenOrClose; //开关状态
    NSArray * sectionCount; //一共有多少个section
}
@property(nonatomic,assign)NSInteger orientationCoach;
@property(nonatomic,retain)AirPortData * subAirPortData;

-(void)getData;
-(void)refreshGetData;
@end
