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
    
    checkInInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 200) style:UITableViewStylePlain];
    
    checkInInfoTable.delegate = self;
    checkInInfoTable.dataSource = self;
    checkInInfoTable.scrollEnabled = NO;
    checkInInfoTable.rowHeight = 50.0f;
    checkInInfoTable.layer.borderColor = [[UIColor grayColor] CGColor];
    checkInInfoTable.layer.borderWidth = 1.0;
    checkInInfoTable.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:checkInInfoTable];
    [checkInInfoTable release];
    
    registerforCheckIn.backgroundColor = [UIColor orangeColor];
    
    UIButton *checkIn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    checkIn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 320:400, 300, 40);
    
    checkIn.backgroundColor = [UIColor orangeColor];
    checkIn.layer.borderColor = [[UIColor grayColor] CGColor];
    checkIn.layer.borderWidth = 1.0;
    checkIn.layer.cornerRadius = 5.0;
    
    [checkIn setTitle:@"办理值机" forState:UIControlStateNormal];
    [checkIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkIn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    checkIn.titleLabel.font = [UIFont systemFontOfSize:20];
    checkIn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [checkIn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkIn];
    
    UIButton *progressQuery = [UIButton buttonWithType:UIButtonTypeCustom];
    
    progressQuery.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height < 500 ? 370:450, 300, 40);
    
    progressQuery.backgroundColor = [UIColor orangeColor];
    progressQuery.layer.borderColor = [[UIColor grayColor] CGColor];
    progressQuery.layer.borderWidth = 1.0;
    progressQuery.layer.cornerRadius = 5.0;
    
    [progressQuery setTitle:@"查询进度" forState:UIControlStateNormal];
    [progressQuery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [progressQuery setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    progressQuery.titleLabel.font = [UIFont systemFontOfSize:20];
    progressQuery.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [progressQuery addTarget:self action:@selector(progressQuery) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:progressQuery];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
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
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    else
    {
        for(UIView *view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 64, 16)];
    
    title.text = [titleArray objectAtIndex:indexPath.row];
    title.font = [UIFont systemFontOfSize:16.0f];
    title.textColor = [UIColor colorWithRed:0.1f green:0.4f blue:0.8f alpha:1.0f];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:title];
    [title release];
    
    UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(74, 17, 194, 16)];
    
    switch (indexPath.row) {
        case 0:
            value.text = passName;
            break;
        case 1:
            if(passportType == 0)
            {
                value.text = @"身份证";
            }
            break;
        case 2:
            value.text = idNo;
            break;
        case 3:
            value.text = depCity;
            break;
        default:
            break;
    }
    
    value.font = [UIFont systemFontOfSize:16.0f];
    value.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
    value.textAlignment = NSTextAlignmentRight;
    value.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:value];
    [value release];
    
    if(indexPath.row == 1 || indexPath.row == 3)
    {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowhead.png"]];
        arrow.frame = CGRectMake(278, 15, 12, 16);
        [cell addSubview:arrow];
        [arrow release];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
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

- (void) userDidInput
{
    switch(input.keyboardType)
    {
        case UIKeyboardTypeNumbersAndPunctuation:
            if(passportType == 0)
            {
                if(input.text.length != 18)
                {
                    // error : invalid idNo
                }
                else
                {
                    [idNo release];
                    idNo = [input.text retain];
                }
            }
            break;
        case UIKeyboardTypeNamePhonePad:
            [passName release];
            passName = [[input text] retain];
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseAirPortViewController *chooseAp;
    
    switch (indexPath.row)
    {
        case 0:
            input = [[TextInputHelperViewController alloc] initWithKeyboardType:UIKeyboardTypeNamePhonePad];
            
            input.delegate = self;
            
            [self presentViewController:input
                               animated:YES
                             completion:^(void){
                                 [input release];
                             }];
            
            break;
        case 1:
//            UIPickerView *picker = [UIPickerView alloc] initWithFrame
            break;
        case 2:
            input = [[TextInputHelperViewController alloc] initWithKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            
            input.delegate = self;
            
            [self presentViewController:input
                               animated:YES
                             completion:^(void){
                                 [input release];
                             }];
            
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
}

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPort
{
    depCity = airPort.cityName;
    depCityCode = airPort.cityName;
    
    [checkInInfoTable reloadData];
}

@end
