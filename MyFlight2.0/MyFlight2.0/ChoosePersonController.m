//
//  ChoosePersonController.m
//  MyFlight2.0
//
//  Created by sss on 12-12-7.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "ChoosePersonController.h"
#import "ChoosePersonCell.h"
@interface ChoosePersonController ()

@end

@implementation ChoosePersonController

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
    self.showPersonTableView.delegate = self;
    self.showPersonTableView.dataSource = self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_showPersonTableView release];
//    [_choosePersonTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setShowPersonTableView:nil];
//    [self setChoosePersonTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Table delegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * myView =[[[UIView alloc] init] autorelease];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom]; //添加查找按钮
    button.frame = CGRectMake(70, 15, 185, 42);
    [button setTitle:@"新增乘机人" forState:UIControlStateNormal];
    // [button setBackgroundImage:[UIImage imageNamed:@"查找按钮"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(addPerson) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button];
    return myView;
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    ChoosePersonCell *cell = (ChoosePersonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell)
//    {
//        [[NSBundle mainBundle] loadNibNamed:@"ChoosePersonCell" owner:self options:nil];
//      // cell = self.choosePersonTableView;
//    }
//    return cell;
//}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 


@end
