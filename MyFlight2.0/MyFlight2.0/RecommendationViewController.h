//
//  RecommendationViewController.h
//  MyFlight2.0
//
//  Created by 123 123 on 13-1-12.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"

@interface RecommendationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *table;
    
    UIAlertView *alertMessage;
    
    __block NSDictionary *responseDictionary;
}

- (void) requestForData;

@end
