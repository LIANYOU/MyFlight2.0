//
//  QueryLeijiViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "QueryLeijiViewController.h"
#import "AppConfigure.h"
#import "AirPortData.h"
#import "AirPortCompanyData.h"
#import "ChooseAirPortCompanyViewController.h"
#import "NoticeViewController.h"
@interface QueryLeijiViewController ()

@end

@implementation QueryLeijiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void) initThisView{
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    NSArray * titleNameArray = [[NSArray alloc]initWithObjects:@"里程累计标准",@"里程兑换标准", nil];
    segmented = [[SVSegmentedControl alloc]initWithSectionTitles:titleNameArray];
    [titleNameArray release];
    segmented.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    segmented.textColor = myFirstColor;
    segmented.center = CGPointMake(160, 30);
    
    //segmented.thumb.backgroundImage = [UIImage imageNamed:@"tab.png"];
    
    segmented.height = 38;
    segmented.LKWidth = 150;
    
    segmented.thumb.textColor = mySceColor;
    segmented.thumb.tintColor = [UIColor whiteColor];
    segmented.thumb.textShadowColor = [UIColor clearColor];
    segmented.crossFadeLabelsOnDrag = YES;
    
    segmented.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    
    [segmented addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];
    
    
}


-(void)mySegmentValueChange:(SVSegmentedControl *)sender{
    if (sender.selectedIndex ==0) {
        
        CCLog(@"选择的是第一个视图");
        self.title = @"飞行里程累积标准查询";
        [self initFirstSelectionView];
        
    } else{
        CCLog(@"选择的第二个视图");
        self.title = @"飞行里程兑换标准查询";
        [self initSecondSelectionView];
        
    }
    
    
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initThisView];
     
    self.title = @"飞行里程累积标准查询";
    
    [self initFirstSelectionView];
    
//    self.startAirportLabel.text = Default_StartAirPort;
//    self.endAirportLabel.text = Default_EndAirPort;
    
    self.startAirportLabel.text = @"北京首都";
    
    self.endAirportLabel.text = @"上海虹桥";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initFirstSelectionView{
    
    self.showDetailTextView.hidden =NO;
    self.noticeBn.hidden = YES;
    self.secondNotice.hidden = YES;
    
    
    
}

- (void) initSecondSelectionView{
    self.noticeBn.hidden = NO;
    self.secondNotice.hidden = NO;
    self.showDetailTextView.hidden = YES;
    
    
}

- (IBAction)chooseCompany:(id)sender {
    
    
    
    ChooseAirPortCompanyViewController *controller = [[ChooseAirPortCompanyViewController alloc] init];
    controller.delegate =self;
    controller.selectedCompany = self.companyName.text;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
    
}
- (void)dealloc {
    [_companyName release];
    [_startAirportLabel release];
    [_endAirportLabel release];
    [_showDetailTextView release];
    [_noticeBn release];
    [_secondNotice release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCompanyName:nil];
    [self setStartAirportLabel:nil];
    [self setEndAirportLabel:nil];
    [self setShowDetailTextView:nil];
    [self setNoticeBn:nil];
    [self setSecondNotice:nil];
    [super viewDidUnload];
}
- (IBAction)startAirPort:(id)sender {
    
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    controller.startAirportName = self.startAirportLabel.text;
    controller.endAirPortName = self.endAirportLabel.text;
    controller.choiceTypeOfAirPort = START_AIRPORT_TYPE;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
    
    
}

- (IBAction)endAirport:(id)sender {
    
    
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    controller.startAirportName = self.startAirportLabel.text;
    controller.endAirPortName = self.endAirportLabel.text;
    controller.choiceTypeOfAirPort = END_AIRPORT_TYPE;
    
    controller.delegate =self;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

    
    
    
}
- (IBAction)queryInfo:(id)sender {
    
    
    
    
}

- (IBAction)goToNoticeWeb:(id)sender {
    
    NoticeViewController *con = [[NoticeViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    [con release];
    
    
}


- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPort{
    
    
    
    if (choiceType==0) {
        
        self.startAirportLabel.text = airPort.apName;
    } else{
        
        self.endAirportLabel.text =airPort.apName;
    }
}


- (void) ChooseAirPortCompanyViewController:(ChooseAirPortCompanyViewController *)controller DidChooseCompany:(AirPortCompanyData *)company{
    
    
    self.companyName.text = company.shortName;
    
     
}
@end
