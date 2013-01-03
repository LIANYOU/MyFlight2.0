//
//  MileSearchViewController.h
//  HaiHang
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 iTotem. All rights reserved.
//

#import "MileSearchViewController.h"
#import "DataEnvironment.h"
#import "ComponentsFactory.h"
#import "UIUtil.h"

@implementation MileSearchViewController
@synthesize _label1;
@synthesize _label2;

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

-(void)getMemberInfo
{
    //send 里程查询
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          [DATA_ENV getFrequentFlyerSavedUsername],@"cardNo",
                          [DATA_ENV getFrequentFlyerSavedPassword], @"psw",
                          nil];
    
    
    [GetMemberPointDataRequest requestWithDelegate:self
                                    withParameters:data
                                 withIndicatorView:self.view];
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
    
	NSString *title = @"里程查询";
	UILabel *titleLbl = [ComponentsFactory navigationBarTitleLabelWithTitle:title];
	[navBGView addSubview:titleLbl];
	
	UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navBGView];
	[self.navigationItem setLeftBarButtonItem:navLeft animated:YES];
    [navLeft release];
	[navBGView release];
    [title release];
}

-(IBAction)telAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:_telLabel.text]]];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    self.title = @"里程查询";
    self._label1.text = DATA_ENV.frequentFlyerInfo.balance;
    self._label2.text = DATA_ENV.frequentFlyerInfo.expDate;
    
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getMemberInfo];
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
    
    [_label1 release];
    [_label2 release];
    [_contentView release];
    [_telLabel release];
    [super dealloc];
}

#pragma mark - UITableViewDelegate

#pragma mark BaseDataRequestDelegate methods
- (void)requestDidFinishLoad:(BaseDataRequest*)request {
    //获取版本号
//    NSString *versionStr = [UIUtil getVersionStr];
    
    if (![request isSuccess]) {
        [[request getResult] showErrorMessage];
		return;
	}
    
	if ([request isKindOfClass:[GetMemberPointDataRequest class]]) {
        
        NSMutableDictionary *dataDic = [request.resultDic objectForKey:@"frequentFlyer"];
        
        self._label1.text = [dataDic objectForKey:@"balance"];
        self._label2.text = [dataDic objectForKey:@"expireDate"];        
	}
}

@end
