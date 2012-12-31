//
//  MyCheapViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "ServiceDelegate.h"
@interface MyCheapViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>

{
    
    
    SVSegmentedControl * segmented;
}
@end
