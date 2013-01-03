//
//  PayViewController.m
//  MyFlight2.0
//
//  Created by WangJian on 13-1-3.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "PayViewController.h"
#import "MyCenterUility.h"
#import "PublicConstUrls.h"
#import "UIButton+BackButton.h"
#import "DetailsOrderViewController.h"
@interface PayViewController ()

@end

@implementation PayViewController

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
    NSLog(@"orderId = %@",self.orderDetaile.orderId);
    NSLog(@"memberId = %@",self.orderDetaile.memberId);
    NSLog(@"checkCode = %@",self.orderDetaile.checkCode);
    NSLog(@"sign = %@",self.orderDetaile.sign);
    NSLog(@"Token = %@",Default_Token_Value);
    NSLog(@"source = %@",self.orderDetaile.source);
    NSLog(@"hwId = %@",self.orderDetaile.hwId);
    NSLog(@"edition = %@",self.orderDetaile.edition);
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];

    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    DetailsOrderViewController * detail = [[DetailsOrderViewController alloc] init];
    detail.detaile = self.orderDetaile;
    detail.searchType = self.searchType;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
@end
