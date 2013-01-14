//
//  PersonNewInfotableViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/13/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "PersonNewInfotableViewController.h"
#import "PersonNewInfoCell.h"
#import "IsLoginInSingle.h"
#import "AppConfigure.h"
#import "UserAccount.h"
#import "ModifyPassWordViewController.h"
#import "UIButton+BackButton.h"
#import "PersonalInfoViewController.h"



@interface PersonNewInfotableViewController ()


{
    NSArray *nameArray;
    NSMutableArray *realArray;
    
    NSArray *tmpArray;
    
    
}



@end

@implementation PersonNewInfotableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark 设置导航栏
- (void) setNav{
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    
    
    UIButton * rightBn = [UIButton  backButtonType:2 andTitle:@"修改"];
    [rightBn addTarget:self action:@selector(editPersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:rightBn];
    
    self.navigationItem.rightBarButtonItem=backBtn2;
    [backBtn2 release];
    
    
    
    
}

- (void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void) editPersonalInfo{
    
    
    PersonalInfoViewController *infoCcontroller = [[PersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoCcontroller animated:YES];
    
    [infoCcontroller release];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    IsLoginInSingle *single = [IsLoginInSingle shareLoginSingle];
    [realArray removeAllObjects];
    
    [realArray addObject:Default_AccountName_Value];
    [realArray addObject:single.userAccount.name];
    [realArray addObject:single.userAccount.sex];
    [realArray addObject:single.userAccount.addr];

    tmpArray = realArray;
    
    
    [self.tableView reloadData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self setNav];
    IsLoginInSingle *single = [IsLoginInSingle shareLoginSingle];
    
    realArray =[[NSMutableArray alloc] init];
    [realArray addObject:Default_AccountName_Value];
    [realArray addObject:single.userAccount.name];
    [realArray addObject:single.userAccount.sex];
    [realArray addObject:single.userAccount.addr];
    
    tmpArray =realArray;
    
    nameArray =[[NSArray alloc] initWithObjects:@"用  户 名",@"姓      名",@"性      别",@"详细地址", nil];
    
    self.clearsSelectionOnViewWillAppear = NO;
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    if (section==0) {
        
        return 1;
    } else{
        
        return 3;
    }
    
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1&&indexPath.row==2) {
        return 50;
        
    } else{
        
        return 44;
    }
    
    
}



- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
        return  nil;
    } else{
        
        return indexPath;
    }
       
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PersonNewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       
        NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"PersonNewInfoCell" owner:nil options:nil];
        
        cell =[array objectAtIndex:0];
        
    }
    if (indexPath.section==0) {
        
        cell.nameLabel.text =[nameArray objectAtIndex:indexPath.row];
        cell.thisDetailLabel.text = [tmpArray objectAtIndex:indexPath.row];
        cell.modifyPwdLabel.text = @"修改密码";
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.section==1) {
        
        cell.nameLabel.text =[nameArray objectAtIndex:indexPath.row+1];
        
        cell.thisDetailLabel.text = [tmpArray objectAtIndex:indexPath.row+1];
        
        
    }
   
    
    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
    cell.selectedBackgroundView.backgroundColor=View_BackGrayGround_Color;

    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section ==0) {
        
        ModifyPassWordViewController *con  =[[ModifyPassWordViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
        [con release];

        
        
    }




}

@end
