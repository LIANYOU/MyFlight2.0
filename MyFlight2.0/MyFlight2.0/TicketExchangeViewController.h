//
//  TicketExchangeViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CustomPickerDataSource2.h"
#import "ITTDataRequest.h"

@interface TicketExchangeViewController : UIViewController<UITextFieldDelegate,DataRequestDelegate>{

    IBOutlet UILabel *_telLabel;
    IBOutlet UITableView *_tableView;
    IBOutlet UITextField *textFieldCabinName;
    
    IBOutlet UIPickerView *_pickerAirline;
    IBOutlet UIPickerView *_pickerSegType;
    IBOutlet UIPickerView *_pickerPassengerType;
    IBOutlet UIPickerView *_pickerQueryType;
    IBOutlet UIPickerView *_pickerCabinType;
    IBOutlet UIDatePicker *_pickerTime;
    
    IBOutlet UIView *_viewAitlinePicker;
    IBOutlet UIView *_viewSegTypePicker;
    IBOutlet UIView *_viewPassengerTypePicker;
    IBOutlet UIView *_viewQueryTypePicker;
    IBOutlet UIView *_viewCabinTypePicker;
    IBOutlet UIView *_viewTimePicker;
    
    IBOutlet UIView *_contentView;
    
    CustomPickerDataSource2 *_dsCompanyPicker;
    CustomPickerDataSource2 *_dsSegTypePicker;
    CustomPickerDataSource2 *_dsPassengerTypePicker;
    CustomPickerDataSource2 *_dsQueryTypePicker;
    CustomPickerDataSource2 *_dsCabinTypePicker;
    CustomPickerDataSource2 *dsTimePicker;
    
    NSMutableArray *_dataArray;
    BOOL isPickingCityForDept;
    BOOL isFirstInit;
    BOOL isFreeTickeQuery;//查询类型为免票
    
}

@property (retain,nonatomic) UITextField *textFieldCabinName;
@property (nonatomic,retain)NSDate *deptDate;
@property (nonatomic,retain)NSString *strDeptDate;


-(IBAction)computeAction:(id)sender;
- (IBAction)confirmAirlinePicker:(id)sender;
- (IBAction)closeAirlinePickerView:(id)sender;

- (IBAction)confirmSegTypePicker:(id)sender;
- (IBAction)closeSegTypePickerView:(id)sender;

- (IBAction)confirmPassengerTypePicker:(id)sender;
- (IBAction)closePassengerTypePickerView:(id)sender;

- (IBAction)confirmQueryTypePicker:(id)sender;
- (IBAction)closeQueryTypePickerView:(id)sender;

- (IBAction)confirmCabinTypePicker:(id)sender;
- (IBAction)closeCabinTypePickerView:(id)sender;

- (IBAction)confirmTimePicker:(id)sender;
- (IBAction)closeTimePickerView:(id)sender;

-(IBAction)telAction:(id)sender;
@end
