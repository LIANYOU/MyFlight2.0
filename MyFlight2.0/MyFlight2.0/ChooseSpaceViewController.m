//
//  ChooseSpaceViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "ChooseSpaceViewController.h"
#import "ChooseSpaceCell.h"
#import "WriteOrderViewController.h"
@interface ChooseSpaceViewController ()

@end

@implementation ChooseSpaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initDataArr
{
    
}

- (void)viewDidLoad
{
    [self initDataArr];
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_SpaceName release];
    [_changeSpace release];
    [_payMoney release];
    [_ticketCount release];
    [_discount release];
    [_showTableView release];
    [_spaceCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSpaceName:nil];
    [self setChangeSpace:nil];
    [self setPayMoney:nil];
    [self setTicketCount:nil];
    [self setDiscount:nil];
    [self setShowTableView:nil];
    [self setSpaceCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ChooseSpaceCell *cell = (ChooseSpaceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ChooseSpaceCell" owner:self options:nil];
        cell = self.spaceCell;
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        WriteOrderViewController * insurance = [[WriteOrderViewController alloc] init];
        [self.navigationController pushViewController:insurance animated:YES];
        [insurance release];
    
}
@end
