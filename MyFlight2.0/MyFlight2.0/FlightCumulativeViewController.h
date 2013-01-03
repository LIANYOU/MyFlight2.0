//
//  FlightCumulativeViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CustomPickerDataSource2.h"
#import "ITTDataRequest.h"
#import "DataGridComponent.h"

@interface FlightCumulativeViewController : UIViewController<UITextFieldDelegate,DataRequestDelegate,DataGridViewDelegate>{

    IBOutlet UILabel *_telLabel;
    IBOutlet UITableView *_tableView;
    IBOutlet UIView *_viewAitlinePicker;
    IBOutlet UIPickerView *_pickerAirline;
     IBOutlet UIView *_contentView;
    
    IBOutlet UIPickerView *_pickerCabinType;
    IBOutlet UIView *_viewCabinTypePicker;
    CustomPickerDataSource2 *_dsCabinTypePicker;

    IBOutlet UIDatePicker *_pickerTime;
    IBOutlet UIView *_viewTimePicker;
    CustomPickerDataSource2 *dsTimePicker;
    
    CustomPickerDataSource2 *_dsCompanyPicker;
    NSMutableArray *_dataArray;
    BOOL isPickingCityForDept;
     BOOL isFirstInit;
    
    IBOutlet UITextField *textFieldCabinName;
    
}

@property (retain,nonatomic) UITextField *textFieldCabinName;
@property (nonatomic,retain)NSDate *deptDate;
@property (nonatomic,retain)NSString *strDeptDate;

-(IBAction)computeAction:(id)sender;
- (IBAction)confirmAirlinePicker:(id)sender;
- (IBAction)closeAirlinePickerView:(id)sender;
-(IBAction)telAction:(id)sender;

- (IBAction)confirmCabinTypePicker:(id)sender;
- (IBAction)closeCabinTypePickerView:(id)sender;

- (IBAction)confirmTimePicker:(id)sender;
- (IBAction)closeTimePickerView:(id)sender;
@end
