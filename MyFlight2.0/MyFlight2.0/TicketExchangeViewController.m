//
//  TicketExchangeViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//

#import "TicketExchangeViewController.h"
#import "FrequentTableViewCell.h"
#import "CitySearchController.h"
#import "DataEnvironment.h"
#import "ComputeViewController.h"
#import "UIUtil.h"
#import "CityAirportManager.h"
#import "TicketExchangeResultViewController.h"
#import "ComponentsFactory.h"


@implementation TicketExchangeViewController
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
    }
    
    return self;
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

#pragma mark -IBActon
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
    
	NSString *title = @"机票兑换计算";
	UILabel *titleLbl = [ComponentsFactory navigationBarTitleLabelWithTitle:title];
	[navBGView addSubview:titleLbl];
	
	UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navBGView];
	[self.navigationItem setLeftBarButtonItem:navLeft animated:YES];
    [navLeft release];
	[navBGView release];
    [title release];
}

-(IBAction)computeAction:(id)sender
{
    
    if ([self doVerify])
    {
        NSString *strDepCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:6] objectAtIndex:1]];
        NSString *strArrCity = [[CityAirportManager sharedManager] getAirportCodeByCity:[[_dataArray objectAtIndex:7] objectAtIndex:1]];
        
        NSString *strFlightSeg = [[NSString alloc] initWithFormat:@"%@%@",strDepCity,strArrCity];
        NSString *strSegType = [[_dataArray objectAtIndex:5] objectAtIndex:1];
        NSString *strPassengerType = [[_dataArray objectAtIndex:4] objectAtIndex:1];
        NSString *strQueryType = [[_dataArray objectAtIndex:2] objectAtIndex:1];
        
        //send 常旅客查询
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [DATA_ENV getFrequentFlyerSavedUsername],@"cardNo",
                              [UIUtil getStringWithDate:self.deptDate seperator:@""], @"flightDate",
                              strFlightSeg,@"flightSeg",
                              self.textFieldCabinName.text,@"flightNo",
                              [[_dataArray objectAtIndex:1] objectAtIndex:1],@"cabin",
                              [DATA_ENV getSegTypeByKey:strSegType],@"segType",
                              [DATA_ENV getPassengerTypeByKey:strPassengerType],@"passengerType",
                              [DATA_ENV getQueryTypeByKey:strQueryType],@"queryType",
                              nil];
        
        
        [QueryExchangePointsDataRequest requestWithDelegate:self
                                         withParameters:data
                                      withIndicatorView:self.view];
        
        [strFlightSeg release];
    }
    
}

- (IBAction)confirmSegTypePicker:(id)sender
{
    
    [self showSelectView:_viewSegTypePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:5 withObject:[[NSMutableArray alloc] initWithObjects:@"行程类型",[DATA_ENV.segTypeArray objectAtIndex:[_pickerSegType selectedRowInComponent:0]], nil]];
    
    [_tableView reloadData];
}

- (IBAction)closeSegTypePickerView:(id)sender
{
    [self showSelectView:_viewSegTypePicker shouldShow:NO];
}

- (IBAction)confirmPassengerTypePicker:(id)sender
{
    [self showSelectView:_viewPassengerTypePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:4 withObject:[[NSMutableArray alloc] initWithObjects:@"旅客类型",[DATA_ENV.passengerTypeArray objectAtIndex:[_pickerPassengerType selectedRowInComponent:0]], nil]];
    
    [_tableView reloadData];
}

- (IBAction)closePassengerTypePickerView:(id)sender
{
    [self showSelectView:_viewPassengerTypePicker shouldShow:NO];
}

- (IBAction)confirmQueryTypePicker:(id)sender
{
    [self showSelectView:_viewQueryTypePicker shouldShow:NO];
    [_dataArray replaceObjectAtIndex:2 withObject:[[NSMutableArray alloc] initWithObjects:@"查询类型",[DATA_ENV.queryTypeArray objectAtIndex:[_pickerQueryType selectedRowInComponent:0]], nil]];
    
    NSString *strQueryType = [DATA_ENV.queryTypeArray objectAtIndex:[_pickerQueryType selectedRowInComponent:0]];
    
    /*
    if([strQueryType isEqualToString:@"免票"])
    {
        //查询类型为免票舱位不可选
        isFreeTickeQuery = YES;
        [_dataArray replaceObjectAtIndex:1 withObject:[[NSMutableArray alloc] initWithObjects:@"舱       位",@"", nil]];
    }else 
    {
       isFreeTickeQuery = NO; 
        [_dataArray replaceObjectAtIndex:1 withObject:[[NSMutableArray alloc] initWithObjects:@"舱       位",@"C", nil]];
    }
     */
    
    [_tableView reloadData];
}

- (IBAction)closeQueryTypePickerView:(id)sender
{
     [self showSelectView:_viewQueryTypePicker shouldShow:NO];
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
    
    [_dataArray replaceObjectAtIndex:3 withObject:[[NSMutableArray alloc]initWithObjects:@"航班日期",self.strDeptDate,nil]];
    
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
    _dsCompanyPicker = [[CustomPickerDataSource2 alloc] init];
    _pickerAirline.delegate = _dsCompanyPicker;
    _pickerAirline.dataSource = _dsCompanyPicker;
    _dsCompanyPicker.customPickerArray = DATA_ENV.flightCompanyArray;
    [_viewAitlinePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewAitlinePicker];
    
    //行程类型
    _dsSegTypePicker = [[CustomPickerDataSource2 alloc]init];
    _pickerSegType.delegate = _dsSegTypePicker;
    _pickerSegType.dataSource = _dsSegTypePicker;
    _dsSegTypePicker.customPickerArray = DATA_ENV.segTypeArray;
    [_viewSegTypePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewSegTypePicker];
    
    //旅客类型
    _dsPassengerTypePicker = [[CustomPickerDataSource2 alloc]init];
    _pickerPassengerType.delegate = _dsPassengerTypePicker;
    _pickerPassengerType.dataSource = _dsPassengerTypePicker;
    _dsPassengerTypePicker.customPickerArray = DATA_ENV.passengerTypeArray;
    [_viewPassengerTypePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewPassengerTypePicker];
    
    //查询类型
    _dsQueryTypePicker = [[CustomPickerDataSource2 alloc]init];
    _pickerQueryType.delegate = _dsQueryTypePicker;
    _pickerQueryType.dataSource = _dsQueryTypePicker;
    _dsQueryTypePicker.customPickerArray = DATA_ENV.queryTypeArray;
    [_viewQueryTypePicker setFrame:CGRectMake(0, 416, 320, 260)];
    [self.view addSubview:_viewQueryTypePicker];
    
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
        [_dataArray replaceObjectAtIndex:6 withObject:[[NSMutableArray alloc] initWithObjects:@"始发城市",((TTTableTextItem*)object).text, nil]];
        
	}else {
         [_dataArray replaceObjectAtIndex:7 withObject:[[NSMutableArray alloc] initWithObjects:@"目的城市",((TTTableTextItem*)object).text, nil]];
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
//    self.title = @"机票兑换计算";
    
    self.deptDate = [[NSDate alloc] init];
    self.strDeptDate = [NSString stringWithFormat:@"%@    %@",[UIUtil getStringWithDate:self.deptDate seperator:@"-"],[UIUtil getWeekdayWithDate:self.deptDate]];
    
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:
                    [[NSMutableArray alloc] initWithObjects:@"航  班  号",@"", nil],
                    [[NSMutableArray alloc] initWithObjects:@"舱       位",@"C", nil],
                    [[NSMutableArray alloc] initWithObjects:@"查询类型",@"免票", nil],
                    [[NSMutableArray alloc] initWithObjects:@"航班日期",self.strDeptDate, nil],
                    [[NSMutableArray alloc] initWithObjects:@"旅客类型",@"成人", nil],
                    [[NSMutableArray alloc] initWithObjects:@"行程类型",@"单程", nil],
                    [[NSMutableArray alloc] initWithObjects:@"始发城市",@"北京", nil],
                    [[NSMutableArray alloc] initWithObjects:@"目的城市",@"上海", nil],
                    nil];
    [self setPickerView];
    [super viewDidLoad];
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
    [_pickerSegType release];
    [_pickerPassengerType release];
    [_pickerQueryType release];
    [_pickerCabinType release];
    [_dsSegTypePicker release];
    [_dsPassengerTypePicker release];
    [_dsQueryTypePicker release];
    [_dsCabinTypePicker release];
    [_viewSegTypePicker release];
    [_viewPassengerTypePicker release];
    [_viewQueryTypePicker release];
    [_viewCabinTypePicker release];
    [textFieldCabinName release];
    [dsTimePicker release];
    [_pickerTime release];
    [_viewTimePicker release];
    [deptDate release];
    [strDeptDate release];
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
        
        if(nil == self.textFieldCabinName)
        {
           textFieldCabinName = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, 210, 40)];
            //textFieldCabin.borderStyle = UITextBorderStyleRoundedRect;
            textFieldCabinName.returnKeyType = UIReturnKeyDone;
            textFieldCabinName.delegate = self;
            textFieldCabinName.clearButtonMode = UITextFieldViewModeWhileEditing;
            textFieldCabinName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textFieldCabinName.placeholder = @"航班号 如:HU3333"; 
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
           // selectedBgView.backgroundColor = [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0/255.0f alpha:1];;
           // cell.selectedBackgroundView = selectedBgView;
            //[selectedBgView release];
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
            /*
            if(YES == isFreeTickeQuery)
            {
                [UIUtil showAlertMessage:@"注意" message:@"查询类型为免票时，舱位不可选!"];
                break;
            }
             */
            [self showSelectView:_viewCabinTypePicker shouldShow:YES];
            break;
        }
        case 2:
        {
            [self showSelectView:_viewQueryTypePicker shouldShow:YES];
            break;
        }
        case 3:
        {
            _pickerTime.minimumDate = [[NSDate alloc] init];
            [self showSelectView:_viewTimePicker shouldShow:YES];
            break;
        }
        case 4:
        {
            [self showSelectView:_viewPassengerTypePicker shouldShow:YES];
            break;
        }
        case 5:
        {
            [self showSelectView:_viewSegTypePicker shouldShow:YES];
            break;
        }
        case 6:
        {
            [self gotoSelectDeptCity:YES];
            break;
        }
        case 7:
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
        
    [_dataArray replaceObjectAtIndex:0 withObject:[[NSMutableArray alloc]initWithObjects:
                                                   @"航班号",textField.text,nil]];
        
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
    
	if ([request isKindOfClass:[QueryExchangePointsDataRequest class]]) {
        
        NSMutableDictionary *dataDic = [request.resultDic objectForKey:@"frequentFlyer"];
        //取是否可兑换标志位
        BOOL ifExchange = (BOOL)[dataDic objectForKey:@"exchangeable"];
        NSString *strQueryType = [[dataDic objectForKey:@"queryType"] stringValue];
        if(!ifExchange)
        {
            //不可兑换就显示不可兑换原因
            NSString *strErrInfo = [dataDic objectForKey:@"remark"];
            [UIUtil showAlertMessage:@"注意" message:strErrInfo];
            return;
        }
        NSArray *ticketInfoArray = (NSArray*)[dataDic objectForKey:@"segments"];

        NSMutableArray *arr = nil;
        
        NSString *strTilte = nil;
        NSString *strKey = nil;
        
        if([strQueryType isEqualToString:@"1"])
        {
            strTilte = [[NSString alloc] initWithString:@"奖励机票表"];
            strKey = [[NSString alloc] initWithString:@"cabin"];
        }else
        {
            strTilte = [[NSString alloc] initWithString:@"奖励升舱表"];
            strKey = [[NSString alloc] initWithString:@"newCabin"];
        }
        
        
        for(NSDictionary *dic in ticketInfoArray)
        {
            NSArray *cabinArray = [dic objectForKey:strKey]; 
            NSArray *pointsArray = [dic objectForKey:@"needPoints"];
           
            NSInteger nCount = [cabinArray count];
            arr = [[NSMutableArray alloc] initWithCapacity:nCount];
            
            for(int i=0; i<nCount; i++)
            {
                NSString *strCabin = [cabinArray objectAtIndex:i];
                NSString *strMile =  [[pointsArray objectAtIndex:i] stringValue]; 
                [arr insertObject:[[NSMutableArray alloc] initWithObjects:strCabin,strMile,nil] atIndex:i];
            }
            break;
        }
        /*
        ComputeViewController *computeViewController = [[ComputeViewController alloc] initWithNibName:@"ComputeViewController" bundle:nil withData:arr];
        [self.navigationController pushViewController:computeViewController animated:YES];
         [computeViewController release];
         */
        
        TicketExchangeResultViewController *ticketResultView = [[TicketExchangeResultViewController alloc] initWithNibName:@"TicketExchangeResultViewController" bundle:nil withData:arr withTitle:strTilte];
        [self.navigationController pushViewController:ticketResultView animated:YES];
        
        if(nil != arr)
            [arr release];
        if(nil != strTilte)
            [strTilte release];
        
        if(nil != strKey)
            [strKey release];
        
        [ticketResultView release];
        
	}
}


@end
