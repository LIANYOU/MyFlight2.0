//
//  LookForPasswordFirstStepViewController.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/16/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
@interface LookForPasswordFirstStepViewController : UIViewController<ServiceDelegate>
- (IBAction)backKeyBoard:(id)sender;


@property (retain, nonatomic) IBOutlet UITextField *UserInputPhoneNumber;

- (IBAction)goToNextStep:(id)sender;


@end
