//
//  MileageViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//

#import "MileageViewController.h"
#import "FrequentTableViewCell.h"
#import "CitySearchController.h"
#import "DataEnvironment.h"
#import "UIUtil.h"
#import "CityAirportManager.h"
#import "ComponentsFactory.h"


@implementation MileageViewController

@synthesize _pickerTime;
@synthesize _viewTimePicker;
@synthesize dsTimePicker;
@synthesize strDeptDate;
@synthesize deptDate;
@synthesize _pickerCabinType;
@synthesize _viewCabinTypePicker;
@synthesize _dsCabinTypePicker;

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"go_home@2x.png"] forState:UIControlStateNormal];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"go_home_pressed@2x.png"] forState:UIControlStateHighlighted];
//        backButton.frame = CGRectMake(3,7,50,29);
//        [backButton addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
    }
    return self;
}

-(void)BackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNav {
	UIView *navBGView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, 340, 44)];
	UIImageView *bgImage = [[UIImageView alloc] initWithFrame:navBGView.frame];
	bgImage.image = [UIImage imageNamed:[UIUtil imageName:NAV_BAR_BG_IMAGE_ORDER]];
	[navBGView addSubview:bgImage];
	[bgImage release];
	
	UIButton *backBtn = [ComponentsFactory buttonWithType:UIButtonTypeCustom
                                                    title:nil
                                                    frame:CGRECT_BACK_BUTTON
                                                imageName:IMAGE_NAME_BACK_BUTTON
                                          tappedImageName:nil
                                                   target:self 
                                                   action:@selector(BackAction:)
                                                      tag:0];
	
	[navBGView addSubview:backBtn];	
    
	NSString *title = @"里程补登";
	UILabel *titleLbl = [ComponentsFactory navigationBarTitleLabelWithTitle:title];
	[navBGView addSubview:titleLbl];
	
	UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navBGView];
	[self.navigationItem setLeftBarButtonItem:navLeft animated:YES];
    [navLeft release];
	[navBGView release];
    [title release];
}


-(BOOL)doVerify{
    
    NSString *airCode = [_textField4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([airCode length] == 0) {
        [UIUtil showAlertMessage:@"提交失败" message:@"航班号不能为空!"];
        _textField4.text = @"";
        [_textField4 becomeFirstResponder];
        return NO;
    }
    NSString *name = [_textField1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([name length] == 0) {
        [UIUtil showAlertMessage:@"提交失败" message:@"旅客姓名不能为空!"];
        _textField1.text = @"";
        [_textField1 becomeFirstResponder];
        return NO;
    }
    
    /*
     NSString *userName = [self.fieldUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     if ([userName length] == 0) {
     [UIUtil showAlertMessage:@"登录失败" message:@"用户名为空"];
     self.fieldUserName.text = @"";
     [self.fieldUserName becomeFirstResponder];
     return NO;
     }else if([userName length] < 6 || [userName length] > 20){
     [UIUtil showAlertMessage:@"登录失败" message:@"用户名长度为6-20位"];
     self.fieldUserName.text = @"";
     [self.fieldUserName becomeFirstResponder];
     return NO;
     }
     
     NSString *password = [self.fieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *strIntPwd = [NSString stringWithFormat:@"%d",[password integerValue]];
     if ([password length] == 0) {
     [UIUtil showAlertMessage:@"登录失败" message:@"请填写密码"];
     self.fieldPassword.text = @"";
     [self.fieldPassword becomeFirstResponder];
     return NO;
     }
     */
    
    //self.strUserName = userName;
    //self.strPassword = password;
    
    return YES;
}

-(IBAction)submitAction:(id)sender
{
    
    if ([self doVerify])
    {
        NSString *strDepCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:1] objectAtIndex:1]];
        NSString *strArrCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:2] objectAtIndex:1]];
        
        NSString *strFlightSeg = [[NSString alloc] initWithFormat:@"%@%@",strDepCity,strArrCity];
        
        
        //send 里程补登
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [DATA_ENV getFrequentFlyerSavedUsername],@"cardNo",
                              [UIUtil getStringWithDate:self.deptDate seperator:@""], @"flightDate",
                              strFlightSeg,@"flightSeg",
                              _textField4.text,@"flightNo",
                              _textField1.text,@"pn",
                              [[_dataArray objectAtIndex:3] objectAtIndex:1],@"cabin",
                              nil];
        
        
        [MmacPointsDataRequest requestWithDelegate:self
                                             withParameters:data
                                          withIndicatorView:self.view];
        
        [strFlightSeg release];
         
    }
}

#pragma mark - init

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)setPickerView{
    //航空公司 set airlinePickerView
    _dsCompanyPicker = [[CustomPickerDataSource2 alloc] init];
    _pickerAirline.delegate = _dsCompanyPicker;
    _pickerAirline.dataSource = _dsCompanyPicker;
    _dsCompanyPicker.customPickerArray = DATA_ENV.flightCompanyArray;
    
    [_viewAitlinePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewAitlinePicker];
    
    
    //日期 
    [_viewTimePicker setFrame:CGRectMake(0, 416, 320, 260)];
    _pickerTime.date = [[NSDate alloc] init];
    [self.view addSubview:_viewTimePicker];
    
    //舱位
    _dsCabinTypePicker = [[CustomPickerDataSource2 alloc]init];
    _pickerCabinType.delegate = _dsCabinTypePicker;
    _pickerCabinType.dataSource = _dsCabinTypePicker;
    _dsCabinTypePicker.customPickerArray = DATA_ENV.flightCabinLetterArray;
    [_viewCabinTypePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewCabinTypePicker];
}

- (IBAction)closeAirlinePickerView:(id)sender {
    [self showSelectView:_viewAitlinePicker shouldShow:NO];
}

- (IBAction)confirmAirlinePicker:(id)sender {
    [self showSelectView:_viewAitlinePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:0 withObject:[[NSMutableArray alloc] initWithObjects:@"航空公司",[DATA_ENV.flightCompanyArray objectAtIndex:[_pickerAirline selectedRowInComponent:0]], nil]];
    
    //self.strFlightCompany = [DATA_ENV.flightCompanyArray objectAtIndex:[self.pickerAirline selectedRowInComponent:0]];
    [_tableView reloadData];
}

- (IBAction)confirmTimePicker:(id)sender
{
    [self showSelectView:_viewTimePicker shouldShow:NO];
    
    NSString *strSelectedDate = [NSString stringWithFormat:@"%@    %@",[UIUtil getStringWithDate:_pickerTime.date seperator:@"-"],[UIUtil getWeekdayWithDate:_pickerTime.date]];
    
    self.strDeptDate = strSelectedDate;
    
    [_dataArray replaceObjectAtIndex:0 withObject:[[NSMutableArray alloc]initWithObjects:@"航班日期",self.strDeptDate,nil]];
    
    [_tableView reloadData];
}

- (IBAction)closeTimePickerView:(id)sender
{
    [self showSelectView:_viewTimePicker shouldShow:NO];
}

- (IBAction)confirmCabinTypePicker:(id)sender
{
    [self showSelectView:_viewCabinTypePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:3 withObject:[[NSMutableArray alloc] initWithObjects:@"舱       位",[DATA_ENV.flightCabinLetterArray objectAtIndex:[_pickerCabinType selectedRowInComponent:0]], nil]];
    
    [_tableView reloadData];
}

- (IBAction)closeCabinTypePickerView:(id)sender
{
    [self showSelectView:_viewCabinTypePicker shouldShow:NO];
}

//设置pickerView的显示和隐藏动画
- (void) showSelectView:(UIView*)view shouldShow:(BOOL)bShow {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	if (bShow) {
		view.frame = CGRectMake(0, 156, 320, 260);
		view.alpha = 1;
	}
    else {
		view.frame = CGRectMake(0, 416, 320, 260);
		view.alpha = 0;
	}
	[UIView commitAnimations];
}

-(void)gotoSelectDeptCity:(BOOL)bl{
    isPickingCityForDept = bl;
    
    [USER_DEFAULT setObject:@"cityAndAirport" forKey:@"citys"];
    CitySearchController *citysearchController = [[CitySearchController alloc]initWithQuery:nil query:[NSDictionary dictionaryWithObjectsAndKeys:self,@"delegate",nil]];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:citysearchController];
    [citysearchController release];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//你要的翻转效果
    [self.navigationController presentModalViewController:navController  animated:YES];
    [navController release];
}

- (void)searchCityController:(CitySearchController*)controller didSelectObject:(id)object{
	if (isPickingCityForDept) {
        //self.strDeptCity = ((TTTableTextItem*)object).text;
        [_dataArray replaceObjectAtIndex:1 withObject:[[NSMutableArray alloc] initWithObjects:@"始发城市",((TTTableTextItem*)object).text, nil]];
        
	}else {
         [_dataArray replaceObjectAtIndex:2 withObject:[[NSMutableArray alloc] initWithObjects:@"目的城市",((TTTableTextItem*)object).text, nil]];
	}
   [_tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    self.title = @"里程补登";
    
    self.deptDate = [[NSDate alloc] init];
    self.strDeptDate = [NSString stringWithFormat:@"%@    %@",[UIUtil getStringWithDate:self.deptDate seperator:@"-"],[UIUtil getWeekdayWithDate:self.deptDate]];
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:
                 [[NSMutableArray alloc] initWithObjects:@"航班日期",self.strDeptDate, nil],
                 [[NSMutableArray alloc] initWithObjects:@"始发城市",@"北京", nil],
                 [[NSMutableArray alloc] initWithObjects:@"目的城市",@"上海", nil],
                 [[NSMutableArray alloc] initWithObjects:@"舱       位",@"C",nil],
                  nil];
    [self setPickerView];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNav];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_tableView release];
    [_viewAitlinePicker release];
    [_pickerAirline release];
    [_dsCompanyPicker release];
    [_dataArray release];
    [_textField1 release];
    [_contentView release];
    [_textField2 release];
    [_textField3 release];
    [_textField4 release];
    [_pickerTime release];
    [_viewTimePicker release];
    [dsTimePicker release];
    [strDeptDate release];
    [deptDate release];
    [_pickerCabinType release];
    [_viewCabinTypePicker release];
    [_dsCabinTypePicker release];
    [super dealloc];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray) {
        return [_dataArray count];
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    FrequentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[FrequentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    [cell initCellWithData:[_dataArray objectAtIndex:[indexPath row]]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
    //selectedBgView.backgroundColor =  [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0/255.0f alpha:1];;
    //cell.selectedBackgroundView = selectedBgView;
    //[selectedBgView release];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *viewSelected = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    viewSelected.backgroundColor =  COLOR_TABLE_CELL_SELECTED;
    cell.selectedBackgroundView = viewSelected;
    [viewSelected release];

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger nRow = [indexPath row];
    
    switch (nRow) 
    {
        case 0:
        {
            [self showSelectView:_viewTimePicker shouldShow:YES];
            break;
        }
        case 1:
        {
            [self gotoSelectDeptCity:YES];
            break;
        }
        case 2:
        {
            [self gotoSelectDeptCity:NO];
            break;
        }
        case 3:
        {
            [self showSelectView:_viewCabinTypePicker shouldShow:YES];
            break;
        }

        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark BaseDataRequestDelegate methods
- (void)requestDidFinishLoad:(BaseDataRequest*)request {
    //获取版本号
    //    NSString *versionStr = [UIUtil getVersionStr];
    
    if (![request isSuccess]) {
       [[request getResult] showErrorMessage];
        
        //[UIUtil showAlertMessage:@"注意" message:@"对不起，提交失败，请重新提交!"];
		return;
	}
    
	if ([request isKindOfClass:[MmacPointsDataRequest class]]) {
        
        [UIUtil showAlertMessage:@"恭喜" message:@"提交成功!谢谢!"];
        [self.navigationController popViewControllerAnimated:YES];
        
	}
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
    [_textField3 resignFirstResponder];
    [_textField4 resignFirstResponder];
    return YES;
}

@end
