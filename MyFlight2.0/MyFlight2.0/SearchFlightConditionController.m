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
#import "DetailFlightConditionViewController.h"
@interface SearchFlightConditionController ()

@end

@implementation SearchFlightConditionController
@synthesize flightTimeByNumber;
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
    //查询按钮颜色
    //UIColor * mySelectBtnColor = [UIColor colorWithRed:255/255.0 green:107/255.0 blue:42/255.0 alpha:1];
    self.navigationItem.title = @"航班动态";
    
//    UIImageView * leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_return.png"]];
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
//    [leftView release];
//    
//    leftItem.action = @selector(rightItemClick:);
    
    
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightItemClick:)];
//    self.navigationController.navigationItem.rightBarButtonItem = leftItem;
    
 
    
    UIColor * myFirstColor = [UIColor colorWithRed:244/255.0 green:239/255.0 blue:231/225.0 alpha:1.0f];
    UIColor * mySceColor = [UIColor colorWithRed:10/255.0 green:91/255.0 blue:173/255.0 alpha:1];
    self.view.backgroundColor = myFirstColor;
    
    NSArray * array = [[NSArray alloc]initWithObjects:@"按起降地",@"按航班号", nil];
    mySegmentController  = [[SVSegmentedControl alloc]initWithSectionTitles:array];
    mySegmentController.textColor = myFirstColor;
    mySegmentController.height = 40;
    mySegmentController.LKWidth = 150;
    mySegmentController.center = CGPointMake(160, 50);
    mySegmentController.thumb.backgroundImage = [UIImage imageNamed:@"block3_change.png"];
    mySegmentController.thumb.textColor = mySceColor;
    mySegmentController.thumb.textShadowColor = [UIColor clearColor];
    [array release];
    mySegmentController.crossFadeLabelsOnDrag = YES;
    mySegmentController.backgroundImage = [UIImage imageNamed:@"tab_bg_flightCondition.png"];
    mySegmentController.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    [self.view addSubview:mySegmentController];
    
    

    mySegmentController.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [mySegmentController addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.selectedByAirPort.frame = CGRectMake(0, 460-390, 320, 378);
    self.selectedByAirPort.backgroundColor = [UIColor clearColor];
    self.selectedByDate.frame = CGRectMake(0, 460-390, 320, 378);
    self.selectedByDate.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:self.selectedByAirPort];
    
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];

    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d-%2d-%2d",year,month,day];
    [self.time setText:nsDateString];
    [self.flightTimeByNumber setText:nsDateString];
    NSLog(@"%@",nsDateString);
    [dateformatter release];
    
    
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
 
    [_flightNumber release];
    [_selectedByDate release];
    [mySegmentController release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStartAirPort:nil];
    [self setEndAirPort:nil];
    [self setTime:nil];
    [self setSelectedByAirPort:nil];

    [self setFlightNumber:nil];
    [self setSelectedByDate:nil];
    
    [super viewDidUnload];
}


- (IBAction)searchFligth:(id)sender {
    if (mySegmentController.selectedIndex == 0) {
        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:nil fdate:nil dpt:@"PEK" arr:@"SHA" hwld:nil];
        ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
        
        show.searchCondition = search;
        
        [self.navigationController pushViewController:show animated:YES];
        [search release];
        [show release];
    }else {
        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:self.flightNumber.text fdate:self.flightTimeByNumber.text dpt:nil arr:nil hwld:nil];
        ShowFligthConditionController * show = [[ShowFligthConditionController alloc] init];
        show.searchCondition = search;
        [self.navigationController pushViewController:show animated:YES];
        [search release];
        [show release];
    }
    

}

-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    if (arg.selectedIndex == 1) {
        [self.selectedByAirPort removeFromSuperview];
        [self.view addSubview:self.selectedByDate];
    }else if (arg.selectedIndex == 0){
        [self.selectedByDate removeFromSuperview];
        [self.view addSubview:self.selectedByAirPort];
    }
}

-(void)rightItemClick:(UIButton *)arg{
    if (mySegmentController.selectedIndex == 1) {
        [mySegmentController setSelectedIndex:0];
        NSLog(@"mySegmentController.selectedIndex == 1");
    }else if(mySegmentController.selectedIndex == 0){
        [mySegmentController setSelectedIndex:1];
        NSLog(@"mySegmentController.selectedIndex == 0");
    }
}

- (IBAction)returnClicked:(id)sender {
    [self.flightNumber resignFirstResponder];
}
@end
