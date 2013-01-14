//
//  SubTrfficViewController.m
//  MyFlight2.0
//
//  Created by apple on 13-1-13.
//  Copyright (c) 2013年 LIAN YOU. All rights reserved.
//

#import "SubTrfficViewController.h"

@interface SubTrfficViewController ()

@end

@implementation SubTrfficViewController
@synthesize subDic = _subDic;
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

-(void)dealloc{
    self.subDic = nil;
    [super dealloc];
}
@end
