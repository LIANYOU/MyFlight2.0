//
//  PhoneReChargeViewController.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/6/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "PhoneReChargeViewController.h"
#import "PhoneReChargeCell.h"
#import "AppConfigure.h"
#import "UIQuickHelp.h"
#import "LoginBusiness.h"
#import "UIButton+BackButton.h"
@interface PhoneReChargeViewController ()


@end

@implementation PhoneReChargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setNav{
    
    UIButton * backBtn = [UIButton  backButtonType:0 andTitle:@""];
    
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtn1=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBtn1;
    [backBtn1 release];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNav];
    self.thisTableView.tableFooterView = self.thisFootView;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag ==100) {
        
    
        self.cardNOString = textField.text;
        CCLog(@"卡号：%@",self.cardNOString);
      
    } else{
        
        self.passWd = textField.text;
        
        CCLog(@"密码为:%@",self.passWd);
    }
    
     
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    return true;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PhoneReChargeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"PhoneReChargeCell" owner:nil options:nil];
        cell = [[[array objectAtIndex:0] retain] autorelease];
        
    }
    
    if (indexPath.row ==0) {
        
        
        cell.nameLabel.text = @"心愿旅行卡号";
        cell.thisDetailLabel.placeholder = @"请填写心愿旅行卡卡号";
        cell.thisDetailLabel.tag = 100;
        self.accountField = cell.thisDetailLabel;
        
    } else{
        
        cell.nameLabel.text = @"卡密码";
        cell.thisDetailLabel.placeholder = @"请输入密码";
        cell.thisDetailLabel.tag = 200;
        self.pwdField = cell.thisDetailLabel;
        
    }
    cell.thisDetailLabel.delegate =self;
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}






- (void)dealloc {
    [_thisFootView release];
    [_thisTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThisFootView:nil];
    [self setThisTableView:nil];
    [super viewDidUnload];
}
- (IBAction)makeCharge:(id)sender {
    
    
    [self.pwdField resignFirstResponder];
    [self.accountField resignFirstResponder];
    
    NSString *card =[self.accountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [self.pwdField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    CCLog(@"账号 ：%@",card);
    CCLog(@"密码为：%@",pwd);
    
    if ([card length]==0) {
        
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"卡号为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    }  else if([pwd length]==0){
        [UIQuickHelp showAlertViewWithTitle:@"温馨提示" message:@"密码为空，请输入密码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];

        
    } else{
        
        LoginBusiness *bis =[[LoginBusiness alloc] init];
        
        [bis makeAccountFullWithRechargeCardNo:self.cardNOString cardPasswd:self.passWd andDelegate:self];
        [bis release];
    }
    
    
    
    
}




#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    
    
    
    
    
    
}




@end
