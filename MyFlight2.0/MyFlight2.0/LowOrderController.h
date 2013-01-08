//
//  LowOrderController.h
//  MyFlight2.0
//
//  Created by WangJian on 12-12-15.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDelegate.h"
#import "Date.h"
#import "ViewControllerDelegate.h"
#import "LowOrderCell.h"
#import "LowTextFiledCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ChooseAirPortViewController.h"

@interface LowOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate, ViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ServiceDelegate,UITextFieldDelegate,UIAlertViewDelegate,ChooseAirPortViewControllerDelegate>
{
    UIActionSheet * actionSheet;
    Date* leaveDate;
    
    
    IBOutlet UILabel *oneStartAirPort;
    UILabel * changeString;
    IBOutlet UILabel *oneEndAirPort;
    
    IBOutlet UILabel *endTitle;
    IBOutlet UILabel *beginTitle;
    IBOutlet UIImageView *endImage;
    IBOutlet UIImageView *beginImage;
}


@property (nonatomic, retain) NSMutableArray * seconderLabelArr;
@property (retain, nonatomic) IBOutlet UILabel *startAirport;
@property (retain, nonatomic) IBOutlet UILabel *endAirport;

@property (nonatomic, retain) NSString * startCode;
@property (nonatomic, retain) NSString * endCode;

@property (nonatomic, retain) NSString * start;
@property (nonatomic, retain) NSString * end;

@property (nonatomic, retain) NSArray * contents;
@property (retain, nonatomic) IBOutlet UITableView *showTabelView;
@property (nonatomic,retain) NSArray * firstLabelArr;
@property (retain, nonatomic) IBOutlet LowOrderCell *lowOrderCell;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *footView;


@property (retain, nonatomic) IBOutlet LowTextFiledCell *phoneCEll;


- (IBAction)orderNow:(id)sender;

@property (nonatomic, retain) NSString * flagStr;

@property (retain, nonatomic) IBOutlet UIView *bigFuckView;

@property (retain, nonatomic) IBOutlet UIView *smallFuckView;


@property (retain, nonatomic) UIView * tempView;
@property (retain, nonatomic) IBOutlet UIButton *changAirPort;
@property (retain, nonatomic) IBOutlet UIView *endView;
- (IBAction)getStartAirport:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *getEndAirPort;
- (IBAction)getEndAirPort:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *beginView;
- (IBAction)chang:(id)sender;
@end
