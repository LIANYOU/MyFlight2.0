//
//  OneWayCheckViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "OneWayCheckViewController.h"
#import "HistroyCheckViewController.h"
#import "ShowSelectedResultViewController.h"
#import "SearchAirPort.h"
@interface OneWayCheckViewController ()

@end

@implementation OneWayCheckViewController

int searchFlag = 0; // 单程和往返的标记位

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    histroyBut.frame = CGRectMake(230, 5, 80, 30);
    [histroyBut setTitle:@"历史查询" forState:UIControlStateNormal];
    [histroyBut addTarget:self action:@selector(historySearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];
    
    self.navigationItem.title = @"机票查询";
    
    returnBtn.hidden = YES; // 默认选择单程，返回日期的图表隐藏
    retrunDateTitle.hidden = YES;
    returnDate.hidden = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [startAirport release];
    startAirport = nil;
    [endAirport release];
    endAirport = nil;
    [startDate release];
    startDate = nil;
    [returnDate release];
    returnDate = nil;
    [returnBtn release];
    returnBtn = nil;
    [retrunDateTitle release];
    retrunDateTitle = nil;
    
    [selectSegment release];
    selectSegment = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)historySearch
{

        
    HistroyCheckViewController * histroy = [[HistroyCheckViewController alloc] init];
    [self.navigationController pushViewController:histroy animated:YES];
    [histroy release];
}

- (IBAction)selectFlayWay:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        searchFlag = 1;
        returnBtn.hidden = YES;
        retrunDateTitle.hidden = YES;
        returnDate.hidden = YES;
    }
    else {
        searchFlag = 2;
        returnBtn.hidden = NO;
        retrunDateTitle.hidden = NO;
        returnDate.hidden = NO;
    }
}

- (IBAction)select:(id)sender {
    if (selectSegment.selectedSegmentIndex == 0) {
        
        SearchAirPort * searchAirPort = [[SearchAirPort alloc] initWithdpt:@"PEK" arr:@"SHA" date:@"2012-12-28" ftype:@"1" cabin:0 carrier:nil dptTime:0 qryFlag:@"xxxxxx"];
        

        ShowSelectedResultViewController * show = [[ShowSelectedResultViewController alloc] init];
        show.airPort = searchAirPort;
        [self.navigationController pushViewController:show animated:YES];
        [show release];
    }
    else {
        NSLog(@"推进返程");
    }
}
- (void)dealloc {
    [startAirport release];
    [endAirport release];
    [startDate release];
    [returnDate release];
    [returnBtn release];
    [retrunDateTitle release];
    [selectSegment release];
    [super dealloc];
}
@end
