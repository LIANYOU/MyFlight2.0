//
//  PersonalInfoViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface PersonalInfoViewController : UIViewController<ServiceDelegate>

//用户名字 
@property (retain, nonatomic) IBOutlet UITextField *personalName;



//详细地址 
@property (retain, nonatomic) IBOutlet UITextField *detailAddress;



//性别选择
@property (retain, nonatomic) IBOutlet UISegmentedControl *sexChoice;

//性别显示
@property (retain, nonatomic) IBOutlet UILabel *sexName;


- (IBAction)backKeyBoard:(id)sender;


@end
