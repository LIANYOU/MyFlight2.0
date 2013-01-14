//
//  TravelAssistantViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseAirPortViewController.h"
#import "AirPortData.h"
@interface TravelAssistantViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChooseAirPortViewControllerDelegate,UIAlertViewDelegate>
{
    UITableView * myTableView;
    NSArray * imageArray;
    NSArray * titleArray;   
    AirPortData * _myAirPortData;
    NSString * airPortCode;     // 机场三字码
    UILabel * rightItemTitleLable;
    
    
    
}
@property(nonatomic,retain)AirPortData * myAirPortData;
@end
