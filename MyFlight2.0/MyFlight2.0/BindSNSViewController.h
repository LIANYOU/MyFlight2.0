//
//  BindSNSViewController.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-11.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MultiChoiceTableViewSupport.h"
#import "MultiChoiceCell.h"

@interface BindSNSViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MultiChoiceTableViewSupport>
{
    UITableView *table;
}

@end
