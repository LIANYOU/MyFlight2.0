//
//  AirportMainScreenSearchView.h
//  MyFlight2.0
//
//  Created by apple on 12-12-30.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AirportMainScreenSearchView : UIView
{
    UIView *leftItem;
    UIView *rightItem;
    UIView *centerItem;
    
    UITextField *textInput;
}

@property (assign, nonatomic) id delegate;

- (void) setLeftIconVisible;
- (void) setLeftIconInvisible;
- (void) setRightIconVisible;
- (void) setRightIconInvisible;
- (void) userDidInput;

@end
