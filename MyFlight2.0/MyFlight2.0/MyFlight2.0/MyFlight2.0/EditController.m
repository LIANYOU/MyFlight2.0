//
//  EditController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-16.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "EditController.h"
#import "EditCell.h"
@interface EditController ()

@end

@implementation EditController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.titleArr = [NSArray arrayWithObjects:@"姓名",@"性别",@"详细地址",nil];
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    histroyBut.frame = CGRectMake(230, 5, 41, 30);
    histroyBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [histroyBut setTitle:@"保存" forState:UIControlStateNormal];
    histroyBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_save_.png"]];
    [histroyBut addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=backBtn;
    [backBtn release];

    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.firstLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.selectionStyle = 0;
    
    if (indexPath.row == 0) {
        _name = cell.text.text;
    }
    if (indexPath.row == 1) {
        _gender = cell.text.text;
    }
    if (indexPath.row == 2) {
        _address = cell.text.text;
    }
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)getDate:(void (^) (NSString * name, NSString * gender ,NSString * address))string
{
    [blocks release];
    blocks = [string copy];

}
//-(void)save
//{
//    NSLog(@"%@",cell.text.text);
//    blocks(self.name,self.gender,self.address);
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end
