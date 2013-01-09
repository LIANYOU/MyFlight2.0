//
//  MyLocalOrderListViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/9/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLocalOrderListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    
    IBOutlet UITableView *thisFuckView;
    
    IBOutlet UIView *ceshiView;
    
}

@property (retain, nonatomic) IBOutlet UIView *thisTableHeaderView;





@property(nonatomic,retain)NSMutableArray *resultArray;


@end
