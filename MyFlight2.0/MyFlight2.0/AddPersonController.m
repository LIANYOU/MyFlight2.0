//
//  AddPersonController.m
//  MyFlight2.0
//
//  Created by WangJian on 12-12-11.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "AddPersonController.h"
#import "AddPersonCoustomCell.h"
#import "AddPersonSwitchCell.h"
#import "IdentityViewController.h"
#import "UIButton+BackButton.h"
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
    if (self.choose != nil) {
        self.navigationItem.title = @"编辑乘机人";
    }
    else{
        self.navigationItem.title = @"添加乘机人";
    }
    
    
    self.cellTitleArr = [NSArray arrayWithObjects:@"身  份 *",@"姓  名 *",@"证件类型 *",@"证件号码 *",@"生  日 *",@"保存为常用乘机人", nil];
 
    self.cellTextArr = [NSMutableArray arrayWithObjects:@"成人",@"请输入乘机人姓名",@"省份证",@"请输入证件号码",@"1990-09-09", nil];
    
    self.addPersonTableView.delegate = self;
    self.addPersonTableView.dataSource = self;
    
    UIButton * backBtn = [UIButton backButtonType:0 andTitle:@""];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
    UIButton * histroyBut = [UIButton backButtonType:2 andTitle:@"保存"];
    [histroyBut addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *histroyBtn=[[UIBarButtonItem alloc]initWithCustomView:histroyBut];
    self.navigationItem.rightBarButtonItem=histroyBtn;
    [histroyBtn release];

    
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
    [_addPersonSwithCell release];
    [_addPersonCoustomCell release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddPersonTableView:nil];
    [self setAddPersonSwithCell:nil];
    [self setAddPersonCoustomCell:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        
        return 6;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.cellTextArr objectAtIndex:0] isEqual:@"成人"]) {
        if (indexPath.row == 4) {
            return 0;
        }
        else
        {
            return 44;
        }
    }
    else{
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (indexPath.row == 5) {
      
         static NSString *CellIdentifier1 = @"Cell";
        AddPersonSwitchCell *cell = (AddPersonSwitchCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"AddPersonSwitchCell" owner:self options:nil];
            cell = self.addPersonSwithCell;
        }
        cell.cellTitle.text = [self.cellTitleArr objectAtIndex:indexPath.row];
        [cell.swith addTarget:self action:@selector(switchOFFORON:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
        
    }
    
    else{
        static NSString *CellIdentifier = @"Cell";
        AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [[NSBundle mainBundle] loadNibNamed:@"AddPersonCoustomCell" owner:self options:nil];
            cell = self.addPersonCoustomCell;
        }
        
        
        if ([[self.cellTextArr objectAtIndex:0] isEqual:@"成人"]) {
            if (indexPath.row == 4) {
                cell.hidden = YES;
            }
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.secText.enabled = NO;
            }
            if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
                cell.secText.delegate = self;
            }
            
            cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];

        }
        
        else
        {
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.secText.enabled = NO;
            }
            cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
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
            NSLog(@"---%@",idntity);
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

-(void)getDate:(void (^) (NSString * name, NSString * identity))string
{
    [blocks release];
    blocks = [string copy];
}
-(void)back
{
  //  blocks(name,identityType);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    
}
@end
