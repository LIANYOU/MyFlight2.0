//
//  AboutViewController.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FeedbackViewController.h"

@interface AboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *titleArray;
}

@end
