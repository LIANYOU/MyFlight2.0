//
//  PhoneReChargeViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/6/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface PhoneReChargeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,UITextFieldDelegate>


@property (retain, nonatomic) IBOutlet UIView *thisFootView;

@property (retain, nonatomic) IBOutlet UITableView *thisTableView;

@property(nonatomic,retain)NSString *cardNOString;
@property(nonatomic,retain)NSString *passWd;

- (IBAction)makeCharge:(id)sender;

@property(nonatomic,retain)UITextField *accountField;
@property(nonatomic,retain)UITextField *pwdField;

@end
