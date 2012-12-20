//
//  TravelAssistantViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseAirPortViewController.h"
@interface TravelAssistantViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChooseAirPortViewControllerDelegate>
{
    UITableView * myTableView;
    NSArray * imageArray;
    NSArray * titleArray;
}
@end
