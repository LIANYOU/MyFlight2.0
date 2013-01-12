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
#import "SendToFriendViewController.h"
#import "RecommendationViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface AboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *titleArray;
    
    UIAlertView *alertMessage;
}

- (void) chechkForUpdate;

@end
