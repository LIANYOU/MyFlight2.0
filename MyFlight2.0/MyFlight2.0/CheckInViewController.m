//
//  CheckInViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController

- (id)initWithNibNameAndChoice:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"海南航空值机";
    
    titleArray = [[NSArray alloc] initWithObjects:@"姓      名", @"证件类型", @"证件号码", @"出发城市", nil];
    
    passportType = 0;
    depCity = @"北京";
    depCityCode = @"010";
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
    
    label.text = @"乘机人信息";
    label.textColor = FONT_COLOR_GRAY;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
    [label release];
    
    checkInInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 200) style:UITableViewStylePlain];
    
    checkInInfoTable.delegate = self;
    checkInInfoTable.dataSource = self;
    checkInInfoTable.scrollEnabled = NO;
    checkInInfoTable.allowsSelection = NO;
    
    checkInInfoTable.rowHeight = 50.0f;
    checkInInfoTable.backgroundColor = FOREGROUND_COLOR;
    checkInInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    checkInInfoTable.layer.borderColor = [BORDER_COLOR CGColor];
    checkInInfoTable.layer.borderWidth = 1.0;
    checkInInfoTable.layer.cornerRadius = 10.0f;
    
    [self.view addSubview:checkInInfoTable];
    [checkInInfoTable release];
    
    registerforCheckIn.backgroundColor = [UIColor orangeColor];
    
    UIButton *checkIn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    checkIn.frame = CGRectMake(10, 245, 300, 40);
    
    [checkIn setBackgroundImage:[UIImage imageNamed:@"orange_btn.png"] forState:UIControlStateNormal];
    [checkIn setBackgroundImage:[UIImage imageNamed:@"orange_btn_click.png"] forState:UIControlStateHighlighted];
    
    [checkIn setTitle:@"办理值机" forState:UIControlStateNormal];
    [checkIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    checkIn.titleLabel.font = [UIFont systemFontOfSize:20];
    checkIn.titleLabel.textAlignment = UITextAlignmentCenter;
    
    [checkIn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkIn];
    
    UIButton *progressQuery = [UIButton buttonWithType:UIButtonTypeCustom];
    
    progressQuery.frame = CGRectMake(10, 300, 300, 40);
    
    [progressQuery setBackgroundImage:[UIImage imageNamed:@"white_btn.png"] forState:UIControlStateNormal];
    [progressQuery setBackgroundImage:[UIImage imageNamed:@"white_btn_click.png"] forState:UIControlStateHighlighted];
    
    [progressQuery setTitle:@"查询进度" forState:UIControlStateNormal];
    [progressQuery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    progressQuery.titleLabel.font = [UIFont systemFontOfSize:20];
    progressQuery.titleLabel.textAlignment = UITextAlignmentCenter;
    
    [progressQuery addTarget:self action:@selector(progressQuery) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:progressQuery];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 350, 300, 140)];
    
    textView.text = @"值机小贴士：网上值机需待机场开放航班后才可办理，一般从航班起飞前一天下午14:00开始。每个机场的具体开放时间请以网站“开通城市”页面公布的时刻为准。";
    
    textView.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.height < 500 ? 10.0f:12.0f];
    
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:textView];
    [textView release];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    else
    {
        for(UIView *view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    UIView *line;
    
    if(indexPath.row != 0)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
        
        line.backgroundColor = [UIColor whiteColor];
        
        [cell addSubview:line];
        [line release];
    }
    
    if(indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.rowHeight - 1, tableView.frame.size.width, 1)];
        
        line.backgroundColor = LINE_COLOR;
        
        [cell addSubview:line];
        [line release];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 64, 16)];
    
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:16.0f];
    title.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
    title.textAlignment = UITextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:title];
    [title release];
    
    switch(indexPath.row)
    {
        case 0:
            passName = [[UITextField alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
            
            passName.font = [UIFont systemFontOfSize:16.0f];
            passName.textColor = FONT_COLOR_DEEP_GRAY;
            passName.textAlignment = UITextAlignmentRight;
            passName.backgroundColor = [UIColor clearColor];
            passName.keyboardType = UIKeyboardTypeNamePhonePad;
            
            passName.delegate = self;
            
            [cell addSubview:passName];
            [passName release];
            
            break;
        case 1:
            changeType = [UIButton buttonWithType:UIButtonTypeCustom];
            
            changeType.frame = CGRectMake(74, 17, 194, 16);
            changeType.backgroundColor = [UIColor clearColor];
            
            [changeType setContentEdgeInsets:UIEdgeInsetsZero];
            
            [changeType addTarget:self action:@selector(choosePassportType) forControlEvents:UIControlEventTouchUpInside];
            
            typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 194, 16)];
            
            if(passportType == 0)
            {
                typeLabel.text = @"身份证";
            }
            else if(passportType == 1)
            {
                typeLabel.text = @"军官证或护照";
            }
            else
            {
                typeLabel.text = @"其他";
            }
            
            typeLabel.font = [UIFont systemFontOfSize:16.0f];
            typeLabel.textColor = FONT_COLOR_DEEP_GRAY;
            typeLabel.textAlignment = UITextAlignmentRight;
            typeLabel.backgroundColor = [UIColor clearColor];
            
            [changeType addSubview:typeLabel];
            [typeLabel release];
            
            [cell addSubview:changeType];
            
            break;
        case 2:
            idNo = [[UITextField alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
            
            idNo.font = [UIFont systemFontOfSize:16.0f];
            idNo.textColor = FONT_COLOR_DEEP_GRAY;
            idNo.textAlignment = UITextAlignmentRight;
            idNo.backgroundColor = [UIColor clearColor];
            idNo.keyboardType = UIKeyboardTypeNumberPad;
            
            idNo.delegate = self;
            
            [cell addSubview:idNo];
            [idNo release];
            
            break;
        case 3:
            changeCity = [UIButton buttonWithType:UIButtonTypeCustom];
            
            changeCity.frame = CGRectMake(74, 17, 194, 16);
            changeCity.backgroundColor = [UIColor clearColor];
            
            [changeCity setContentEdgeInsets:UIEdgeInsetsZero];
            
            [changeCity addTarget:self action:@selector(chooseAirport) forControlEvents:UIControlEventTouchUpInside];
            
            cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 194, 16)];
            
            cityLabel.text = depCity;
            
            cityLabel.font = [UIFont systemFontOfSize:16.0f];
            cityLabel.textColor = FONT_COLOR_DEEP_GRAY;
            cityLabel.textAlignment = UITextAlignmentRight;
            cityLabel.backgroundColor = [UIColor clearColor];
            
            [changeCity addSubview:cityLabel];
            [cityLabel release];
            
            [cell addSubview:changeCity];
            
            break;
        default:
            break;
    }
    
    if(indexPath.row == 1 || indexPath.row == 3)
    {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
        arrow.frame = CGRectMake(278, 15, 12, 16);
        [cell addSubview:arrow];
        [arrow release];
    }
    
    cell.backgroundColor = FOREGROUND_COLOR;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [titleArray release];
    [depCity release];
    [depCityCode release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [responseDictionary release];
    
    [super viewDidUnload];
}

- (BOOL) validateInput
{
    if([[passName.text stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]] isEqualToString:passName.text])
    {
        switch(passportType)
        {
            case 0:
                if([idNo.text length] != 18)
                {
                    alertMessage = [[UIAlertView alloc] initWithTitle:@"" message:@"您输入的证件号码格式有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertMessage show];
                    [alertMessage release];
                    return NO;
                }
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
    }
    else
    {
        alertMessage = [[UIAlertView alloc] initWithTitle:@"" message:@"您输入的姓名中包含非法字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertMessage show];
        [alertMessage release];
        return NO;
    }
    
    return YES;
}

- (void) checkIn
{
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    
    chooseFlight.isQuery = NO;
    chooseFlight.passName = passName.text;
    chooseFlight.idNo = idNo.text;
    chooseFlight.depCity = depCityCode;
    
    [self.navigationController pushViewController:chooseFlight animated:YES];
    [chooseFlight release];
}

- (void) progressQuery
{
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    
    chooseFlight.isQuery = YES;
    chooseFlight.passName = passName.text;
    chooseFlight.idNo = idNo.text;
    chooseFlight.depCity = depCityCode;
    
    [self.navigationController pushViewController:chooseFlight animated:YES];
    [chooseFlight release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex)
    {
        case 0:
            passportType = 0;
            typeLabel.text = @"身份证";
            break;
        case 1:
            passportType = 1;
            typeLabel.text = @"军官证或护照";
            break;
        case 2:
            passportType = 2;
            typeLabel.text = @"其他";
            break;
        default:
            break;
    }
}

- (void) choosePassportType
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择您的证件类型"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"身份证", @"军官证或护照", @"其他", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void) chooseAirport
{
    ChooseAirPortViewController *chooseAp = [[ChooseAirPortViewController alloc] init];
    
    chooseAp.delegate = self;
    
    [self.navigationController pushViewController:chooseAp animated:YES];
    [chooseAp release];
}

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPort
{
    depCity = airPort.cityName;
    depCityCode = airPort.cityName;
    
    cityLabel.text = depCity;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    invisibleButton.frame = self.view.frame;
    
    [invisibleButton addTarget:textField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invisibleButton];
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [invisibleButton removeFromSuperview];
    
    return YES;
}

@end
