//
//  TravelPhoneViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPortData.h"
@interface TravelPhoneViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView * myTableView;
    NSMutableData * myData;
    NSString * _airPort;
    NSMutableArray * phoneInfoArray;   //电话号码和名称
    UILabel * titlelabel;   //名称
    UILabel * phoneLabel;
    BOOL didFinish;
    
    double addLength;
    double allLength;
    double lengthPoint;
    NSMutableData * myTestData;
    
    AirPortData * _subAirPortData;
}
//@property(nonatomic,retain) NSString * airPort;
@property(nonatomic,retain)AirPortData * subAirPortData;

@end
