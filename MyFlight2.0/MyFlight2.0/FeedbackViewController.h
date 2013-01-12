//
//  FeedbackViewController.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-9.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "BasicViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"

@interface FeedbackViewController : BasicViewController <UITextViewDelegate, UITextFieldDelegate>
{
    UITextView *message;
    UITextField *address;
    
    UIAlertView *alertMessage;
    
    UIButton *invisibleButton;
}

- (void) send:(UIButton *) sender;

@end
