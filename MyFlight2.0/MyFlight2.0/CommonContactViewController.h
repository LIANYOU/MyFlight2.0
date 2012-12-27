//
//  CommonContactViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface CommonContactViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate>

@property(nonatomic,retain)NSMutableArray *resultArray;


@property (retain, nonatomic) IBOutlet UITableView *thisTableView;



@end
