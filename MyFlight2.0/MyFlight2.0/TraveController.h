//
//  TraveController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraveController : UIViewController<UITextFieldDelegate>
{

    IBOutlet UIButton *noNeedBtn;
    IBOutlet UIButton *helpYourselfBtn;
    IBOutlet UIButton *post;
    
    
    IBOutlet UITextField *name;
    IBOutlet UITextField *city;
    IBOutlet UITextField *address;
    IBOutlet UITextField *phone;
    
    void (^blocks) (NSString *schedule, NSString *postPay);
}

@property(nonatomic,retain) NSString * schedule_;
@property(nonatomic,retain) NSString * postPay_;

- (IBAction)noNeed:(id)sender;
- (IBAction)helpYourself:(id)sender;
- (IBAction)post:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *postView;

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay))string;

@end
