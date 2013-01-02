//
//  TextInputHelperViewController.h
//  MyFlight2.0
//
//  Created by lianyou on 13-1-2.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputHelperViewController : UIViewController
{
    UITextField *textInput;
}

@property (assign, nonatomic) id delegate;
@property (assign, nonatomic) UIKeyboardType keyboardType;

- (id) initWithKeyboardType:(UIKeyboardType) type;

- (NSString *) text;
- (void) endOnExit;

@end
