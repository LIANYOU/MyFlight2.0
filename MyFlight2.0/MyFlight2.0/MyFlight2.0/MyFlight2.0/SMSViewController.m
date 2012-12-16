//
//  SMSViewController.m
//  MyFlight2.0
//
//  Created by apple on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "SMSViewController.h"

@interface SMSViewController ()

@end

@implementation SMSViewController
@synthesize sendMessageButton,detailTable;
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
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, 76, 30);
    [myBtn setImage:[UIImage imageNamed:@"btn_blue_rule.png"] forState:UIControlStateNormal];
    [myBtn setTitle:@"选择联系人" forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:myBtn];
    [myBtn release];
    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
    
    self.detailTable.delegate = self;
    self.detailTable.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)rightItemClick:(UIBarButtonItem *)arg{
    NSLog(@"uibarbuttonItemClick");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

@end
