//
//  MyCenterTable_1.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/27/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface MyCenterTable_1 : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>


@property (retain, nonatomic) IBOutlet UITableView *thisTableView;



@property(nonatomic,retain)NSString *accountString;
@property(nonatomic,retain)NSString *allAccountMoneyString;
@property(nonatomic,retain)NSString *goldMoneyString;
@property(nonatomic,retain)NSString *silverMoneyString;


@end
