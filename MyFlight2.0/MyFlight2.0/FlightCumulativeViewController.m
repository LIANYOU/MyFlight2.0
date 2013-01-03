//
//  FlightCumulativeViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//

#import "FlightCumulativeViewController.h"
#import "FrequentTableViewCell.h"
#import "CitySearchController.h"
#import "DataEnvironment.h"
#import "ComputeViewController.h"
#import "UIUtil.h"
#import "DataEnvironment.h"
#import "CityAirportManager.h"
#import "FlightCumulativeResultViewController.h"
#import "ComponentsFactory.h"

@implementation FlightCumulativeViewController
@synthesize textFieldCabinName;
@synthesize deptDate;
@synthesize strDeptDate;

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
//        
    }
    return self;
}

#pragma mark -IBAction
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
    
	NSString *title = @"飞行累积计算";
	UILabel *titleLbl = [ComponentsFactory navigationBarTitleLabelWithTitle:title];
	[navBGView addSubview:titleLbl];
	
	UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navBGView];
	[self.navigationItem setLeftBarButtonItem:navLeft animated:YES];
    [navLeft release];
	[navBGView release];
    [title release];
}


-(BOOL)doVerify{
    
    NSString *airCode = [self.textFieldCabinName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([airCode length] == 0) {
        [UIUtil showAlertMessage:@"计算失败" message:@"航班号不能为空!"];
        self.textFieldCabinName.text = @"";
        [self.textFieldCabinName becomeFirstResponder];
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

-(IBAction)computeAction:(id)sender
{
    if ([self doVerify])
    {
        NSString *strDepCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:3] objectAtIndex:1]];
        NSString *strArrCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:4] objectAtIndex:1]];
        
        NSString *strFlightSeg = [[NSString alloc] initWithFormat:@"%@%@",strDepCity,strArrCity];
        
        //send 常旅客查询
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [DATA_ENV getFrequentFlyerSavedUsername],@"cardNo",
                              [UIUtil getStringWithDate:self.deptDate seperator:@""], @"flightDate",
                              self.textFieldCabinName.text,@"flightNo",
                              [[_dataArray objectAtIndex:1] objectAtIndex:1],@"cabin",
                              strFlightSeg,@"flightSeg",
                              nil];
        
        
        [GetPointstoTicketDataRequest requestWithDelegate:self
                                             withParameters:data
                                          withIndicatorView:self.view];
        [strFlightSeg release];
    }
}

- (IBAction)confirmCabinTypePicker:(id)sender
{
    [self showSelectView:_viewCabinTypePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:1 withObject:[[NSMutableArray alloc] initWithObjects:@"舱       位",[DATA_ENV.flightCabinLetterArray objectAtIndex:[_pickerCabinType selectedRowInComponent:0]], nil]];
    
    [_tableView reloadData];
}

- (IBAction)closeCabinTypePickerView:(id)sender
{
    [self showSelectView:_viewCabinTypePicker shouldShow:NO];
}

- (IBAction)confirmTimePicker:(id)sender
{
    [self showSelectView:_viewTimePicker shouldShow:NO];
    
    NSString *strSelectedDate = [NSString stringWithFormat:@"%@    %@",[UIUtil getStringWithDate:_pickerTime.date seperator:@"-"],[UIUtil getWeekdayWithDate:_pickerTime.date]];
    
    self.strDeptDate = strSelectedDate;
    
    [_dataArray replaceObjectAtIndex:2 withObject:[[NSMutableArray alloc]initWithObjects:@"航班日期",self.strDeptDate,nil]];
    
    [_tableView reloadData];
}

- (IBAction)closeTimePickerView:(id)sender
{
    [self showSelectView:_viewTimePicker shouldShow:NO];
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
    /*
    _dsCompanyPicker = [[CustomPickerDataSource2 alloc] init];
    _pickerAirline.delegate = _dsCompanyPicker;
    _pickerAirline.dataSource = _dsCompanyPicker;
    _dsCompanyPicker.customPickerArray = DATA_ENV.flightCompanyArray;
    
    [_viewAitlinePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewAitlinePicker];
     */
    
    //舱位
    _dsCabinTypePicker = [[CustomPickerDataSource2 alloc]init];
    _pickerCabinType.delegate = _dsCabinTypePicker;
    _pickerCabinType.dataSource = _dsCabinTypePicker;
    _dsCabinTypePicker.customPickerArray = DATA_ENV.flightCabinLetterArray;
    [_viewCabinTypePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewCabinTypePicker];
    
    //日期 
    [_viewTimePicker setFrame:CGRectMake(0, 416, 320, 260)];
    _pickerTime.date = [[NSDate alloc] init];
    [self.view addSubview:_viewTimePicker];
    
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
        [_dataArray replaceObjectAtIndex:3 withObject:[[NSMutableArray alloc] initWithObjects:@"始发城市",((TTTableTextItem*)object).text, nil]];
        
	}else {
         [_dataArray replaceObjectAtIndex:4 withObject:[[NSMutableArray alloc] initWithObjects:@"目的城市",((TTTableTextItem*)object).text, nil]];
	}
   [_tableView reloadData];
}

-(IBAction)telAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:_telLabel.text]]];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    self.title = @"飞行累积计算";
    
    self.deptDate = [[NSDate alloc] init];
    self.strDeptDate = [NSString stringWithFormat:@"%@    %@",[UIUtil getStringWithDate:self.deptDate seperator:@"-"],[UIUtil getWeekdayWithDate:self.deptDate]];

    _dataArray = [[NSMutableArray alloc] initWithObjects:
                  [[NSMutableArray alloc] initWithObjects:@"航  班  号",@"", nil],
                  [[NSMutableArray alloc] initWithObjects:@"舱       位",@"C", nil],
                  [[NSMutableArray alloc] initWithObjects:@"航班日期",self.strDeptDate, nil],
                  [[NSMutableArray alloc] initWithObjects:@"始发城市",@"北京", nil],
                  [[NSMutableArray alloc] initWithObjects:@"目的城市",@"上海", nil],
                  nil];
    
    [self setPickerView];
    NSMutableArray *_arr = [[NSMutableArray alloc] initWithObjects:
                            [[NSMutableArray alloc] initWithObjects:@"头等舱",@"1234000",nil],
                            [[NSMutableArray alloc] initWithObjects:@"头等舱",@"1234000",nil],
                            [[NSMutableArray alloc] initWithObjects:@"头等舱",@"1234000",nil],
                            [[NSMutableArray alloc] initWithObjects:@"头等舱",@"1234000",nil],
                            [[NSMutableArray alloc] initWithObjects:@"头等舱",@"1234000",nil]
                            ,nil];
   // [self showGrid:_arr];
    [_arr release];
    [super viewDidLoad];
}
-(void) showGrid:(NSMutableArray*)_dataList
{
    UIView  * gridView=[self.view viewWithTag:100];
    if(gridView){
        [gridView removeFromSuperview];
    }
    DataGridComponentDataSource *ds = [[DataGridComponentDataSource alloc] init];
	ds.columnWidth = [NSArray arrayWithObjects:@"140", @"140",nil];
	ds.titles = [NSMutableArray arrayWithObjects: @"舱位",@"累积的金鹏里程数",nil];
	ds.data=_dataList;
	DataGridComponent *grid = [[DataGridComponent alloc] initWithFrame:CGRectMake(21, 190, 281, 180) data:ds delegate:self];
	grid.tag=100;
    [ds release];
	[_contentView addSubview:grid];
    
	[grid release];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isFirstInit) {
        isFirstInit = YES;
    }
    [super viewDidAppear:animated];
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
    [_telLabel release];
    [_contentView release];
    [_pickerTime release];
    [_viewTimePicker release];
    [dsTimePicker release];
    [textFieldCabinName release];
    [deptDate release];
    [strDeptDate release];
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
    
     NSInteger nRow = [indexPath row];
    if(0 == nRow)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(nil == cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
            btn.titleLabel.text = @"";
            [cell.contentView addSubview:btn];
            [btn release];
        }
        
        cell.textLabel.text = [[_dataArray objectAtIndex:nRow] objectAtIndex:0];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        /*
         UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
         selectedBgView.backgroundColor = [UIColor clearColor];;
         cell.selectedBackgroundView = selectedBgView;
         [selectedBgView release];
         */
        
        if(self.textFieldCabinName==nil){
            self.textFieldCabinName = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, 210, 40)];
            textFieldCabinName.placeholder = @"航班号 如:HU3333";
            textFieldCabinName.returnKeyType = UIReturnKeyDone;
            textFieldCabinName.delegate = self;
            textFieldCabinName.clearButtonMode = UITextFieldViewModeWhileEditing;
            textFieldCabinName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [cell.contentView addSubview:textFieldCabinName]; 
        }
        
        return cell;
    }else
    {
        FrequentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[FrequentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           // UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
           // selectedBgView.backgroundColor =  [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0/255.0f alpha:1];
           // cell.selectedBackgroundView = selectedBgView;
           // [selectedBgView release]; 
            cell.contentView.backgroundColor = [UIColor clearColor];
            UIView *viewSelected = [[UIView alloc] initWithFrame:cell.contentView.bounds];
            viewSelected.backgroundColor =  COLOR_TABLE_CELL_SELECTED;
            cell.selectedBackgroundView = viewSelected;
            [viewSelected release];
        }        
        [cell initCellWithData:[_dataArray objectAtIndex:nRow]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger nRow = [indexPath row];
    if(0 == nRow) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    switch (nRow) 
    {
        case 1:
        {
            [self showSelectView:_viewCabinTypePicker shouldShow:YES];
            break;
        }
        case 2:
        {
            _pickerTime.minimumDate = [[NSDate alloc] init];
            [self showSelectView:_viewTimePicker shouldShow:YES];
            break;
        }
        case 3:
        {
            [self gotoSelectDeptCity:YES];
            break;
        }
        case 4:
        {
            [self gotoSelectDeptCity:NO];
            break;
        }
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.textFieldCabinName) {
        [self.textFieldCabinName resignFirstResponder];
    }
    return YES;
}

#pragma mark BaseDataRequestDelegate methods
- (void)requestDidFinishLoad:(BaseDataRequest*)request {
    //获取版本号
    //    NSString *versionStr = [UIUtil getVersionStr];
    
    if (![request isSuccess]) {
        [[request getResult] showErrorMessage];
		return;
	}
    
	if ([request isKindOfClass:[GetPointstoTicketDataRequest class]]) {
       NSMutableDictionary *dataDic = [request.resultDic objectForKey:@"frequentFlyer"];
       /*
        NSArray *accumulatePointsArray = [[request.resultDic objectForKey:@"frequentFlyer"] objectForKey:@"accumulatePoints"];
       NSString *accumulatePoints = [accumulatePointsArray objectAtIndex:0];
      NSString *cabin = [[request.resultDic objectForKey:@"frequentFlyer"] objectForKey:@"cabin"];
        */
       FlightCumulativeResultViewController *resultView = [[FlightCumulativeResultViewController alloc] initWithNibName:@"FlightCumulativeResultViewController" bundle:nil];
        
        [resultView setData:dataDic];
        
        [self.navigationController pushViewController:resultView animated:YES];

        [resultView release];
        
	}
}

@end
