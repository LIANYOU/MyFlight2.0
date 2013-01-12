//
//  ChooseSeatOnlineViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface ChooseSeatOnlineViewController : BasicViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *imageArray;
    NSArray *titleArray;
}

@end
