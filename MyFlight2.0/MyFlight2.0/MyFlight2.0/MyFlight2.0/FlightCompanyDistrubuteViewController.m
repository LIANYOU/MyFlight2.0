//
//  FlightCompanyDistrubuteViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-19.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "FlightCompanyDistrubuteViewController.h"

@interface FlightCompanyDistrubuteViewController ()

@end

@implementation FlightCompanyDistrubuteViewController

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
    CGRect myRect = [[UIScreen mainScreen] bounds];
    CGSize mySize = myRect.size;
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, mySize.height - 20)];
    myView.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];
//    UITextView * myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, myView.bounds.size.width, myView.bounds.size.height - 30)];
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, myView.bounds.size.height - 40, myView.bounds.size.width, 40)];
    bottomView.backgroundColor = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:239/255.0 alpha:1];

    UIImageView * line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_one.png"]];
    line.frame = CGRectMake(0, myView.bounds.size.height - 41, myView.bounds.size.width, 1);
    [myView addSubview:line];
    [line release];
    
    UIImageView * loc = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_location.png"]];
    loc.frame = CGRectMake(230, 9, 20, 25);
    [myView addSubview:loc];
    [loc release];
    
    UIImageView * more = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_travel_more.png"]];
    more.frame = CGRectMake(265, 9, 17, 24);
    [myView addSubview:more];
    [more release];
    
    
    [myView addSubview:bottomView];
    [bottomView release];
    
    
    [self.view addSubview:myView];
    [myView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
