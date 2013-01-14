//
//  TraveController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraveController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{

    IBOutlet UIButton *noNeedBtn;
    IBOutlet UIButton *helpYourselfBtn;
    IBOutlet UIButton *post;
    
    IBOutlet UILabel *type;
    
    IBOutlet UITextField *name;

    
    IBOutlet UILabel *city;
    
    IBOutlet UITextField *address;
    IBOutlet UITextField *phone;
    
    int btnTag;
    
    void (^blocks) (NSString *schedule, NSString *postPay, int chooseBtnIndex,NSString * city, NSArray * InfoArr);
}

@property(nonatomic,retain) NSString * schedule_;
@property(nonatomic,retain) NSString * postPay_;

- (IBAction)noNeed:(UIButton *)sender;
- (IBAction)helpYourself:(UIButton *)sender;
- (IBAction)post:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIView *backView;
@property (assign, nonatomic) int flag;  // 标记上次选择了哪一个btn
@property (retain, nonatomic) IBOutlet UIView *postView;

@property (retain, nonatomic) NSMutableArray * postArr;


@property (retain, nonatomic) NSString * cellText;  // 上一界面传递过来的行程单的配送方式


@property (retain, nonatomic) IBOutlet UIImageView *image1;
@property (retain, nonatomic) IBOutlet UIImageView *image2;
@property (retain, nonatomic) IBOutlet UIImageView *image3;

@property (retain, nonatomic) IBOutlet UITextField *postName;
@property (retain, nonatomic) IBOutlet UITextField *postCity;
@property (retain, nonatomic) IBOutlet UITextField *postAddress;
@property (retain, nonatomic) IBOutlet UITextField *postPhone;
@property (retain, nonatomic) IBOutlet UILabel *postType;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *backViewBlack;

@property (retain, nonatomic)NSMutableArray * postInfoArr;

-(void)getDate:(void (^) (NSString *schedule, NSString *postPay, int chooseBtnIndex ,NSString * city, NSArray * InfoArr))string;
- (IBAction)postType:(id)sender;
- (IBAction)getPostCity:(id)sender;
- (IBAction)postFast:(id)sender;
- (IBAction)postSlow:(id)sender;

@end
