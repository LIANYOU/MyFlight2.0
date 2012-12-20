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
#import "AirPortData.h"
#import "AppConfigure.h"
#import <QuartzCore/QuartzCore.h>
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
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:222.0/255.0 blue:215.0/255.0 alpha:1];;
    
    NSArray * array = [[NSArray alloc]initWithObjects:@"按起降地",@"按航班号", nil];
    mySegmentController  = [[SVSegmentedControl alloc]initWithSectionTitles:array];
    mySegmentController.backgroundImage = [UIImage imageNamed:@"tab_bg.png"];
    mySegmentController.textColor = myFirstColor;
    mySegmentController.height = 40;
    mySegmentController.LKWidth = 150;
    mySegmentController.center = CGPointMake(160, 50);
    mySegmentController.thumb.textColor = mySceColor;
    mySegmentController.thumb.tintColor = [UIColor whiteColor];
    mySegmentController.thumb.textShadowColor = [UIColor clearColor];
    [array release];
    mySegmentController.crossFadeLabelsOnDrag = YES;
   
    mySegmentController.tintColor = [UIColor colorWithRed:22/255.0f green:74.0/255.0f blue:178.0/255.0f alpha:1.0f];
    [self.view addSubview:mySegmentController];
    
    

    mySegmentController.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    [mySegmentController addTarget:self action:@selector(mySegmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.selectedByAirPort.frame = CGRectMake(0, 460-390, 320, 378);
    self.selectedByAirPort.backgroundColor = [UIColor clearColor];
    self.selectedByDate.frame = CGRectMake(320, 460-390, 320, 378);
    self.selectedByDate.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:self.selectedByAirPort];
    [self.view addSubview:self.selectedByDate];
    
    
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
//    NSLog(@"%@",nsDateString);
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

        SearchFlightCondition * search = [[SearchFlightCondition alloc] initWithfno:nil fdate:nil dpt:startAirPortCode arr:arrAirPortCode hwld:nil];
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

- (IBAction)chooseStartAirPort:(id)sender {
    
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    //默认出发机场 
    controller.startAirportName = self.startAirPort.text;
    //默认到达机场 
    controller.endAirPortName =self.endAirPort.text;
    //选择的类型 
    controller.choiceTypeOfAirPort = START_AIRPORT_TYPE;
    controller.delegate =self;
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)chooseEndAirPort:(id)sender {
    
    ChooseAirPortViewController *controller = [[ChooseAirPortViewController alloc] init];
    //默认出发机场
    controller.startAirportName = self.startAirPort.text;
    //默认到达机场
    controller.endAirPortName =self.endAirPort.text;
    //选择的类型
    controller.choiceTypeOfAirPort = END_AIRPORT_TYPE;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)mySegmentValueChange:(SVSegmentedControl *)arg{
    if (arg.selectedIndex == 1) {
        /*
         |a    b    0|
         
         |c    d    0|
         
         |tx   ty   1|
         */
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];

        CGAffineTransform moveTo = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom = CGAffineTransformMakeTranslation(-320, 0);
        self.selectedByAirPort.layer.affineTransform = moveTo;
        self.selectedByDate.layer.affineTransform = moveFrom;
        [UIView commitAnimations];
        
    }else if (arg.selectedIndex == 0){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        CGAffineTransform moveTo1 = CGAffineTransformMakeTranslation(320, 0);
        CGAffineTransform moveFrom1 = CGAffineTransformMakeTranslation(0, 0);
        self.selectedByAirPort.layer.affineTransform = moveFrom1;
        self.selectedByDate.layer.affineTransform = moveTo1;
        [UIView commitAnimations];
    }
}


- (IBAction)returnClicked:(id)sender {
    [self.flightNumber resignFirstResponder];
}

- (void) ChooseAirPortViewController:(ChooseAirPortViewController *)controlelr chooseType:(NSInteger)choiceType didSelectAirPortInfo:(AirPortData *)airPortP{
    
    if (choiceType==START_AIRPORT_TYPE ) {
        //获得用户的出发机场 
        self.startAirPort.text = airPortP.apName;
        NSLog(@"my >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",airPortP.apCode);
        startAirPortCode = [NSString stringWithString:airPortP.apCode];
    } else if(choiceType==END_AIRPORT_TYPE){
        //获得用户的到达机场
        self.endAirPort.text = airPortP.apName;
         NSLog(@"my >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",airPortP.apCode);
        arrAirPortCode = [NSString stringWithString:airPortP.apCode];
        
    }
}
@end
