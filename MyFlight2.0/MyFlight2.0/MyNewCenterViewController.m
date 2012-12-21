//
//  MyNewCenterViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/20/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "MyNewCenterViewController.h"
#import "PersonalInfoViewController.h"
#import "PersonInfotoShowViewController.h"
#import "CommonContactViewController.h"

#import "MyCheapViewController.h"
@interface MyNewCenterViewController ()

@end

@implementation MyNewCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) back{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void) loginOut{
    
    
    
    
    
}

#pragma mark -
#pragma mark 设置导航栏 
- (void) setNav{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 30, 31);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    backBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_return_.png"]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
//    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    histroyBut.frame = CGRectMake(215, 5, 30, 30);
//    [histroyBut setTitle:@"退出" forState:UIControlStateNormal];
//    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_2words_.png"]];
//    [histroyBut addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
//    self.navigationItem.rightBarButtonItem=histroyBtn;
//    [histroyBtn release];file://localhost/Users/LIANYOU/MyFlight2.0/MyFlight2.0/MyFlight2.0/icon_add_.png
  
    
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add_.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(loginOut)];
//   
//    self.navigationItem.rightBarButtonItem = barItem;
//    [barItem release];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNav];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoPersonalInfo:(id)sender {
    
    PersonInfotoShowViewController *controller = [[PersonInfotoShowViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
       
}

- (IBAction)gotoMyCoupons:(id)sender {
    
    
    MyCheapViewController *con = [[MyCheapViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
    
}

- (IBAction)gotoMyOrderList:(id)sender {
}

- (IBAction)gotoCommonPerson:(id)sender {
    
    
    CommonContactViewController *con = [[CommonContactViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}

- (IBAction)gotoMyCheapFlightList:(id)sender {
}

- (IBAction)gotoMakeAccountFull:(id)sender {
}
@end
