//
//  AddPersonController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChoosePersonController;
@class AddPersonCoustomCell;
@class AddPersonSwitchCell;
@interface AddPersonController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UISwitch *mySwitch;
    void (^blocks) (NSString * name, NSString * identity);
    
    NSString * name;
    NSString * identityType;  // 成人或儿童
}

@property (retain, nonatomic) IBOutlet UITableView *addPersonTableView;

@property (retain, nonatomic) IBOutlet AddPersonCoustomCell *addPersonCoustomCell;

@property (retain, nonatomic) IBOutlet AddPersonSwitchCell *addPersonSwithCell;

@property (retain, nonatomic) ChoosePersonController * choose;

@property(nonatomic,retain) NSArray * cellTitleArr;
@property(nonatomic,retain) NSMutableArray * cellTextArr;

-(void)getDate:(void (^) (NSString * name, NSString * identity))string;
@end
