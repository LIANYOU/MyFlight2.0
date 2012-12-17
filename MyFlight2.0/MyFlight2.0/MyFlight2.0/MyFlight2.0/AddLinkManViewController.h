//
//  AddLinkManViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetLinkManInfo;
@interface AddLinkManViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GetLinkManInfo * linkMan;
    NSMutableArray * linkManArray;
    UITableView * myTableView;
}
@end
