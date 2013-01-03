//
//  SPHFrequentMainViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/3/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "SPHFrequentMainViewController.h"
#import "AppConfigure.h"
@interface SPHFrequentMainViewController (){
    
    NSArray *nameArray;
}

@end

@implementation SPHFrequentMainViewController

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
    
    
    self.footView.frame  =CGRectMake(0, MainHeight_withoutNavBar-54, 320, 54);
    [self.view addSubview:self.footView];
    self.thisTableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    
    
    if (iPhone5) {
        
        
        
        CCLog(@"是Iphone5");
        
        
    } else{
        
        CCLog(@"不是iPhone5");
    }
    
    
//   MainHeight
//    CCLog(@"高度 ：%@",MainHeight);
    
    CCLog(@"%f",MainHeight);
    CCLog(@"%f",MainWidth);
    
    CCLog(@"屏幕高度是 %f",[[UIScreen mainScreen] bounds].size.height);
    
    CCLog(@"宽度为:%f",[[UIScreen mainScreen] bounds].size.width);
    
    nameArray = [[NSArray alloc] initWithObjects:@"里程累积/兑换标准查询",@"里程补登",@"里程详情查询",@"申请加入金鹏俱乐部会员", nil];
    self.thisTableView.tableHeaderView  = self.FucktableviewHeader;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_FucktableviewHeader release];
    [_thisTableView release];
    [_footView release];
    [_cardNumber release];
    [_nameLabel release];
    [_lichengLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFucktableviewHeader:nil];
    [self setThisTableView:nil];
    [self setFootView:nil];
    [self setCardNumber:nil];
    [self setNameLabel:nil];
    [self setLichengLabel:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
  cell.contentView.backgroundColor = [UIColor clearColor];

    
    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
       
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger selectIndex = indexPath.row;
    id controller = nil;
    
    switch (selectIndex) {
        case 0:
            
            break;
            
        default:
            break;
    }
}



@end
