//
//  HistroyCheckViewController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-5.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "HistroyCheckViewController.h"

@interface HistroyCheckViewController ()

@end

@implementation HistroyCheckViewController

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
    self.navigationItem.title = @"历史查询纪录";
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    histroyBut.frame = CGRectMake(230, 5, 80, 30);
    [histroyBut setTitle:@"清空" forState:UIControlStateNormal];
    [histroyBut addTarget:self action:@selector(deleteHistroy) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteHistroy
{
    NSLog(@"历史已经删除");
}
@end
