//
//  AddPersonController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AddPersonController.h"
#import "AddPersonCell.h"
#import "AddPersonSwitchCell.h"
#import "IdentityViewController.h"
@interface AddPersonController ()

@end

@implementation AddPersonController

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
    
    self.navigationItem.title = @"添加乘机人";
    
    self.cellTitleArr = [NSArray arrayWithObjects:@"身份 *",@"姓名 *",@"证件类型 *",@"证件号码 *",@"生日 *",@"保存为常用乘机人", nil];
 
    self.cellTextArr = [NSMutableArray arrayWithObjects:@"成人",@"请输入乘机人姓名",@"省份证",@"请输入证件号码",@"1990-09-09", nil];
    
    self.addPersonTableView.delegate = self;
    self.addPersonTableView.dataSource = self;
    
    
    UIButton * histroyBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    histroyBut.frame = CGRectMake(20, 5, 80, 30);
    [histroyBut setTitle:@"返回" forState:UIControlStateNormal];
    [histroyBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.leftBarButtonItem=backBtn;
    [backBtn release];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_addPersonTableView release];
    [_addPersonCell release];
    [_addPersonSwithCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddPersonTableView:nil];
    [self setAddPersonCell:nil];
    [self setAddPersonSwithCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitleArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row == 5) {
        AddPersonSwitchCell *cell = (AddPersonSwitchCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"AddPersonSwitchCell" owner:self options:nil];
            cell = self.addPersonSwithCell;
        }
        cell.cellTitle.text = [self.cellTitleArr objectAtIndex:indexPath.row];
        [cell.swith addTarget:self action:@selector(switchOFFORON:) forControlEvents:UIControlEventValueChanged];
    
        return cell;

    }
    else
    {
        AddPersonCell *cell = (AddPersonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"AddPersonCell" owner:self options:nil];
            cell = self.addPersonCell;
        }
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
            cell.cellText.enabled = NO;
             
            cell.cellText.text = [self.cellTextArr objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0) {
                identityType = cell.cellText.text;   // 儿童或者成人赋值
            }
            
        }
        else
        {
            if (indexPath.row == 1) {
                cell.cellText.tag = indexPath.row;
            }
            
            cell.cellText.delegate = self;
            cell.cellTitle.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            cell.cellText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
        }
       
        return cell;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2) {
        IdentityViewController * identity = [[IdentityViewController alloc] init];
        identity.flag = indexPath.row;
        
        [identity getDate:^(NSString *idntity) {
            [self.cellTextArr replaceObjectAtIndex:indexPath.row withObject:idntity];
            [self.addPersonTableView reloadData];
        }];

        [self.navigationController pushViewController:identity animated:YES];
        [identity release];
    }
}

#pragma mark - switch

-(void)switchOFFORON:(UISwitch *)sender
{
    mySwitch = (UISwitch *)sender;
    BOOL setting = mySwitch.isOn;//获得开关状态
    if(setting)
    {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:nil message:@"您登录后才能保存乘机人信息，是否登录?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"【暂不登录】",@"【登录】", nil];
        [alter show];
        [alter release];
        
    }else {
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        mySwitch.on = NO;    // 若不登陆则状态位OFF
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"进入登陆界面");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int flag  = textField.tag;
    if (flag == 1) {
        name = textField.text;
    }
}

-(void)getDate:(void (^) (NSString * name, NSString * identity))string
{
    [blocks release];
    blocks = [string copy];
}
-(void)back
{
    blocks(name,identityType);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
