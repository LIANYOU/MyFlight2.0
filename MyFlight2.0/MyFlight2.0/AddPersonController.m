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
#import "AppConfigure.h"
#import "LoginBusiness.h"
#import "UIQuickHelp.h"
@interface AddPersonController ()
{
    NSString * passengerType;  // 乘客类型
    NSString * passengerCertType; // 身份证的类型
    
    NSString * certtype;
    
    NSString * passengerName;
    NSString * brithMember;
    NSString * certMember; 
}
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
//    if (self.choose != nil) {
//        self.navigationItem.title = @"编辑乘机人";
//    }
//    else{
//        self.navigationItem.title = @"添加乘机人";
//    }
    
    self.navigationItem.title = self.navTitleString;
    
    
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
    
    if (self.controllerType != nil) {
        self.addPersonTableView.tableFooterView = self.delBtnView;
    }
    

 
   
    if (self.passenger != nil) {
        if ([self.passenger.type isEqualToString:@"01"]) {
            passengerType = @"成人";
        }
        else{
            passengerType = @"儿童";
        }
        
        if ([self.passenger.certType isEqualToString:@"0"]) {
            
            certtype = @"0";
            passengerCertType = @"身份证";
        }
        if ([self.passenger.certType isEqualToString:@"1"]) {
            certtype = @"1";
            passengerCertType = @"护照";
        }
        else{
            certtype = @"9";
            passengerCertType = @"其他";
        }
    }

//    NSLog(@"--------------   %@",self.passenger.type);
//    
//    if ([self.passenger.type isEqualToString:@"01"]) {
//        passengerType = @"成人";
//    }
//    else{
//        passengerType = @"儿童";
//
//    }
    
    
    
        
    
    if (self.addBtnSelected) {
        passengerType = nil;
        passengerCertType = nil;
    }
    
    
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
    [_delBtnView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddPersonTableView:nil];
    [self setAddPersonSwithCell:nil];
    [self setAddPersonCoustomCell:nil];
    [self setDelBtnView:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (Default_IsUserLogin_Value) {
        return 5;
    }
    else{
        return 6;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([passengerType isEqualToString:@"成人"]) {
        
        self.delBtnView.frame = CGRectMake(0, 0, 320, 91);
        
        if (indexPath.row == 4) {
            
            return 0;
        }
        
        else{
            return 44;
        }
        
    }
    
    else  {
        
       
        self.delBtnView.frame = CGRectMake(0, 0, 320, 160);
        
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
        
        
        if (passengerType != nil) {
            
            
            if ([passengerType isEqualToString:@"成人"]) {
                if (indexPath.row == 4) {
                    cell.hidden = YES;
                }
            }
            if (indexPath.row == 0) {
                cell.secText.text = passengerType;
                cell.secText.userInteractionEnabled = NO;
            }
            if (indexPath.row == 2) {
                cell.secText.text = passengerCertType;
                cell.secText.userInteractionEnabled = NO;
            }
            
            if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
                if (self.choose != nil  || self.controllerType != nil) {
                    if (indexPath.row == 1) {
                        cell.secText.text = self.passenger.name;
                    }
                    if (indexPath.row == 3) {
                        cell.secText.text = self.passenger.certNo;
                    }
                    if (indexPath.row == 4) {
                        cell.secText.text = self.passenger.certNo;
                    }
                }
                
                cell.secText.delegate = self;
            }
            
            cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            if (self.choose == nil) {
                cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
            }
        }
     
        else
        {
           
            if ([[self.cellTextArr objectAtIndex:0] isEqualToString:@"成人"]) {
                if (indexPath.row == 4) {
                    cell.hidden = YES;
                }
            }
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.secText.enabled = NO;
            }
            cell.fristLabel.text = [self.cellTitleArr objectAtIndex:indexPath.row];
            cell.secText.placeholder = [self.cellTextArr objectAtIndex:indexPath.row];
            cell.secText.delegate = self;
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

            if (self.choose != nil || self.controllerType != nil) {
                if (indexPath.row == 0) {
                    
                    passengerType = idntity;
                }
                else{
                    passengerCertType = idntity;
                }

            }
            

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

- (IBAction)delPassenger:(id)sender {
    
//    CommonContact *contact = [[CommonContact alloc] initWithName:@"李测试" type:@"01" certType:@"0" certNo:@"555555555555555" contactId:@"2de69decad604966abbc8b802677dc82"];
//    
//    NSString *passId = @"2de69decad604966abbc8b802677dc82";
    
    LoginBusiness *bis =[[LoginBusiness alloc] init];
    
    [bis deleteCommonPassengerWithPassengerId:self.passenger.contactId userDic:nil andDelegate:self];

    
}

-(void)getDate:(void (^) (NSString * name, NSString * identity))string
{
    [blocks release];
    blocks = [string copy];
}
-(void)back
{
    //  blocks(name,identityType);
    self.passenger = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    
    AddPersonCoustomCell *cell = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    passengerName = cell.secText.text;
    
    AddPersonCoustomCell *cell1 = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    certMember = cell1.secText.text;
    
    AddPersonCoustomCell *cell2 = (AddPersonCoustomCell *)[self.addPersonTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    brithMember = cell2.secText.text;
    
    

    if ([[self.cellTextArr objectAtIndex:2] isEqualToString:@"身份证"]) {
        
        certtype = @"0";
    }
    if ([[self.cellTextArr objectAtIndex:2] isEqualToString:@"护照"]) {
        certtype = @"1";
    }
    else if ([[self.cellTextArr objectAtIndex:2] isEqualToString:@"其他"]){
        certtype = @"9";
    }
    
    NSString * passenType = [self.cellTextArr objectAtIndex:0];
    if ([passenType isEqualToString:@"成人"]) {
        passenType = @"01";
    }
    else{
        passenType = @"02";
    }
    
    LoginBusiness *bis = [[LoginBusiness alloc] init];
    
    if ([self.navTitleString isEqualToString:@"添加乘机人"]) {

        [bis addCommonPassengerWithPassengerName:passengerName
                                            type:passenType
                                        certType:certtype
                                          certNo:certMember
                                         userDic:nil
                                     andDelegate:self];
        
    }
    if ([self.navTitleString isEqualToString:@"编辑乘机人"]) {
        
        CommonContact *contact = [[CommonContact alloc] initWithName:passengerName
                                                                type:passenType
                                                            certType:certtype
                                                              certNo:certMember
                                                           contactId:self.passenger.contactId];
        
        [bis editCommonPassengerWithPassengerData:contact andDelegate:self];

    }
 

}


#pragma mark -
#pragma mark 网络错误回调的方法
//网络错误回调的方法
- (void )requestDidFailed:(NSDictionary *)info{

    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}

#pragma mark -
#pragma mark 网络返回错误信息回调的方法
//网络返回错误信息回调的方法
- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    

    NSString *meg =[info objectForKey:KEY_message];
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
}


#pragma mark -
#pragma mark 网络正确回调的方法
//网络正确回调的方法
- (void) requestDidFinishedWithRightMessage:(NSDictionary *)inf{
    
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    
    NSString *meg =@"成功";
    
    [UIQuickHelp showAlertViewWithTitle:@"温馨提醒" message:meg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    
}


@end
