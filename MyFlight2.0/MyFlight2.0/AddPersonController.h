//
//  AddPersonController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddPersonCell;
@class AddPersonSwitchCell;
@interface AddPersonController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITableView *addPersonTableView;
@property (retain, nonatomic) IBOutlet AddPersonCell *addPersonCell;
@property (retain, nonatomic) IBOutlet AddPersonSwitchCell *addPersonSwithCell;

@property(nonatomic,retain) NSArray * cellTitleArr;
@property(nonatomic,retain) NSMutableArray * cellTextArr;
@end
