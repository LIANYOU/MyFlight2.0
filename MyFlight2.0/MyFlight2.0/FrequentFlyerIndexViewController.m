//
//  FrequentFlyerIndexViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//

#import "FrequentFlyerIndexViewController.h"
#import "FrequentTableViewCell.h"
#import "CitySearchController.h"
#import "DataEnvironment.h"
#import "FlightCumulativeViewController.h"
#import "TicketExchangeViewController.h"
#import "MileSearchViewController.h"
#import "MileageViewController.h"
#import "HomeNViewController.h"
#import "UIUtil.h"
#import "ComponentsFactory.h"

@implementation FrequentFlyerIndexViewController


- (void)setNav {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
                                                      tag:1];
	
	[navBGView addSubview:backBtn];
    
    UIButton *logoutBtn = [ComponentsFactory buttonWithType:UIButtonTypeCustom
                                                    title:@"退出"
                                                    frame:CGRectMake(260,7,50,29)
                                                imageName:IMAGE_NAV_RIGHT_BTN_PRESSED
                                          tappedImageName:IMAGE_NAV_RIGHT_BTN
                                                   target:self 
                                                   action:@selector(logoutAction:)
                                                      tag:1];
	
	[navBGView addSubview:logoutBtn];
	
	NSString *title = @"常旅客专区";
	UILabel *titleLbl = [ComponentsFactory navigationBarTitleLabelWithTitle:title];
	[navBGView addSubview:titleLbl];
	UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navBGView];
	[self.navigationItem setLeftBarButtonItem:navLeft animated:YES];
	[navBGView release];
    [navLeft release];
    [title release];
}

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"nav_btn_green_back@2x.png"] forState:UIControlStateNormal];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"nav_btn_green_back_pressed@2x.png"] forState:UIControlStateHighlighted];
//        backButton.frame = CGRectMake(3,7,50,29);
//        [backButton addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
        
    }
    return self;
}


-(void)setData
{
    _nameLabel.text = [@"姓名: " stringByAppendingFormat:@"%@",frequentFlyerData.name];
    _sexLabel.text = [@"性别: " stringByAppendingFormat:@"%@",frequentFlyerData.sex];
    _cardNumberLabel.text = [DATA_ENV getFrequentFlyerSavedUsername];
    _addressLabel.text = [@"家庭住址: " stringByAppendingFormat:@"%@",frequentFlyerData.addreString];
    _milesLabel.text = frequentFlyerData.balance;
    
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundImage:[UIImage imageNamed:@"go_home@2x.png"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"go_home_pressed@2x.png"] forState:UIControlStateHighlighted];
        backButton.frame = CGRectMake(3,7,50,29);
        [backButton addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改账户" style:UIBarButtonItemStyleBordered target:self action:@selector(modifyAction:)];
        
        frequentFlyerData = ffpData;
        
    }
    return self;
}
 */
-(void)logoutAction:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    // 常旅客跳转处理 无底部导航 20120824 wwl
    [self.navigationController dismissModalViewControllerAnimated:YES];
    DATA_ENV.isFrequentFlyerLogedIn = NO;
    //[[HomeNViewController sharedHomeNViewController] tripBtAction:nil];
}
-(void)BackAction:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    // 常旅客跳转处理 无底部导航 20120824 wwl
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - init

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)telAction:(id)sender
{
    NSString *phone = _telLabel.text;
    
    if([phone isEqualToString:@""])
    {
        return;
    }
    
    NSString *strInfo = [[NSString alloc] initWithFormat:@"拨打电话 %@ ?",phone];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:strInfo delegate:self cancelButtonTitle:@"拨打" otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"拨打"])
    {
        
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:_telLabel.text]]];
        
    }
	
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    self.title = @"常旅客专区";
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"机票兑换计算",@"飞行累积计算",@"里程查询",@"里程补登" , nil];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    frequentFlyerData = DATA_ENV.frequentFlyerInfo;
    [self setData];
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
    [_cardNumberLabel release];
    [_milesLabel release];
    [_nameLabel release];
    [_sexLabel release];
    [_addressLabel release];
    [_tableView release];
    [_dataArray release];
    [_contentView release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.backgroundView.backgroundColor = [UIColor whiteColor];
    //UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
    //selectedBgView.backgroundColor = [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0/255.0f alpha:1];;;
    //cell.selectedBackgroundView = selectedBgView;
    //[selectedBgView release];
    UIView *_bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    //_bgView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:_bgView];
    [cell sendSubviewToBack:_bgView];
    [_bgView release];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([indexPath row] == 0) {
        TicketExchangeViewController *ticketExchangeViewController = [[TicketExchangeViewController alloc] initWithNibName:@"TicketExchangeViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:ticketExchangeViewController animated:YES];
        [ticketExchangeViewController release];
    }
    else if ([indexPath row]==1)
    {
        FlightCumulativeViewController *flightCumulativeViewController = [[FlightCumulativeViewController alloc] initWithNibName:@"FlightCumulativeViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:flightCumulativeViewController animated:YES];
        [flightCumulativeViewController release];
    }
    else if ([indexPath row]==2)
    {
        MileSearchViewController *mileSearchViewController = [[MileSearchViewController alloc] initWithNibName:@"MileSearchViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:mileSearchViewController animated:YES];
        [mileSearchViewController release];
    }
    else if ([indexPath row]==3)
    {
        MileageViewController *mileageViewController = [[MileageViewController alloc] initWithNibName:@"MileageViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:mileageViewController animated:YES];
        [mileageViewController release];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
