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
    
    IBOutlet UILabel *type;
    
    IBOutlet UITextField *name;
    IBOutlet UITextField *city;
    IBOutlet UITextField *address;
    IBOutlet UITextField *phone;
    
    int btnTag;
    
    void (^blocks) (NSString *schedule, NSString *postPay, int chooseBtnIndex);
}

@property(nonatomic,retain) NSString * schedule_;
@property(nonatomic,retain) NSString * postPay_;

- (IBAction)noNeed:(UIButton *)sender;
- (IBAction)helpYourself:(UIButton *)sender;
- (IBAction)post:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIView *backView;
@property (assign, nonatomic) int flag;  // 标记上次选择了哪一个btn
@property (retain, nonatomic) IBOutlet UIView *postView;

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay, int chooseBtnIndex))string;
- (IBAction)postType:(id)sender;

@end
