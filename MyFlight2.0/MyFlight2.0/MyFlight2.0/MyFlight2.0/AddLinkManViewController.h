//
//  AddLinkManViewController.h
//  MyFlight2.0
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetLinkManInfo;
@protocol AddLinkManViewControllerDelegate <NSObject>

-(void)oneManWasChosed:(NSDictionary *)choseDic;

@end

@interface AddLinkManViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GetLinkManInfo * linkMan;
    NSArray * linkManArray;
    UITableView * myTableView;
    id<AddLinkManViewControllerDelegate> _delegate;
}
@property(nonatomic,assign) id<AddLinkManViewControllerDelegate> delegate;
@end
