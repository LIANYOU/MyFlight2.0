//
//  ChooseAirPortViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/12/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAirPortViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
