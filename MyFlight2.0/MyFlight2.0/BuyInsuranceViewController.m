//
//  BuyInsuranceViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "BuyInsuranceViewController.h"
#import "UIButton+BackButton.h"
@interface BuyInsuranceViewController ()
{
    
}


@end

@implementation BuyInsuranceViewController

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
    self.navigationItem.title = @"购买保险";

    swithType = @"OFF";
    
    if ([self.type isEqualToString:@"ON"]) {
        self.swith.on = YES;
        self.textView.hidden = NO;
    }
    else
    {
        self.textView.hidden = YES;
        self.swith.on = NO;
    }
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
        
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton backButtonType:2 andTitle:@"确定"];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];

    
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
    if ([self.type isEqualToString:@"ON"] || self.swith.on) {
        BuyString = @"20元/份*1人";
        swithType = @"ON";
    }
    if (!self.swith.on) {
        swithType = @"OFF";
        BuyString = nil;

    }
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    blocks(BuyString,swithType);
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)swithOFFOrON:(UISwitch *)sender {
    
    BOOL setting = sender.isOn;//获得开关状态
    if(setting)
    {
        self.textView.hidden = NO;
        swithType = @"ON";
        BuyString = @"20元/份*1人";
    }
    else{

        self.textView.hidden = YES;
        swithType = @"OFF";
        BuyString = nil;
    }

}


-(void)getDate:(void (^) (NSString * idntity,NSString * type))string{
    [blocks release];
    blocks = [string copy];
}

- (void)dealloc {
    [_swith release];
    [_textView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSwith:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
