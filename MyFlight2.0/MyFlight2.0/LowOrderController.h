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
#import "ShowSelectedResultViewController.h"


@interface LowOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate, ViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ServiceDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIActionSheet * actionSheet;
    Date* leaveDate;
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

@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet LowTextFiledCell *phoneCEll;
@property (retain, nonatomic) IBOutlet UIView *bigBiew;
@property (retain, nonatomic) IBOutlet UIView *smallView;

@property (retain, nonatomic) IBOutlet UIView *beginView;
@property (retain, nonatomic) IBOutlet UIView *endView;
@property (retain, nonatomic) IBOutlet UIImageView *twoBeginImageView;
@property (retain, nonatomic) IBOutlet UIImageView *twoEndImageView;
@property (retain, nonatomic) IBOutlet UILabel *twoBeginTitle;
@property (retain, nonatomic) IBOutlet UILabel *twoEndTitle;



@property (retain, nonatomic) ShowSelectedResultViewController * show;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerSort;
- (IBAction)orderNow:(id)sender;
- (IBAction)changAirPort:(id)sender;

@end
