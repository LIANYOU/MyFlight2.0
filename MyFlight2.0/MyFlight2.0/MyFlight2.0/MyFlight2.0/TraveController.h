//
//  TraveController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraveController : UIViewController

{

    IBOutlet UIButton *noNeedBtn;
    IBOutlet UIButton *helpYourselfBtn;
    IBOutlet UIButton *post;
}

- (IBAction)noNeed:(id)sender;
- (IBAction)helpYourself:(id)sender;
- (IBAction)post:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *postView;

@end
