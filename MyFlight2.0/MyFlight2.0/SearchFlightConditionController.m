//
//  SearchFlightConditionController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SearchFlightConditionController.h"
#import "SearchFlightCondition.h"
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
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStartAirPort:nil];
    [self setEndAirPort:nil];
    [self setTime:nil];
    [super viewDidUnload];
}
- (IBAction)searchFligth:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"接受数据" object:nil];
    
    SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:@"HO1252" fdate:nil dpt:@"PEK" arr:@"SHA" hwld:nil];
    [search searchFlightCondition];
    
}
-(void)receive:(NSNotification *)not//通过通知接收初始数据
{
    NSArray * arr = [NSArray array];
    NSDictionary *dic=[not userInfo];
    arr = [dic objectForKey:@"arr"];

    for (int i = 0; i<arr.count; i++) {
        NSLog(@"%@",[[arr objectAtIndex:i] objectForKey:@"arrAirport"]);
    }
}
@end
