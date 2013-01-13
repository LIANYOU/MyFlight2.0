//
//  HomeMoreController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "TutorialViewController.h"
#import "BindSNSViewController.h"

@class MoreCell;
@interface HomeMoreController : UITableViewController
@property (retain, nonatomic) IBOutlet MoreCell *moreCell;
@property(nonatomic,retain) NSArray * arr;

@end
