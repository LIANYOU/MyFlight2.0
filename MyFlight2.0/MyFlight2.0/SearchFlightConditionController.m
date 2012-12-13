//
//  SearchFlightConditionController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchFlightConditionController.h"
#import "SearchFlightCondition.h"
#import "ShowFligthConditionController.h"
@interface SearchFlightConditionController ()

@end

@implementation SearchFlightConditionController

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
    [super viewDidLoad];
    
    self.navigationItem.title = @"航班动态";
    
    self.selectedByAirPort.frame = CGRectMake(0, 460-390, 320, 378);
    self.selectedByDate.frame = CGRectMake(0, 460-390, 320, 378);
    
    [self.view addSubview:self.selectedByAirPort];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_startAirPort release];
    [_endAirPort release];
    [_time release];
    [_selectedByAirPort release];
    [_selectedSegment release];
    [_flightNumber release];
    [_selectedByDate release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStartAirPort:nil];
    [self setEndAirPort:nil];
    [self setTime:nil];
    [self setSelectedByAirPort:nil];
    [self setSelectedSegment:nil];
    [self setFlightNumber:nil];
    [self setSelectedByDate:nil];
    [super viewDidUnload];
}
- (IBAction)selectedInquireType:(UISegmentedControl *)sender {
    
    if (self.selectedSegment.selectedSegmentIndex == 1) {
        [self.selectedByAirPort removeFromSuperview];
        [self.view addSubview:self.selectedByDate];
    }
    else if (self.selectedSegment.selectedSegmentIndex == 0)
    {
        [self.selectedByDate removeFromSuperview];
        [self.view addSubview:self.selectedByAirPort];
    }
}

- (IBAction)searchFligth:(id)sender {
    SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:nil fdate:nil dpt:@"PEK" arr:@"SHA" hwld:nil];
        
    ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
    
    show.searchCondition = search;
    
    [self.navigationController pushViewController:show animated:YES];
    [show release];

}


@end
