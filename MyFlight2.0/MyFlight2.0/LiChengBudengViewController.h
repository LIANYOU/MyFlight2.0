//
//  LiChengBudengViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiChengBudengViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

@property (retain, nonatomic) IBOutlet UIView *footFuckView;

@property(nonatomic,retain)NSArray *nameArray;
@end
