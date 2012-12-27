//
//  AddContactViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/21/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface AddContactViewController : UIViewController<ServiceDelegate>


@property (retain, nonatomic) IBOutlet UILabel *personTypeLabel;

@property (retain, nonatomic) IBOutlet UITextField *personNameLabel;

//显示用户 输入的姓名 
- (IBAction)personInputInfoBn:(id)sender;


@end
