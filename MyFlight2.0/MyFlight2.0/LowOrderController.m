//
//  LowOrderController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-15.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "LowOrderController.h"
#import "LowOrderCell.h"
@interface LowOrderController ()

@end

@implementation LowOrderController

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
    self.firstLabelArr  = [NSArray arrayWithObjects:@"最早出发日期",@"最晚出发日期",@"折扣(不含税)",@"手机号码", nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_lowOrderCell release];
    [_tableView release];
    [_footView release];
    [_viewPicker release];
    [_btnCancel release];
    [_btnDone release];
    [_pickerSort release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLowOrderCell:nil];
    [self setTableView:nil];
    [self setFootView:nil];
    [self setViewPicker:nil];
    [self setBtnCancel:nil];
    [self setBtnDone:nil];
    [self setPickerSort:nil];
    [super viewDidUnload];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 90  ;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * myView =[[[UIView alloc] init] autorelease];
    
    self.footView.frame = CGRectMake(20, 30, 204, 44);
    [myView addSubview:self.footView];
    
    return myView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.firstLabelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LowOrderCell *cell = (LowOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"LowOrderCell" owner:self options:nil];
        cell = self.lowOrderCell;
    }
    
    cell.firstLabel.text = [self.firstLabelArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        [UIView animateWithDuration:2 animations:^{
            self.viewPicker.frame = CGRectMake(0, 250, 320, 70);
            [self.tableView addSubview:self.viewPicker];
        }];
        
    }
}

@end
