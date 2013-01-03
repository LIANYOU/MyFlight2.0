//
//  SubwayTableViewController.h
//  MyFlight2.0
//
//  Created by apple on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPortData.h"
@interface SubwayTableViewController : UITableViewController
{
    NSInteger orientationSubway;
    AirPortData * _subAirPortData;
    NSMutableData * myData;
}
@property(nonatomic,assign)NSInteger orientationSubway;
@property(nonatomic,retain)AirPortData * subAirPortData;

-(void)getData;
-(void)refreshGetData;
@end
