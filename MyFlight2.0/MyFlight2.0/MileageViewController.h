//
//  MileageViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CustomPickerDataSource2.h"
#import "ITTDataRequest.h"

@interface MileageViewController : UIViewController<DataRequestDelegate,UITextFieldDelegate>{

    IBOutlet UITextField *_textField1;
    IBOutlet UITextField *_textField2;
    IBOutlet UITextField *_textField3;
    IBOutlet UITextField *_textField4;
    IBOutlet UITableView *_tableView;
    IBOutlet UIView *_viewAitlinePicker;
    IBOutlet UIPickerView *_pickerAirline;
     IBOutlet UIView *_contentView;
    
    IBOutlet UIDatePicker *_pickerTime;
    IBOutlet UIView *_viewTimePicker;
    CustomPickerDataSource2 *dsTimePicker;
    
    IBOutlet UIPickerView *_pickerCabinType;
    IBOutlet UIView *_viewCabinTypePicker;
    CustomPickerDataSource2 *_dsCabinTypePicker;
    
    CustomPickerDataSource2 *_dsCompanyPicker;
    NSMutableArray *_dataArray;
    BOOL isPickingCityForDept;
    NSString *strDeptDate;
    NSDate *deptDate;
    
}

@property (nonatomic,retain)NSString *strDeptDate;
@property (nonatomic,retain)NSDate *deptDate;
@property (nonatomic,retain)UIDatePicker *_pickerTime;
@property (nonatomic,retain)UIView *_viewTimePicker;
@property (nonatomic,retain)CustomPickerDataSource2 *dsTimePicker;
@property (nonatomic,retain)IBOutlet UIPickerView *_pickerCabinType;
@property (nonatomic,retain)IBOutlet UIView *_viewCabinTypePicker;
@property (nonatomic,retain)CustomPickerDataSource2 *_dsCabinTypePicker;

-(IBAction)submitAction:(id)sender;
- (IBAction)confirmAirlinePicker:(id)sender;
- (IBAction)closeAirlinePickerView:(id)sender;

- (IBAction)confirmTimePicker:(id)sender;
- (IBAction)closeTimePickerView:(id)sender;

- (IBAction)confirmCabinTypePicker:(id)sender;
- (IBAction)closeCabinTypePickerView:(id)sender;

@end
