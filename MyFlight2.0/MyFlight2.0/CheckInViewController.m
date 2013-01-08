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
    
    titleArray = [[NSArray alloc] initWithObjects:@"姓      名", @"证件类型", @"证件号码", @"出发城市", nil];
    
    passName = @"降枫";
    idNo = @"123456789012345678";
    depCity = @"北京";
    depCityCode = @"010";
    
    passportType = 0;
    
    UIButton *navigationLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    navigationLeftButton.frame = CGRectMake(10, 5, 30, 31);
    
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_.png"] forState:UIControlStateNormal];
    [navigationLeftButton setImage:[UIImage imageNamed:@"icon_return_click.png"] forState:UIControlStateHighlighted];
    
    [navigationLeftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navigationLeftBarItem = [[UIBarButtonItem alloc] initWithCustomView:navigationLeftButton];
    self.navigationItem.leftBarButtonItem = navigationLeftBarItem;
    [navigationLeftBarItem release];
    
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
    checkIn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [checkIn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkIn];
    
    UIButton *progressQuery = [UIButton buttonWithType:UIButtonTypeCustom];
    
    progressQuery.frame = CGRectMake(10, 300, 300, 40);
    
    [progressQuery setBackgroundImage:[UIImage imageNamed:@"white_btn.png"] forState:UIControlStateNormal];
    [progressQuery setBackgroundImage:[UIImage imageNamed:@"white_btn_click.png"] forState:UIControlStateHighlighted];
    
    [progressQuery setTitle:@"查询进度" forState:UIControlStateNormal];
    [progressQuery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    progressQuery.titleLabel.font = [UIFont systemFontOfSize:20];
    progressQuery.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [progressQuery addTarget:self action:@selector(progressQuery) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:progressQuery];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 355, 300, 200)];
    
    textView.text = @"值机小贴士：网上值机需待机场开放航班后才可办理，一般从航班起飞前一天下午14:00开始。每个机场的具体开放时间请以网站“开通城市”页面公布的时刻为准。";
    
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
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:title];
    [title release];
    
    UILabel *value;
    
    UITextField *editableValue;
    
    UIButton *invisibleButton;
    
    switch(indexPath.row)
    {
        case 0:
            editableValue = [[UITextField alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
            
            editableValue.text = passName;
            
            editableValue.font = [UIFont systemFontOfSize:16.0f];
            editableValue.textColor = FONT_COLOR_DEEP_GRAY;
            editableValue.textAlignment = NSTextAlignmentRight;
            editableValue.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:editableValue];
            [editableValue release];
            
            break;
        case 1:
            value = [[UILabel alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
                     
            if(passportType == 0)
            {
                value.text = @"身份证";
            }
            else if(passportType == 1)
            {
                value.text = @"军官证或护照";
            }
            else
            {
                value.text = @"其他";
            }
            
            value.font = [UIFont systemFontOfSize:16.0f];
            value.textColor = FONT_COLOR_DEEP_GRAY;
            value.textAlignment = NSTextAlignmentRight;
            value.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:value];
            [value release];
            
            break;
        case 2:
            editableValue = [[UITextField alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
            
            editableValue.text = idNo;
            
            editableValue.font = [UIFont systemFontOfSize:16.0f];
            editableValue.textColor = FONT_COLOR_DEEP_GRAY;
            editableValue.textAlignment = NSTextAlignmentRight;
            editableValue.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:editableValue];
            [editableValue release];
            
            break;
        case 3:
            value = [[UILabel alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
            
            value.text = depCity;
            
            value.font = [UIFont systemFontOfSize:16.0f];
            value.textColor = FONT_COLOR_DEEP_GRAY;
            value.textAlignment = NSTextAlignmentRight;
            value.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:value];
            [value release];
            
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
    [registerforCheckIn release];
    [checkforProgress release];
    
    [titleArray release];
    [passName release];
    [idNo release];
    [depCity release];
    [depCityCode release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [registerforCheckIn release];
    registerforCheckIn = nil;
    [checkforProgress release];
    checkforProgress = nil;
    [super viewDidUnload];
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) userDidInput
{
    switch(textInput.keyboardType)
    {
        case UIKeyboardTypeNumbersAndPunctuation:
            if(passportType == 0)
            {
                if(textInput.text.length != 18)
                {
                    // error : invalid idNo
                }
                else
                {
                    [idNo release];
                    idNo = [textInput.text retain];
                }
            }
            break;
        case UIKeyboardTypeNamePhonePad:
            [passName release];
            passName = [[textInput text] retain];
        default:
            break;
    }
    
    [textInput.superview removeFromSuperview];
    
    [checkInInfoTable reloadData];
}

- (void) userCancelInput
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) checkIn
{
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    
    chooseFlight.isQuery = NO;
    chooseFlight.passName = passName;
    chooseFlight.idNo = idNo;
    chooseFlight.depCity = depCityCode;
    
    [self.navigationController pushViewController:chooseFlight animated:YES];
    [chooseFlight release];
}

- (void) progressQuery
{
    ChooseFlightViewController *chooseFlight = [[ChooseFlightViewController alloc] init];
    
    chooseFlight.isQuery = YES;
    chooseFlight.passName = passName;
    chooseFlight.idNo = idNo;
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
            break;
        case 1:
            passportType = 1;
            break;
        case 2:
            passportType = 2;
            break;
        default:
            break;
    }
    
    [checkInInfoTable reloadData];
}

/*- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseAirPortViewController *chooseAp;
    UIActionSheet *actionSheet;
    UIButton *exitButton;
    
    switch (indexPath.row)
    {
        case 0:
            exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            exitButton.frame = [UIScreen mainScreen].bounds;
            exitButton.layer.backgroundColor = [[UIColor clearColor] CGColor];
            exitButton.layer.borderWidth = 0.0f;
            
            [exitButton addTarget:exitButton action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchDown];
            
            textInput = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 500 ? 203:291, 320, 40)];
            
            textInput.keyboardType = UIKeyboardTypeNamePhonePad;
            textInput.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
            textInput.textAlignment = UITextAlignmentCenter;
            textInput.textColor = [UIColor blueColor];
            textInput.font = [UIFont systemFontOfSize:40.0f];
            
            textInput.backgroundColor = [UIColor yellowColor];
            
            [textInput addTarget:self action:@selector(userDidInput) forControlEvents:UIControlEventEditingDidEndOnExit];
            
            [exitButton addSubview:textInput];
            [textInput release];
            
            [self.view addSubview:exitButton];
            
            [textInput becomeFirstResponder];
            
            break;
        case 1:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择您的证件类型"
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"身份证", @"军官证或护照", @"其他", nil];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            
            [actionSheet showInView:self.view];
            [actionSheet release];
            
            break;
        case 2:
            exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            exitButton.frame = [UIScreen mainScreen].bounds;
            exitButton.layer.backgroundColor = [[UIColor clearColor] CGColor];
            exitButton.layer.borderWidth = 0.0f;
            
            [exitButton addTarget:exitButton action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchDown];
            
            textInput = [[UITextField alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height < 500 ? 160:248, 320, 40)];
            
            textInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textInput.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
            textInput.textAlignment = UITextAlignmentCenter;
            textInput.textColor = [UIColor blueColor];
            textInput.font = [UIFont systemFontOfSize:20.0f];
            
            textInput.backgroundColor = [UIColor yellowColor];
            
            [textInput addTarget:self action:@selector(userDidInput) forControlEvents:UIControlEventEditingDidEndOnExit];
            
            [exitButton addSubview:textInput];
            [textInput release];
            
            [self.view addSubview:exitButton];
            
            [textInput becomeFirstResponder];
            
            break;
        case 3:
            chooseAp = [[ChooseAirPortViewController alloc] init];
            
            chooseAp.delegate = self;
            
            [self.navigationController pushViewController:chooseAp animated:YES];
            [chooseAp release];
            
            break;
        default:
            break;
    }
}*/

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPort
{
    depCity = airPort.cityName;
    depCityCode = airPort.cityName;
    
    [checkInInfoTable reloadData];
}

@end
